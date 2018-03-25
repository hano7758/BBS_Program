<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Topic.aspx.cs" Inherits="Topic" %>

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
            <div class="PostTopics" title="发表一个新帖子"><asp:HyperLink ID="lnkNewTopic" runat="server" NavigateUrl="PostMessage.aspx?Action=NewTopic&ForumID=">发帖</asp:HyperLink></div>
            <div class="Retopic" title="回复帖子"><asp:HyperLink ID="lnkNewReply" runat="server" NavigateUrl="PostMessage.aspx?Action=NewReply&ForumID=">回复</asp:HyperLink></div> 
            <br /><br />
            <div style="background-color:#507CD1; color:White; font-weight:bold">
                <table cellspacing="0" cellpadding="0" style="border:0; width:100%">
                <tr>
                    <td style="width:160px; text-align:center">作者</td>
                    <td style="text-align:center">消息</td>
                </tr>
                </table>
            </div>
            <table cellspacing="0" cellpadding="0" style="border:0; width:100%">
                <tr>
                    <td style="width:160px; text-align:center">
                        <b><asp:Label ID="lblTopicAuthor" runat="server"></asp:Label></b><br /><br />
                        <asp:Image ID="imgTopicAuthor" runat="server"/><br /><br />
                        <small>发表于:<br />
                            <asp:Label ID="lblTopicDate" runat="server"></asp:Label>
                            <asp:Label ID="lblTopicTime" runat="server"></asp:Label>
                        </small><br /><br />
                        <img src="images/Forums/TopicIPIocn.gif" alt="IP"/>&nbsp;&nbsp;
                         <asp:Label ID="lblUserIP" runat="server" Visible="<%#IsAdmin %>"></asp:Label>
                    </td>
                    <td>
                        <table cellspacing="0" cellpadding="0" style="border:0; width:100%; height:160px">
                            <tr>
                                <td style="text-align:left">
                                    <asp:HyperLink ID="lnkSpace" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/UserSpaceIcon.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkBlog" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/UserBlogsIcon.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkPhotot" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/PhotosIcon.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkUserProfile" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/UserProfileIcon.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkFind" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/FindIcon.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkFriend" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/friend.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkMessage" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/sendmessages.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                </td>
                                <td style="text-align:right">
                                    <img src="images/Forums/TopicFloor.gif" style="border:0; text-align:center" alt=""/>楼主
                                </td>
                            </tr>
                            <tr style="width:20px;">
                                <td colspan="2"><b><asp:Label ID="lblTopicSubject" runat="server"></asp:Label></b></td>
                            </tr>
                            <tr>
                                <td valign="top" colspan="2">
                                    <asp:Label ID="lblTopicMessage" runat="server"></asp:Label><br /><br />
                                    <asp:Label ID="lblTopicAuthorSignature" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr style="width:20px;">
                                <td style="text-align:right" colspan="2">
                                    <asp:LinkButton ID="lbtnDeleteTopic" runat="server" Visible="<%#IsAdmin %>" OnClientClick="if(!confirm('你确定要删除此主题吗？')) return false;" 
                                        onclick="lbtnDeleteTopic_Click">[<img style="border:0" alt="删除主题" src="images/Command/Delete.gif"/>删除]</asp:LinkButton>
                                    <asp:HyperLink ID="lnkQuoteSubject" runat="server" NavigateUrl="">
                                        [<img alt="引用回复" src="images/Forums/Reply.gif" style="border:0" />引用回复]
                                    </asp:HyperLink>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

        <asp:DataList ID="dlstReplies" runat="server" DataSourceID="sdsGetReplies" 
        Width="100%" ShowHeader="False" DataKeyField="ReplyID" CellPadding="4" 
            ForeColor="#333333" ondeletecommand="dlstReplies_DeleteCommand">
            <AlternatingItemStyle BackColor="White" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#EFF3FB" />
            <ItemTemplate>
            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                <tr>
                    <td align="center" style="width:160px">
                        <b><%#GetAuthorText(Eval("UserName"), Eval("NickName"), Eval("Email"), Eval("ShowEmail"))%></b><br /><br />
                        <asp:Image ID="imgFace" runat="server" Visible='<%#Eval("ImageUrl").ToString().Length>0 %>'
                        ImageUrl='<%#Eval("ImageUrl") %>'/><br /><br />
                        <small>发表于:<br /><%#Eval("AddedDate","{0:MM/dd/yy}") %>-<%#Eval("AddedDate","{0:HH:mm:ss tt}") %>
                        </small><br /><br /><img src="images/Forums/TopicIPIocn.gif" style="border:0" alt=""/>&nbsp;&nbsp;<%#Eval("UserIP") %>
                    </td>
                    <td>
                        <table style="border:0; height:160px; width:100%" cellpadding="1" cellspacing="1">
                            <tr>
                                <td style="text-align:left">
                                    <asp:HyperLink ID="lnkSpace" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/UserSpaceIcon.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkBlog" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/UserBlogsIcon.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkPhotot" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/PhotosIcon.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkUserProfile" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/UserProfileIcon.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkFind" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/FindIcon.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="lnkFriend" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/friend.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="LnkMessage" runat="server" NavigateUrl="default.aspx" Target="_blank">
                                    <img src="images/Forums/sendmessages.gif" style="border:0" alt=""/>
                                    </asp:HyperLink>
                                </td>
                                <td style="text-align:right">
                                    <img src="images/Forums/TopicFloor.gif" style="border:0" alt=""/>
                                    <%#(CurPage-1)*5+((DataListItem)Container).ItemIndex+1%>楼
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" colspan="2">
                                    <%#Tool.ProcessTags(Eval("Message").ToString()) %><br />
                                    <asp:Label ID="Label1" runat="server" Text="" Font-Size="Smaller" ForeColor="#3366FF">个性签名：
                                    <%# Tool.ProcessTags(Eval("signature").ToString().Trim()) == "" ? "暂无" : Tool.ProcessTags(Eval("signature").ToString())%> </asp:Label>
                                </td>
                            </tr>
                            <tr style="height:20px">
                                <td style="text-align:right" colspan="2">
                                    <asp:LinkButton ID="lbtnDeleteReply" runat="server"
                                     Visible="<%#IsAdmin %>" CommandName="Delete" OnClientClick="if(!confirm('你确定要删除此回复吗?')) return false;">
                                    [<img style="border:0" alt="删除回复" src="images/Command/Delete.gif"/>删除回复]
                                    </asp:LinkButton>
                                    <asp:HyperLink ID="lnkQuoteReply" runat="server" NavigateUrl='<%# "PostMessage.aspx?Action=NewReply"+"&ForumID="+forumID+
                                    "&TopicID="+topicID+"&QuoteReplyID="+Eval("ReplyID").ToString() %>'>
                                    [<img alt="引用回复" src="images/Forums/Reply.gif" style="border:0"/>引用回复]
                                    </asp:HyperLink>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            </ItemTemplate>
            <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        </asp:DataList><br />

        <table style="width: 600px; text-align:left;" cellpadding="0" cellspacing="0"> 
        <tr> 
        <td style="width:600px; height:25px;"> 
        <asp:Label ID="lblNow" runat="server" Text="当前页码为："></asp:Label>[
        <asp:Label ID="lblPage" runat="server" Text="1"></asp:Label>]
        <asp:Label ID="lblCount" runat="server" Text="总页码为："></asp:Label> [
        <asp:Label ID="labBackPage" runat="server" Text="2"></asp:Label> ]
        <asp:LinkButton ID="lnkbtnFirst" runat="server" onclick="lnkbtnFirst_Click">首页</asp:LinkButton>&nbsp;
        <asp:LinkButton ID="lnkbtnUp" runat="server" onclick="lnkbtnUp_Click">上一页</asp:LinkButton>&nbsp;
        <asp:LinkButton ID="lnkbtnNext" runat="server" onclick="lnkbtnNext_Click">下一页</asp:LinkButton>&nbsp;
        </td>
        </tr>
        </table>


            <div class="ReTopicBottom" title="回复帖子">
                <asp:HyperLink ID="lnkNewReplyBottom" runat="server" NavigateUrl="PostMessage.aspx?Action=NewReply&ForumID=">回复</asp:HyperLink>
            </div> 
            <div class="PostTopicBottom" title="发表一个新帖子">
                <asp:HyperLink ID="lnkNewTopicBottom" runat="server" NavigateUrl="PostMessage.aspx?Action=NewTopic&ForumID=">发帖</asp:HyperLink>
            </div>

        <br />
        <asp:SqlDataSource ID="sdsGetReplies" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
            SelectCommand="GetReplies" SelectCommandType="StoredProcedure" 
            DeleteCommand="DeleteReply" DeleteCommandType="StoredProcedure" ProviderName=
            "<%$ ConnectionStrings:WishConnectionString.ProviderName %>" 
            >
                <DeleteParameters>
                    <asp:Parameter Name="ReplyID" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="TopicID" QueryStringField="TopicID" 
                        Type="Int32" />
                </SelectParameters>
        </asp:SqlDataSource>
        <wish:SiteFooter ID="SiteFooter1" runat="server" />
    </div>
    </form>
</body>
</html>