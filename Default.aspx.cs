using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.IO;

public partial class _Default : System.Web.UI.Page
{
    private bool isAdmin = false;
    public bool IsAdmin
    {
        get { return isAdmin; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lblCategoryHeader.Text = string.Empty;
        if (Session["UserName"] != null)
        {
            isAdmin = (Session["UserName"].ToString().ToLower() == "admin");
        }
        if (!IsPostBack)
        {
            BindDropDownList();
            guanli.DataBind();
        }
    }

    protected void dlstCategories_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        SqlDataSource sdsForums;
        if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
        {
            sdsForums = e.Item.FindControl("sdsForums") as SqlDataSource;
            if (sdsForums != null)
            {
                sdsForums.SelectParameters["CategoryID"].DefaultValue = dlstCategories.DataKeys[e.Item.ItemIndex].ToString();
            }
            if (!isAdmin)
            {
                GridView grvForums = e.Item.FindControl("grvForums") as GridView;
                if (grvForums != null)
                {
                    grvForums.Columns[0].Visible = false;
                    grvForums.Columns[1].Visible = false;
                }
            }
        }
    }

    protected void dlstCategories_DeleteCommand(object source, DataListCommandEventArgs e)
    {
        //删除版区
        sdsCategories.DeleteParameters["CategoryID"].DefaultValue = dlstCategories.DataKeys[e.Item.ItemIndex].ToString();
        sdsCategories.Delete();
    }

