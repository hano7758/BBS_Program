using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class Controls_SiteHeader : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblGreeting.Text = "欢迎您，";

        if (Session["UserName"] != null)
        {
            lblGreeting.Text += "<b>[" + Session["UserName"].ToString() + "]";
            lnkUser.Text = "我的账户";
            lnkUser.NavigateUrl = "~/MyAccount.aspx";
            lbtnSignOut.Visible = true;
        }
        else
        {
            lblGreeting.Text += "您未登录";
            lnkUser.Text = "[用户登录]";
            lnkUser.NavigateUrl = "~/Login.aspx";
            lbtnSignOut.Visible = false;
        }
    }

    protected void lbtnSignOut_Click(object sender, EventArgs e)
    {
        if (Session["UserName"] != null)
        {
            Session.Abandon();
            HttpCookie myCookie = Request.Cookies["Login"];
            if (myCookie != null)
            {
                myCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(myCookie);
            }
        }
        Response.Redirect("~/Default.aspx");
    }
}
