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


public partial class Controls_SiteFooter : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int year = DateTime.Now.Year;
        lblCopyright.Text = "版权所有&copy;2005-" + year + "上海威迅天达软件专修学院";
    }
}
