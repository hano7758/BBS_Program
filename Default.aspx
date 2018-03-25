<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
    <style type="text/css">
        .style1
        {
            width: 78%;
        }
        .style3
        {
        }
        .style4
        {
            width: 100%;
        }
        .style5
        {
            width: 109px;
        }
        .style6
        {
            width: 110px;
        }
    </style>
    <link  href="styles/Wish.css" rel="Stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <table class="style1">
        <tr>
            <td class="style3">
                <wish:SiteHeader ID="SiteHeader1" runat="server" />
                </td>
        </tr>
    </table>
    <b><asp:Label ID="lblCategoryHeader" runat="server" Text="Label"></asp:Label></b>
    <asp:Panel ID="pnlCategory" runat="server" Width="50%" Visible="False">
    <br />
        <table class="style4" style="border:1">
            <tr>
                <td class="style5">
                    版区名</td>
                <td>
                    <asp:TextBox ID="txtCategoryName" runat="server" Width="95%"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="txtCategoryIDCurr" runat="server" Visible="False" Width="0px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style5">
                    图像位置</td>
                <td>
                    <asp:DropDownList ID="dropForumPicture" runat="server" ValidationGroup="shang" ></asp:DropDownList>
                     <asp:Image ID="imgFace" runat="server" Height="33px" Width="43px" />
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                    <asp:Button ID="btnSub" runat="server" onclick="btnSub_Click" Text="上传" />
                </td>
            </tr>
            <tr>
                <td class="style5">
                    版区位置</td>
                <td>                    
                    <asp:DropDownList ID="dropCategoryPosition" runat="server"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style5">
                    &nbsp;</td>
                <td style="text-align: right">
                    <asp:LinkButton ID="lbtnSubmitCategory" runat="server" 
                        onclick="lbtnSubmitCategory_Click">
                    [<img style="border:0" src="images/Command/Update.gif" alt="提交"/>提交]
                    </asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="lbtnCancelCategory" runat="server" 
                        CausesValidation="False" onclick="lbtnCancelCategory_Click">
                         [<img style="border:0" src="images/Command/Cancel.gif" alt="取消"/>取消]
                        </asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlForum" runat="server" Width="50%" Visible="False">
        <table class="style4">
            <tr>
                <td class="style6">
                    所属版区</td>
                <td>
                    <asp:DropDownList ID="dropForumCategory" runat="server" 
                        DataSourceID="sdsCategories" DataTextField="CategoryName" 
                        DataValueField="CategoryID" Width="50%">
                    </asp:DropDownList>
                    <asp:TextBox ID="txtForumCategoryCurr" runat="server" Visible="False" Width="0px"></asp:TextBox>
                    <asp:TextBox ID="txtForumIDCurr" runat="server" Visible="False" Width="0px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style6">
                    论坛名</td>
                <td>
                    <asp:TextBox ID="txtForumName" runat="server" Width="95%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style6">
                    论坛描述</td>
                <td>
                    <asp:TextBox ID="txtForumDescription" runat="server" MaxLength="250" Rows="3" 
                        TextMode="MultiLine" Width="95%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style6">
                    论坛位置</td>
                <td>
                    <asp:DropDownList ID="dropForumPosition" runat="server"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style6">
                    &nbsp;</td>
                <td style="text-align: right">
                    <asp:LinkButton ID="lbtnSubmitForum" runat="server" 
                        onclick="lbtnSubmitForum_Click">
                    [<img style="border:0" src="images/Command/Update.gif" alt="提交"/>提交]
                    </asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="lbtnCancelForum" runat="server" 
                        CausesValidation="False" onclick="lbtnCancelForum_Click">
                         [<img style="border:0" src="images/Command/Cancel.gif" alt="取消"/>取消]
                        </asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <table style="width:100%; border:0">
        <tr>
            <td>
                本网站为<b>上海威迅教育</b>ASP.NET教程学习使用
            </td>
            <td style="text-align: right">
                <asp:HyperLink runat="server" NavigateUrl="~/Admin/UserManager.aspx" ID="guanli" Visible="<%# IsAdmin %>"  >用户管理</asp:HyperLink>
                &nbsp;
                <asp:HyperLink runat="server" NavigateUrl="~/Admin/ListTopic.aspx" ID="sousuo" >搜索帖子</asp:HyperLink>
            </td>
        </tr>
       
    </table>
    <asp:DataList  ID="dlstCategories" runat="server" DataKeyField="CategoryID" 
    DataSourceID="sdsCategories" onitemdatabound="dlstCategories_ItemDataBound" 
        Width="100%" BackColor="White" BorderColor="#3366CC" BorderStyle="None" 
        BorderWidth="1px" CellPadding="4" GridLines="Both" 
        ondeletecommand="dlstCategories_DeleteCommand" 
        oneditcommand="dlstCategories_EditCommand" 
        onitemcommand="dlstCategories_ItemCommand">
        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        <HeaderTemplate>
            <asp:Table runat="server" Width="100%" BorderWidth="1" ID="Table1">
                <asp:TableRow>
                    <asp:TableCell Width="16px" Visible='<%# IsAdmin %>'>
                        <asp:ImageButton runat="server" Visible='<%#IsAdmin%>'
                        ImageUrl="~/images/Forums/FolderNew.gif" AlternateText="创建版区" BorderWidth="0"
                        ID="ibtnNewCategory" CommandName="NewCategory" CausesValidation="false" />
                    </asp:TableCell>
                    <asp:TableCell Width="16px" Visible='<%#IsAdmin%>'>
                        <asp:ImageButton runat="server" Visible='<%#IsAdmin%>'
                        ImageUrl="~/images/Forums/Folder.gif" AlternateText="创建论坛" BorderWidth="0"
                        ID="ibtnNewForum" CommandName="NewForum" CausesValidation="false" />
                    </asp:TableCell>
                    <asp:TableCell Width="32px">&nbsp;&nbsp;</asp:TableCell>
                    <asp:TableCell>论坛</asp:TableCell>
                    <asp:TableCell Width="60px" HorizontalAlign="Center">主题</asp:TableCell>
                    <asp:TableCell Width="60px" HorizontalAlign="Center">回复</asp:TableCell>
                    <asp:TableCell Width="90px" HorizontalAlign="Center">最后回复</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </HeaderTemplate>

        <ItemTemplate>
            <asp:Table runat="server" Width="100%" ID="Table2">
                <asp:TableRow>
                    <asp:TableCell Width="16px" Visible="<%# IsAdmin %>">
                        <asp:ImageButton ID="ibtnEditCategory" Visible="<%# IsAdmin %>" runat="server"
                         CommandName="Edit" ImageUrl="~/images/Command/Edit.gif" AlternateText="编辑版区"
                          BorderWidth="0"/></asp:TableCell>
                <asp:TableCell Width="16px" Visible="<%# IsAdmin %>">
                        <asp:ImageButton ID="ibtnDeleteCategory" Visible="<%# IsAdmin %>" runat="server"
                         CommandName="Delete" ImageUrl="~/images/Command/Delete.gif" AlternateText="删除版区"
                         OnClientClick='<%# "if(!confirm(\"你确定要删除此版区吗?\"))return false;" %>'
                          BorderWidth="0"/></asp:TableCell>
                          <asp:TableCell Width="32px" HorizontalAlign="Center">
                                <img src='<%#Eval("CategoryImageUrl") %>' style="border:0" alt='<%#Eval("CategoryName") %>' />
                          </asp:TableCell>
                          <asp:TableCell><%#Eval("CategoryName")%></asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:GridView ID="grvForums" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="ForumID" DataSourceID="sdsForums" Width="100%" 
                ShowHeader="False" onrowediting="grvForums_RowEditing">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton runat="server" CommandName="Edit" 
                            Visible='<%#IsAdmin %>' ImageUrl="~/images/Command/Edit.gif" AlternateText="编辑论坛"
                             BorderWidth="0" ID="ibtnEditForum" />
                        </ItemTemplate>
                        <ItemStyle Width="16px" HorizontalAlign="Center"/>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton runat="server" CommandName="Delete" 
                            Visible='<%#IsAdmin %>' ImageUrl="~/images/Command/Delete.gif" AlternateText="删除论坛"
                            OnClientClick='<%# "if(!confirm(\"你确定要删除此论坛吗?\"))return false;" %>'
                             BorderWidth="0" ID="ibtnDeleteForum"/>
                        </ItemTemplate>
                        <ItemStyle Width="16px" HorizontalAlign="Center"/>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <img style="border:0" src="images/Forums/Folder.gif" alt='<%#Eval("ForumName") %>'/>
                        </ItemTemplate>
                        <ItemStyle Width="32px" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <a href='<%#"Forum.aspx?ForumID="+Eval("ForumID") %>'>
                                <b><%# Eval("ForumName") %></b>
                            </a><br />
                            <%#Eval("ForumDescription") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ForumTopics" ReadOnly="true" SortExpression="FormTopics">
                        <ItemStyle Width="60px" HorizontalAlign="Center"/>
                    </asp:BoundField>
                    <asp:BoundField DataField="ForumPosts" ReadOnly="true" SortExpression="FormPosts">
                        <ItemStyle Width="60px" HorizontalAlign="Center"/>
                    </asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <%#Eval("ForumLastPostDate","{0:MM/dd/yy}") %><br />
                            <small>
                                <%#Eval("ForumLastPostDate","{0:HH:mm:ss tt}") %>
                            </small>
                        </ItemTemplate>
                        <ItemStyle Width="90px" HorizontalAlign="Center"/>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="sdsForums" runat="server" 
                ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
                DeleteCommand="DeleteForum" DeleteCommandType="StoredProcedure" 
                ProviderName="<%$ ConnectionStrings:WishConnectionString.ProviderName %>" 
                SelectCommand="GetForums" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="ForumID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="dropForumCategory" Name="CategoryID" 
                        PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="txtForumName" Name="ForumName" 
                        PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtForumDescription" Name="ForumDescription" 
                        PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtForumPosition" Name="ForumPosition" 
                        PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="txtForumIDCurr" Direction="InputOutput" 
                        Name="ForumID" PropertyName="Text" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter Name="CategoryID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtForumIDCurr" Name="ForumID" 
                        PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="txtForumName" Name="ForumName" 
                        PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtForumDescription" Name="ForumDescription" 
                        PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtForumPosition" Name="ForumPosition" 
                        PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="dropForumCategory" Name="CategoryID" 
                        PropertyName="SelectedValue" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </ItemTemplate>
    </asp:DataList>



    <asp:SqlDataSource ID="sdsCategories" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
        DeleteCommand="DeleteCategory" DeleteCommandType="StoredProcedure" 
        InsertCommand="InsertCategory" InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:WishConnectionString.ProviderName %>" 
        SelectCommand="GetCategories" SelectCommandType="StoredProcedure" 
        UpdateCommand="UpdateCategory" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="CategoryID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txtCategoryName" Name="CategoryName" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="dropForumPicture" Name="CategoryImageUrl" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="dropCategoryPosition" Name="CategoryPosition" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtCategoryImageUrl" Direction="InputOutput" 
                Name="CategoryID" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtCategoryIDCurr" Name="CategoryID" 
                PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtCategoryName" Name="CategoryName" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="dropForumPicture" Name="CategoryImageUrl" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="dropCategoryPosition" Name="CategoryPosition" 
                PropertyName="SelectedValue" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
     
    <asp:SqlDataSource ID="sdsForum" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
        InsertCommand="InsertForum" 
        ProviderName="<%$ ConnectionStrings:WishConnectionString.ProviderName %>" 
        SelectCommand="GetForumsDetails" InsertCommandType="StoredProcedure" 
        SelectCommandType="StoredProcedure" UpdateCommand="UpdateForum" 
        UpdateCommandType="StoredProcedure" >
        <InsertParameters>
            <asp:ControlParameter ControlID="dropForumCategory" Name="CategoryID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtForumName" Name="ForumName" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtForumDescription" Name="ForumDescription" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="dropForumPosition" Name="ForumPosition" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtForumIDCurr" Direction="InputOutput" 
                Name="ForumID" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="ForumID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtForumIDCurr" Name="ForumID" 
                PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtForumName" Name="ForumName" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtForumDescription" Name="ForumDescription" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="dropForumPosition" Name="ForumPosition" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtForumCategoryCurr" Name="CategoryID" 
                PropertyName="Text" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
     
    <wish:SiteFooter ID="SiteFooter1" runat="server" />
    </form>
</body>
</html>
