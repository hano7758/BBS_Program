using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        if (!IsPostBack)
        {
            BindDropDownList();
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
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
                sdsRegister.InsertParameters["Password"].DefaultValue = Tool.EncryptPassword(txtPassword1.Text.Trim());
                sdsRegister.Insert();
                Response.Redirect("Default.aspx");
            }
            catch (SqlException se)
            {
                if (se.Number == 2627)
                {
                    lblMessage.Text = "账户已存在!";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
    }

    private void BindDropDownList()
    {
        DirectoryInfo di = new DirectoryInfo(Server.MapPath("images/faces/"));
        FileInfo[] fi = di.GetFiles("*.bmp");
        foreach (FileInfo f in fi)
        {
            dropFace.Items.Add(new ListItem(f.Name, "images/faces/" + f.Name));
        }
        dropFace.Attributes.Add("onchange", "document.getElementById('imgFace').src=document.getElementById('" + dropFace.ClientID + "').value");
    }
}