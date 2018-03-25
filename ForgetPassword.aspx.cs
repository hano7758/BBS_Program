using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ForgetPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblNewPassword.Text = "";
        }
    }
    protected void btnNewPassword_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
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
                IDataReader reader = sdsForget.Select(DataSourceSelectArguments.Empty) as IDataReader;
                int userId = 0;
                if (reader.Read())
                {
                    userId = reader.GetInt32(0); //?
                }
                if (userId > 0)
                {
                    lblNewPassword.Text = RandomPassword();//随机生成8位数密码
                    sdsForget.UpdateParameters["Password"].DefaultValue = Tool.EncryptPassword(RandomPassword());//密码加密
                    sdsForget.UpdateParameters["UserId"].DefaultValue = userId.ToString();
                    sdsForget.Update();
                }
                else
                {
                    lblMessage.Text = "用户名不存在或提示答案错误";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }

        }
    }
    private string RandomPassword()
    {
        string password = "";
        Random rand = new Random();
        for (int i = 0; i < 8; i++)
        {
            password += rand.Next(0, 9).ToString();
        }
        return password;
    }
}