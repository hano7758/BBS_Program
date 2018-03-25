<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserManager.aspx.cs" Inherits="Admin_UserManager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>威迅教育网 -- Developed by amandag</title>
    <link href="../styles/Wish.css" rel="Stylesheet"/>
    <script language="javascript" type="text/javascript">
        function chooseAll(sender) 
        {
            var inputs = document.all.tags("input");
            //遍历页面上所有的 input
            for (var i = 0; i < inputs.length; i++) 
            {
                //如果此input元素的类型为checkbox，并且其id中包含chkSelect
                if (inputs[i].type == "checkbox" && inputs[i].id.indexOf("chkSelect") >= 0) 
                {
                    //设置此复制框的checked与全选复选框相同
                    //alert("["+sender+"]");
                    inputs[i].checked = document.getElementById(sender).checked;

                  // inputs[i].onclick();
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <wish:SiteHeader ID="SiteHeader1" runat="server" />
    <div>
    </div>
    <asp:GridView ID="grvUsers" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="UserID" 
        DataSourceID="sdsUsers" PageSize="5" 
        CellPadding="4" GridLines="Horizontal" Width="762px" 
        onrowdatabound="grvUsers_RowDataBound" BackColor="White" 
        BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" 
        onrowcancelingedit="grvUsers_RowCancelingEdit" 
        onrowcreated="grvUsers_RowCreated" onrowdeleting="grvUsers_RowDeleting" 
        onrowediting="grvUsers_RowEditing" onrowupdated="grvUsers_RowUpdated">
        <Columns>

            <asp:TemplateField>
                <ItemStyle HorizontalAlign="Center" />
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkAll" runat="server" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSelect" runat="server" />
                    </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="UserID" HeaderText="用户编号" InsertVisible="False" 
                ReadOnly="True" SortExpression="UserID" >
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="UserName" HeaderText="用户名" 
                SortExpression="UserName" ReadOnly="True" />
            <asp:BoundField DataField="Nickname" HeaderText="昵称" 
                SortExpression="Nickname" ReadOnly="True" >
            <FooterStyle Wrap="True" />
            <HeaderStyle Wrap="False" />
            <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Email" SortExpression="Email">
                <ItemTemplate>
                        <a href='<%#"mailto:"+Eval("Email") %>'><%#Eval("Email") %></a>
                </ItemTemplate>
                <EditItemTemplate>
                        <asp:TextBox ID="txtEmail" runat="server" Text='<%#Bind("Email") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Question" HeaderText="提示问题" ReadOnly="True" >
            <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Answer" HeaderText="问题答案" ReadOnly="True" >
            <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="性别" SortExpression="Sex">
                <ItemTemplate>
                    <asp:Label ID="lblSex" runat="server" 
                        Text='<%# Eval("Sex").ToString()=="M"?"男":"女" %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:CheckBoxField DataField="ShowEmail" HeaderText="显示Email" 
                SortExpression="ShowEmail" Visible="False" />
            <asp:BoundField DataField="Signature" HeaderText="签名" Visible="False" 
                ReadOnly="True" />
            <asp:TemplateField HeaderText="头像" SortExpression="ImageUrl" >
                <ItemTemplate>
                    <img alt="头像" src='<%# "../"+Eval("ImageUrl") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="AddedDate" HeaderText="注册日期" 
                SortExpression="AddedDate" ReadOnly="True" >
            <HeaderStyle Wrap="False" />
            <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="ibtnEdit" runat="server" CommandName="Edit" AlternateText="编辑" ImageUrl="~/images/Command/Edit.gif"/>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:LinkButton ID="IbtnUpdate" runat="server" CommandName="Update">[<img style="border:0" src="../images/Command/Update.gif" alt="更新" />更新]</asp:LinkButton>
                    <asp:LinkButton ID="IbtnCancel" runat="server" CommandName="Cancel" CausesValidation="false">[<img style="border:0" src="../images/Command/Cancel.gif" alt="取消" />取消]</asp:LinkButton>
                </EditItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>
                 <ItemTemplate>
                    <asp:ImageButton ID="ibtnDelete" runat="server" CommandName="Delete" AlternateText="删除"
                    OnClientClick='<%# "if(!confirm(\"你确定要删除"+Eval("UserName").ToString()+"吗?\"))return false;" %>' ImageUrl="~/images/Command/Delete.gif"/>
                 </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="White" ForeColor="#333333" />
        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="White" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
    <asp:Button ID="btnDelete" runat="server" Text="删除" onclick="btnDelete_Click" 
    OnClientClick="if(!confirm('你确定要删除全部用户吗?'))return false;" 
        style="height: 21px"/>
        <asp:SqlDataSource ID="sdsUsers" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WishConnectionString %>"
            DeleteCommand="DeleteUser" DeleteCommandType="StoredProcedure" 
            SelectCommand="GetUsers" SelectCommandType="StoredProcedure" 
            UpdateCommand="UpdateUserEmail" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="UserID" Type="Int32" />
                <asp:Parameter Name="Email" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    <wish:SiteFooter ID="SiteFooter1" runat="server" />
    </form>
</body>
</html>
