<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Forum.aspx.cs" Inherits="Forum" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>威迅教育网</title>
    <link rel="Stylesheet" href="styles/Wish.css"/>
</head>

<body>
    <form id="form1" runat="server">
    <div>
        <wish:SiteHeader ID="SiteHeader1" runat="server" />
        <div class="PageBack" onclick="javascript:history.go(-1);"><a href="">后退</a></div>
        <div class="PageReload" onclick="javascript:location.reload();"><a href="">刷新</a></div>
        <div class="PostTopics" title="发表一个新帖子"><a href='<%#"PostMessage.aspx?Action=NewTopic&ForumID="+forumID %>'>发帖</a></div>
         <br />
        <asp:GridView ID="grvForum" runat="server" AllowPaging="True" 
            DataSourceID="sdsForum" AutoGenerateColumns="False" CellPadding="4" 
            ForeColor="#333333" GridLines="None" Width="652px" PageSize="5" 
            DataKeyNames="TopicID">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:TemplateField>
                    <ItemStyle Width="1px"/>
                        <ItemTemplate>
                            <asp:ImageButton ID="ibtnDeleteTopic" BorderWidth="0" AlternateText="删除主题" runat="server"
                             ImageUrl="~/images/Command/Delete.gif" Visible="<%#IsAdmin %>" CommandName="Delete"
                              OnClientClick='<%# "if(!confirm(\"你确定要删除主题["+Eval("Subject").ToString()+"]?\"))return false;" %>' />
                        </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="主题">
                    <HeaderStyle Font-Bold="true"/>
                        <ItemTemplate>
                            <b><a href='<%#"Topic.aspx?TopicID="+Eval("TopicID") %>'><%#Eval("Subject") %></a></b>
                        </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="作者">
                    <ItemStyle HorizontalAlign="Center" Width="160px"/>
                        <ItemTemplate>
                            <%#GetAuthorText(Eval("UserName"),Eval("NickName"),Eval("Email"),Eval("ShowEmail")) %>
                            <br />
                            <small>
                                <%#Eval("AddedDate","{0:MM/dd/yy}") %>-<%#Eval("AddedDate","{0:HH:mm:ss tt}") %></small>
                        </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="最后回复">
                    <HeaderStyle Font-Bold="true"/>
                        <ItemStyle HorizontalAlign="Center" Width="160px"/>
                            <ItemTemplate>
                                (<%#Eval("TopicReplies") %>)<br />
                                <small>
                                    <%#Eval("TopicLastReplyDate","{0:MM/dd/yy}") %>-<%#Eval("TopicLastReplyDate", "{0:HH:mm:ss tt}")%></small>
                            </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        </asp:GridView>

        <asp:SqlDataSource ID="sdsForum" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
            DeleteCommandType="StoredProcedure" 
            ProviderName="<%$ ConnectionStrings:WishConnectionString.ProviderName %>" 
            SelectCommandType="StoredProcedure" DeleteCommand="DeleteTopics" 
            SelectCommand="GetTopics">
            <DeleteParameters>
                <asp:Parameter Name="TopicID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="1" Name="ForumID" 
                    QueryStringField="ForumID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <wish:SiteFooter ID="SiteFooter1" runat="server" />
    </div>
    </form>
</body>
</html>