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
using System.Data.SqlClient;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        txtUserName.Focus();
        if (!IsPostBack)
        {
            if (Request.UrlReferrer != null)
            {
                ViewState["ReferrerUrl"] = Request.UrlReferrer.ToString();
            }
        }
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            lblMessage.Text = string.Empty;

            if (Request.Cookies["CheckCode"] == null)
            {
                lblMessage.Text = "您的浏览器设置已被禁用Cookies，请设置浏览器允许使用Coolies";
                return;
            }

            if (string.Compare(Request.Cookies["CheckCode"].Value, txtCheckCode.Text, true) != 0)
            {
                lblMessage.Text = "验证码错误，请输入正确的验证码";
                return;
            }

            try
            {
                sdsLogin.SelectParameters["CryptPassword"].DefaultValue = Tool.EncryptPassword(txtPassword.Text.Trim());

                IDataReader reader = sdsLogin.Select(DataSourceSelectArguments.Empty) as IDataReader;

                int userId = 0;

                if (reader.Read())
                {
                    userId = reader.GetInt32(0); //?
                }
                
                if (userId > 0)
                {
                    HttpCookie myCookie = new HttpCookie("Login");
                    myCookie.Values["UserName"] = txtUserName.Text.Trim();
                    myCookie.Values["Password"] = Tool.EncryptPassword(txtPassword.Text.Trim());

                    myCookie.Expires = DateTime.Now.AddDays(Convert.ToDouble(dropRemember.SelectedValue));
                    Response.Cookies.Add(myCookie);

                    Session["UserName"] = txtUserName.Text.Trim();
                    Session["UserID"] = userId;

                    if (ViewState["ReferrerUrl"] != null)
                    {
                        Response.Redirect(ViewState["ReferrerUrl"].ToString());
                    }
                    else
                    {
                        Response.Redirect("default.aspx");
                    }
                }
                else
                {
                    lblMessage.Text = "用户名或密码不正确";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }

        }
    }
}
