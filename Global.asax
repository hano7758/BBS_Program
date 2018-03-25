<%@ Application Language="C#" %>

<script runat="server">
    
    void Application_Start(object sender, EventArgs e) 
    {
        //在应用程序启动时运行的代码

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //在应用程序关闭时运行的代码

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        //在出现未处理的错误时运行的代码

    }

    void Session_Start(object sender, EventArgs e) 
    {
        //在新会话启动时运行的代码
        if (Session["UserName"] == null)
        {
            HttpCookie myCookie = Request.Cookies["Login"];
            if (myCookie != null && myCookie.Values["UserName"] != null && myCookie.Values["Password"] != null)
            {
                System.Data.SqlClient.SqlConnection cn = new System.Data.SqlClient.SqlConnection("Password=sa;Persist Security Info=True;User ID=sa;Initial Catalog=Wish;Data Source=SUNCHENHAO");
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("ValidateLogin", cn);

                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserName", myCookie.Values["UserName"]);
                cmd.Parameters.AddWithValue("@CryptPassword", myCookie.Values["Password"]);

                int userId = 0;

                try
                {
                    cn.Open();
                    object o = cmd.ExecuteScalar();

                    if (o != null)
                    {
                        userId = Convert.ToInt32(o);
                    }
                }
                catch (Exception)
                {
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }

                    if (userId > 0)
                    {
                        Session["UserName"] = myCookie.Values["UserName"]; 
                    }
                }
            }
             
        }

    }

    void Session_End(object sender, EventArgs e) 
    {
        //在会话结束时运行的代码。 
        // 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为
        // InProc 时，才会引发 Session_End 事件。如果会话模式 
        //设置为 StateServer 或 SQLServer，则不会引发该事件。

    }
       
</script>