    protected void dlstCategories_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "NewCategory")
        {
            //显示添加版区面板
            lblCategoryHeader.Text = "添加版区";
            txtCategoryName.Text = string.Empty;
            //dropForumPicture.Text = string.Empty;
            //txtCategoryImageUrl.Text = string.Empty;
            InsertCategoryPosition();
            txtCategoryIDCurr.Text = string.Empty;
            pnlCategory.Visible = true;
        }
        else if (e.CommandName == "NewForum")
        {
            lblCategoryHeader.Text = "添加论坛";
            txtForumCategoryCurr.Text = string.Empty;
            txtForumIDCurr.Text = string.Empty;
            txtForumName.Text = string.Empty;
            txtForumDescription.Text = string.Empty;
            InsertForumPosition();
            //txtForumPosition.Text = string.Empty;
            pnlCategory.Visible = false;
            pnlForum.Visible = true;
        }
    }

    protected void dlstCategories_EditCommand(object source, DataListCommandEventArgs e)
    {
        SqlConnection cn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand("GetCategoryDetails", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CategoryID", (int)dlstCategories.DataKeys[e.Item.ItemIndex]);
        cn.Open();
        SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        if (dr.Read())
        {
            UpdateCategoryPosition();
            lblCategoryHeader.Text = "编辑版区";
            txtCategoryName.Text = dr["CategoryName"].ToString();
            dropForumPicture.SelectedValue = dr["CategoryImageUrl"].ToString();
            dropCategoryPosition.SelectedValue=dr["CategoryPosition"].ToString();
            txtCategoryIDCurr.Text = dr["CategoryID"].ToString();
        }
        cn.Close();

        pnlCategory.Visible = true;
    }

    protected void lbtnSubmitCategory_Click(object sender, EventArgs e)
    {
        //int categoryPos = (txtCategoryPosition.Text.Length > 0 ? int.Parse(txtCategoryPosition.Text) : 0);

        if (txtCategoryIDCurr.Text.Length == 0)
        {
            //添加版区
            sdsCategories.Insert();
        }
        else
        {
            //编辑版区
            sdsCategories.Update();
        }
        pnlCategory.Visible = false;
    }

    protected void lbtnCancelCategory_Click(object sender, EventArgs e)
    {
        pnlCategory.Visible = false;
    }

    protected void lbtnSubmitForum_Click(object sender, EventArgs e)
    {
        //SqlDataSource sdsForums = dlstCategories.Items[0].FindControl("sdsForums") as SqlDataSource;
        if (txtForumIDCurr.Text.Length == 0)
        {
            //添加论坛
            Response.Write(txtForumIDCurr.Text + "插入");
            sdsForum.Insert();
        }
        else
        {
            //编辑论坛
            Response.Write(txtForumIDCurr.Text + "更新");
            sdsForum.Update();
        }
        dlstCategories.DataBind();
        pnlForum.Visible = false;
    }

    protected void lbtnCancelForum_Click(object sender, EventArgs e)
    {
        pnlForum.Visible = false;
    }

    protected void grvForums_RowEditing(object sender, GridViewEditEventArgs e)
    {
        SqlConnection cn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand("GetForumsDetails", cn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@ForumID", (int)((GridView)sender).DataKeys[e.NewEditIndex].Value);
        cn.Open();
        SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        if (dr.Read())
        {
            lblCategoryHeader.Text = "编辑论坛";
            dropForumCategory.DataSourceID = sdsCategories.UniqueID;//????
            dropForumCategory.DataTextField = "CategoryName";
            dropForumCategory.DataValueField = "CategoryID";
            dropForumCategory.DataBind();
            dropForumCategory.SelectedIndex = dropForumCategory.Items.IndexOf(dropForumCategory.Items.FindByText(dr["CategoryName"].ToString()));

            UpdateForumPosition();
            txtForumCategoryCurr.Text = dr["CategoryID"].ToString();
            txtForumIDCurr.Text = dr["ForumID"].ToString();
            txtForumName.Text = dr["ForumName"].ToString();
            txtForumDescription.Text = dr["ForumDescription"].ToString();
            dropForumPosition.SelectedValue = dr["ForumPosition"].ToString();
            //txtForumPosition.Text = dr["ForumPosition"].ToString();
        }
        cn.Close();
        pnlForum.Visible = true;
    }

    protected void InsertCategoryPosition()
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ConnectionString);
        string sql = "select count(*) from Categories";
        SqlCommand cmd = new SqlCommand(sql, conn);
        conn.Open();

        dropCategoryPosition.Items.Clear();
        int count = Convert.ToInt32(cmd.ExecuteScalar()) + 1;
        for (int i = 1; i <= count; i++)
        {
            dropCategoryPosition.Items.Add(new ListItem(i.ToString()));
        }
        conn.Close();
    }

    protected void InsertForumPosition()
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ConnectionString);
        string sql = "select count(*) from Forums";
        SqlCommand cmd = new SqlCommand(sql, conn);
        conn.Open();

        dropForumPosition.Items.Clear();
        int count = Convert.ToInt32(cmd.ExecuteScalar()) + 1;
        for (int i = 1; i <= count; i++)
        {
            dropForumPosition.Items.Add(new ListItem(i.ToString()));
        }
        conn.Close();
    }

    protected void UpdateCategoryPosition()
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ConnectionString);
        string sql = "select count(*) from Categories";
        SqlCommand cmd = new SqlCommand(sql, conn);
        conn.Open();

        dropCategoryPosition.Items.Clear();
        int count = Convert.ToInt32(cmd.ExecuteScalar());
        for (int i = 1; i <= count; i++)
        {
            dropCategoryPosition.Items.Add(new ListItem(i.ToString()));
        }
        conn.Close();
    }

    protected void UpdateForumPosition()
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ConnectionString);
        string sql = "select count(*) from Forums";
        SqlCommand cmd = new SqlCommand(sql, conn);
        conn.Open();

        dropForumPosition.Items.Clear();
        int count = Convert.ToInt32(cmd.ExecuteScalar());
        for (int i = 1; i <= count; i++)
        {
            dropForumPosition.Items.Add(new ListItem(i.ToString()));
        }
        conn.Close();
    }

    protected void btnSub_Click(object sender, EventArgs e)
    {
        string pa = Server.MapPath("images/Forums/");
        if (FileUpload1.HasFile)
        {
            FileUpload1.SaveAs(pa + FileUpload1.FileName);
            dropForumPicture.Items.Add(new ListItem(FileUpload1.FileName, "images/Forums/" + FileUpload1.FileName));
            dropForumPicture.SelectedValue = "images/Forums/" + FileUpload1.FileName;
            imgFace.ImageUrl = dropForumPicture.SelectedValue;
        }
    }

    private void BindDropDownList()
    {
        DirectoryInfo di = new DirectoryInfo(Server.MapPath("images/Forums/"));
        FileInfo[] fi = di.GetFiles("*.*");
        foreach (FileInfo f in fi)
        {
            dropForumPicture.Items.Add(new ListItem(f.Name, "images/Forums/" + f.Name));
        }
        dropForumPicture.Attributes.Add("onchange", "document.getElementById('imgFace').src=document.getElementById('" + dropForumPicture.ClientID + "').value");
        
    }
}