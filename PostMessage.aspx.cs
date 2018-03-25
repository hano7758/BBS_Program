using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class PostMessage : System.Web.UI.Page
{
    private int forumID;
    private int topicID;
    private int replyID;
    private int quoteReplyID;
    private int quoteTopicID;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserName"] == null)
        {
            Response.Redirect("Login.aspx", true);
        }

        if (Request.QueryString["ForumID"] == null)
            forumID = -1;
        else
            forumID = int.Parse(Request.QueryString["ForumID"]);

        if (Request.QueryString["TopicID"] == null)
            topicID = -1;
        else
            topicID = int.Parse(Request.QueryString["TopicID"]);

        if (Request.QueryString["ReplyID"] == null)
            replyID = -1;
        else
            replyID = int.Parse(Request.QueryString["ReplyID"]);

        if (Request.QueryString["quoteReplyID"] == null)
            quoteReplyID = -1;
        else
            quoteReplyID = int.Parse(Request.QueryString["quoteReplyID"]);

        if (Request.QueryString["quoteTopicID"] == null)
            quoteTopicID = -1;
        else
            quoteTopicID = int.Parse(Request.QueryString["quoteTopicID"]);

        if (!IsPostBack)
        {
            if (Request.UrlReferrer == null)
            {
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                ViewState["ReferrerUrl"] = Request.UrlReferrer.ToString();
            }
            switch (Request.QueryString["Action"].ToString().ToLower())
            {
                case "newtopic":
                    lblMessageHeader.Text = "新主题";
                    break;
                case "newreply":
                    lblMessageHeader.Text = "新回复";
                    lblSubject.Visible = false;
                    txtSubject.Visible = false;

                    if (quoteReplyID != -1)
                    {
                        sdsGetReplyMessage.SelectParameters["ReplyID"].DefaultValue = quoteReplyID.ToString();
                        DataView sdsReply = (DataView)sdsGetReplyMessage.Select(new DataSourceSelectArguments());
                        //txtMessage.Text = "<blockquote>" + "引用自[" + sdsReply[0]["NickName"].ToString() + "]发表的" + sdsReply[0]["Message"].ToString() + "</blockquote>";
                        txtMessage.Text = "<div class='quote'>" + "引用" + sdsReply[0]["NickName"].ToString() + "发表的" + sdsReply[0]["Message"].ToString() + "</div>";
                    }
                    if (quoteTopicID != -1)
                    {
                        sdsGetTopicMessage.SelectParameters["TopicID"].DefaultValue = quoteTopicID.ToString();
                        DataView sdsTopic = (DataView)sdsGetTopicMessage.Select(new DataSourceSelectArguments());
                        //DataView 相当于DataTable
                        //txtMessage.Text = "<blockquote>" + sdsTopic[0]["Message"].ToString() + "</blockquote>";
                        txtMessage.Text = "<div class='quote'>" + "引用" + sdsTopic[0]["NickName"].ToString() + "发表的" + sdsTopic[0]["Message"].ToString() + "</div>";
                    }
                    break;
            }
        }
    }

    protected void ibtnSubmitMessage_Click(object sender, EventArgs e)
    {
        int userID = 0;
        SqlConnection cn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand("GetUserIDByUserName", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserName", Session["UserName"].ToString());
        try
        {
            cn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader != null)
            {
                if (reader.Read())
                {
                    userID = reader.GetInt32(0);
                }
            }
        }
        catch (Exception)
        {
        }
        finally
        {
            cn.Close();
        }

        switch (Request.QueryString["Action"].ToString().ToLower())
        {
            case "newtopic":
                SqlConnection cnNewTopic = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ToString());
                SqlCommand cmdNewTopic = new SqlCommand("InsertTopic", cnNewTopic);
                try
                {
                    cmdNewTopic.CommandType = CommandType.StoredProcedure;
                    cmdNewTopic.Parameters.AddWithValue("@ForumID", forumID);
                    cmdNewTopic.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
                    cmdNewTopic.Parameters.AddWithValue("@Message", Tool.ProcessTags(txtMessage.Text.Trim()));
                    cmdNewTopic.Parameters.AddWithValue("@UserID", userID);
                    cmdNewTopic.Parameters.AddWithValue("@UserIP", Request.UserHostAddress);
                    cmdNewTopic.Parameters.Add("@TopicID", SqlDbType.Int, 4).Direction = ParameterDirection.Output;

                    cnNewTopic.Open();
                    cmdNewTopic.ExecuteNonQuery();
                }
                catch (Exception) { }
                finally
                {
                    cnNewTopic.Close();
                }

                int newID = (int)cmdNewTopic.Parameters["@TopicID"].Value;
                Response.Redirect("Topic.aspx?TopicID=" + newID.ToString(), true);
                break;

            case "newreply":
                SqlConnection cnNewReply = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ToString());
                SqlCommand cmdNewReply = new SqlCommand("InsertReply", cnNewReply);
                try
                {
                    cmdNewReply.CommandType = CommandType.StoredProcedure;
                    cmdNewReply.Parameters.AddWithValue("@ForumID", forumID);
                    cmdNewReply.Parameters.AddWithValue("@TopicID", topicID);
                    cmdNewReply.Parameters.AddWithValue("@Message", Tool.ProcessTags(txtMessage.Text.Trim()));
                    cmdNewReply.Parameters.AddWithValue("@UserID", userID);
                    cmdNewReply.Parameters.AddWithValue("@UserIP", Request.UserHostAddress);
                    cmdNewReply.Parameters.Add("@ReplyID", SqlDbType.Int, 4).Direction = ParameterDirection.Output;

                    cnNewReply.Open();
                    cmdNewReply.ExecuteNonQuery();
                }
                catch (Exception) { }
                finally
                {
                    cnNewReply.Close();
                }
                int newID2 = (int)cmdNewReply.Parameters["@TopicID"].Value;
                Response.Redirect("Topic.aspx?TopicID=" + newID2.ToString(), true);
                break;
        }

        Response.Redirect(ViewState["ReferrerUrl"].ToString());
    }

    protected void lbtnCancelMessage_Click(object sender, EventArgs e)
    {
        Response.Redirect(ViewState["ReferrerUrl"].ToString());
    }
}