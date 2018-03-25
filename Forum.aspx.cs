using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Forum : System.Web.UI.Page
{
    private bool isAdmin = false;
    protected string forumID;

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
        //从QueryString中检查ForumID
        if (string.IsNullOrEmpty(Request.QueryString["ForumID"]))
        {
            Response.Redirect("~/default.aspx", true);
        }
        else
        {
            forumID = Request.QueryString["ForumID"];
        }
        grvForum.Columns[0].Visible = isAdmin;
        if (!IsPostBack)
        {
            DataBind();
        }
    }

    protected string GetAuthorText(object UserName, object nickName, object eMail, object showEmail)
    {
        string name = UserName.ToString() + "[" + nickName.ToString() + "]";
        if (!Convert.ToBoolean(showEmail))
        {
            return name;
        }
        else
        {
            return string.Format("<a href=\"mailto:{0}\">{1}</a>", eMail.ToString(), name);
        }
    }

    //protected void grvForum_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    //CommandArgument='<%#Eval("TopicID") %>'
    //    if (e.CommandName == "Delete")
    //    {
    //        //int id = Convert.ToInt32(e.CommandArgument);
    //        //sdsForum.DeleteParameters["TopicID"].DefaultValue = id.ToString();
    //        string strconn = System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ToString();
    //        string sql = "delete from Topics where TopicID=" + id;
    //        SqlConnection conn = new SqlConnection(strconn);
    //        SqlCommand com = new SqlCommand(sql, conn);
    //        try
    //        {
    //            conn.Open();
    //            com.ExecuteNonQuery();
    //        }
    //        catch (Exception)
    //        {

    //        }
    //        finally { conn.Close(); }
    //    }
    //}
}