using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class MyAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblMessage.Text = string.Empty;
            BindDropDownList();

            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WishConnectionString"].ToString());
            SqlCommand cmd = new SqlCommand("GetUserByID", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
            con.Open();

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                txtUser.Text = reader["UserName"].ToString();
                txtNick.Text = reader["Nickname"].ToString();
                rblSex.SelectedValue = reader["Sex"].ToString();
                dropFace.SelectedValue = reader["imageUrl"].ToString();
                imgFace.ImageUrl = reader["imageUrl"].ToString();
                rblShowEmail.SelectedValue = reader["ShowEmail"].ToString().ToLower();//
                txtSignature.Text = reader["Signature"].ToString() == "" ? "您还未填写个性签名" : (string)reader["Signature"];
                lblDate.Text = reader["AddedDate"].ToString();
            }
            con.Close();
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

    protected void btnUpdata_Click(object sender, EventArgs e)
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
                sdsUpdata.Update();
                Response.Redirect("Default.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }
    }
    protected void btnSub_Click(object sender, EventArgs e)
    {
        string pa = Server.MapPath("images/faces/");
        if (FileUpload1.HasFile)
        {
            FileUpload1.SaveAs(pa + FileUpload1.FileName);
            dropFace.Items.Add(new ListItem(FileUpload1.FileName, "images/faces/" + FileUpload1.FileName));
            dropFace.SelectedValue = "images/faces/" + FileUpload1.FileName;
            imgFace.ImageUrl = dropFace.SelectedValue;
        }
    }
}