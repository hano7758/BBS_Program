using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_UserManager : System.Web.UI.Page
{
    private bool isAdmin = false;
    public bool IsAdmin
    {
        get { return isAdmin; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        string script = "function HighlightSelected(chkSelect){ if (chkSelect.checked)   chkSelect.parentElement.parentElement.style.backgroundColor='#E6F5FA';else chkSelect.parentElement.parentElement.style.backgroundColor='white';}";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "RowDataBoundScript", script, true);
        if (Session["UserName"] != null)
        {
            isAdmin = (Session["UserName"].ToString().ToLower() == "admin");
        }
    }

    protected void grvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            CheckBox chkAll = (CheckBox)e.Row.FindControl("chkAll");
            chkAll.Attributes.Add("onclick", "chooseAll('" + chkAll.ClientID + "')");
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
            chkSelect.Attributes.Add("onclick", "HighlightSelected(this);");
            //鼠标经过时，行背景色变
            //e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#E6F5FA'");
            //鼠标移出时，行背景色变
            //e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#FFFFFF'");
        }
    }

    protected void grvUsers_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (grvUsers.Rows[e.NewEditIndex].Cells[1].Text.ToLower() == "admin")
        {
            //取消编辑
            e.Cancel = true;
        }
        else
        {
            //编辑状态时隐藏Footer
            grvUsers.ShowFooter = true;
            grvUsers.Columns[4].FooterText = "可编辑";
            grvUsers.Columns[4].FooterStyle.ForeColor = System.Drawing.Color.Red;
        }
    }

    protected void grvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        //取消编辑时隐藏Footer
        grvUsers.ShowFooter = false;
    }

    protected void grvUsers_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        //更新完毕时隐藏
        grvUsers.ShowFooter = false;
    }

    protected void grvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (grvUsers.Rows[e.RowIndex].Cells[2].Text.ToLower() == "admin")
        {
            //取消删除
            e.Cancel = true;
        }
    }

    protected void grvUsers_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label lblSort = new Label();
            lblSort.EnableTheming = false;
            lblSort.Font.Name = "webdings";
            lblSort.Font.Size = FontUnit.Small;
            lblSort.Text = (grvUsers.SortDirection == SortDirection.Ascending ? "5" : "6");

            for (int i = 0; i < grvUsers.Columns.Count; i++)
            {
                string colExpr = grvUsers.Columns[i].SortExpression;
                if (colExpr != "" && colExpr == grvUsers.SortExpression)
                    e.Row.Cells[i].Controls.Add(lblSort);
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        CheckBox chk;
        //遍历chkSelect控件
        foreach (GridViewRow gvr in grvUsers.Rows)
        {
            //查找chkSelect控件
            chk = gvr.FindControl("chkSelect") as CheckBox;
            //如果找到并且其为选中状态
            if (chk != null && chk.Checked && grvUsers.Rows[gvr.RowIndex].Cells[2].Text.ToLower() == "admin")
            {
                //执行删除功能
                sdsUsers.DeleteParameters["UserID"].DefaultValue = grvUsers.DataKeys[gvr.RowIndex].Value.ToString();
                sdsUsers.Delete();
            }
        }
    }
}