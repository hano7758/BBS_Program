using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Admin_ListTopic : System.Web.UI.Page
{
    private bool isAdmin = false;
    public bool IsAdmin
    {
        get { return isAdmin; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        if (Session["UserName"] != null)
        {
            isAdmin = (Session["UserName"].ToString().ToLower() == "admin");
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            DataView dvResult = sdsSearch.Select(DataSourceSelectArguments.Empty) as DataView;
            if (dvResult != null)
            {
                grvResult.DataSource = dvResult;
                grvResult.DataBind();
            }
            if (grvResult.Rows.Count > 0)
            {
                lblMessage.Text = "最新：" + dvResult.Count.ToString() + "篇";
            }
            else
            {
                lblMessage.Text = "没有满足条件的记录！";
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = ex.Message;
        }
    }

    protected void grvResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //数据绑定后
        if (e.Row.RowType == DataControlRowType.Header)
        {
            CheckBox chkAll = (CheckBox)e.Row.FindControl("chkAll");
            chkAll.Attributes.Add("onclick", "chooseAll('" + chkAll.ClientID + "')");
        }
    }

    protected void grvResult_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        sdsSearch.DeleteParameters["TopicID"].DefaultValue = grvResult.DataKeys[e.RowIndex].Value.ToString();
        sdsSearch.Delete();
    }

    protected void grvResult_PageIndexChanged(object sender, EventArgs e)
    {
        grvResult.DataBind();
    }

    protected void grvResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvResult.PageIndex = e.NewPageIndex;

        DataView dvResult = sdsSearch.Select(DataSourceSelectArguments.Empty) as DataView;
        if (dvResult != null)
        {
            grvResult.DataSource = dvResult;
            grvResult.DataBind();
        }
    }
    protected void btnStrar_Click(object sender, EventArgs e)
    {
        txtStart.Text = dropStrar.Value.ToString();
    }
    protected void btnEnd_Click(object sender, EventArgs e)
    {
        txtEnd.Text = dropEnd.Value.ToString();
    }
    protected void dropCategories_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (dropCategories.SelectedIndex == 0)
        {
            dropForums.Visible = false;
        }
        else
        {
            dropForums.Visible = true;
        }
    }
}