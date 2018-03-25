using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Topic : System.Web.UI.Page
{
    private bool isAdmin = false;
    protected string topicID;
    protected string forumID;
    private int curPage;

    protected int CurPage
    {
        get { return curPage; }
        set { curPage = value; }
    }

    public bool IsAdmin
    {
        get { return isAdmin; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserName"] != null)
        {
            isAdmin = (Session["UserName"].ToString().ToLower() == "admin");
        }
        if (string.IsNullOrEmpty(Request.QueryString["TopicID"]))
        {
            Response.Redirect("~/Default.aspx", true);
        }
        else
        {
            topicID = Request.QueryString["topicID"];
        }

        if (!IsPostBack)
        {
            BindTopic();
            PageIndex();
        }
    }

    protected void BindTopic()
    {
        SqlConnection cn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand("GetTopicDetails", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@TopicID", SqlDbType.Int, 4).Value = Convert.ToInt32(topicID);

        cn.Open();
        SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        if (dr.Read())
        {
            string userName = dr["UserName"].ToString();
            lblTopicAuthor.Text = GetAuthorText(userName, dr["NickName"].ToString(), dr["Email"], dr["ShowEmail"]);
            imgTopicAuthor.ImageUrl = dr["ImageUrl"].ToString();
            imgTopicAuthor.Visible = (dr["ImageUrl"].ToString().Length > 0);
            lblTopicDate.Text = string.Format("{0:MM/dd/yy}", Convert.ToDateTime(dr["AddedDate"]));
            lblTopicTime.Text = string.Format("{0:HH:mm:ss tt}", Convert.ToDateTime(dr["AddedDate"]));
            lblUserIP.Text = dr["UserIP"].ToString();
            lblTopicSubject.Text = dr["Subject"].ToString();
            lblTopicMessage.Text = Tool.ProcessTags(dr["Message"].ToString());
            lblTopicAuthorSignature.Text = Tool.ProcessTags(dr["Signature"].ToString());

            forumID = dr["ForumID"].ToString();

            lnkNewTopic.NavigateUrl += forumID;
            lnkNewReply.NavigateUrl += forumID + "&TopicID=" + topicID;
            lnkQuoteSubject.NavigateUrl += "PostMessage.aspx?Action=NewReply" + "&ForumID=" + forumID + "&TopicID=" + topicID + "&QuoteTopicID=" + topicID;

            lnkNewTopicBottom.NavigateUrl = lnkNewTopic.NavigateUrl;
            lnkNewReplyBottom.NavigateUrl = lnkNewReply.NavigateUrl;

            lbtnDeleteTopic.DataBind();
            lblUserIP.DataBind();
        }
        cn.Close();
    }

    protected string GetAuthorText(object UserName, object nickName, object eMail, object showEmail)
    {
        string name = UserName.ToString() + "<br/>[" + nickName.ToString() + "]";
        if (!Convert.ToBoolean(showEmail))
        {
            return name;
        }
        else
        {
            return string.Format("<a href=\"mailto:{0}\">{1}</a>", eMail.ToString(), name);
        }
    }

    protected void lbtnDeleteTopic_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("DeleteTopics", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@TopicID", topicID);

        try
        {
            conn.Open();
            if (cmd.ExecuteNonQuery() == 1)
            {
                Response.Redirect("Topic.aspx");
            }
        }
        catch (Exception)
        { }
        finally
        {
            conn.Close();
        }
    }

    protected void dlstReplies_DeleteCommand(object source, DataListCommandEventArgs e)
    {
        //删除回复
        sdsGetReplies.DeleteParameters["replyID"].DefaultValue = dlstReplies.DataKeys[e.Item.ItemIndex].ToString();
        sdsGetReplies.Delete();
    }

    protected void PageIndex()
    {
        PagedDataSource ps = new PagedDataSource();
        ps.DataSource = this.sdsGetReplies.Select(new DataSourceSelectArguments());
        ps.AllowPaging = true; //设置允许分页
        ps.PageSize = 5; //设置分页数

        CurPage = Convert.ToInt32(lblPage.Text); //设置当前页码
        ps.CurrentPageIndex = CurPage - 1; //设置索引


        lnkbtnFirst.Visible = true; //显式标签
        lnkbtnUp.Visible = true;
        lnkbtnNext.Visible = true;
        //lnkbtnLast.Visible = true;

        if (CurPage == 1) //如果只有一个页面
        {
            lnkbtnFirst.Visible = false;//不显示第一页
            lnkbtnUp.Visible = false;//不显示上一页
        }
        if (ps.IsLastPage)
        {
            lnkbtnNext.Visible = false;//不显示下一页
            //lnkbtnLast.Visible = false;//不显示最后一页
        }
        dlstReplies.DataSourceID = ""; //重新绑定数据
        dlstReplies.DataSource = ps; //编写DataList的数据源
        dlstReplies.DataBind(); //绑定数据源
    }

    protected void lnkbtnFirst_Click(object sender, EventArgs e)
    {
        lblPage.Text = "1";
        PageIndex();
    }

    protected void lnkbtnUp_Click(object sender, EventArgs e)
    {
        lblPage.Text = (Convert.ToInt32(lblPage.Text) - 1).ToString();
        PageIndex();
    }

    protected void lnkbtnNext_Click(object sender, EventArgs e)
    {
        lblPage.Text = (Convert.ToInt32(lblPage.Text) + 1).ToString();
        PageIndex();
    }
}