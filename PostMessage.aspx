<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeFile="PostMessage.aspx.cs" Inherits="PostMessage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style2
        {
            width: 507px;
            text-align: left;
        }
    </style>
    <link  href="styles/Wish.css" rel="Stylesheet"/>
    <script language="javascript" type="text/javascript">
        function InsertTag(tagcode) 
        {
            //根据ID获得对象
            var txt = document.getElementById("txtMessage");
            //输入框获得焦点
            txt.focus();
            //获得滚动条的位置
            var s = txt.scrollTop;
            //创建文档选择对象
            var r = document.selection.createRange();
            //保存选中文本长度
            var selectLength = r.text.length;
            //创建输入框文本对象
            var t = txt.createTextRange();
            //将光标移到头
            t.collapse(true);
            //显示光标
            t.select();
            //为新的光标位置创建文档选择对象
            r.setEndPoint("StartToStart", document.selection.createRange());
            //获得光标的位置
            var pos = r.text.length;
            r.collapse(false);
            //把光标恢复到初始位置
            r.select();
            //把滚动条恢复到初始位置
            txt.scrollTop = s;
            var str = txt.value;
            txt.value = str.substring(0, pos - selectLength) + tagcode + str.substring(pos - selectLength, str.length);
        }
        function InsertTags(beginTagcode, endTagcode) 
        {
            var txt = document.getElementById("txtMessage");
            txt.focus;
            var s = txt.scrollTop;
            var r = document.selection.createRange();
            var selectLength = r.text.length;
            var t = txt.createTextRange();
            t.collapse(true);
            t.select();
            r.setEndPoint("StartToStart", document.selection.createRange());
            var pos = r.text.length;
            r.collapse(false);
            r.select();
            txt.scrollTop = s;
            var str = txt.value;
            txt.value = str.substring(0, pos - selectLength) + beginTagcode + str.substring(pos - selectLength, pos)+endTagcode+str.substring(pos,str.length);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <wish:SiteHeader ID="SiteHeader1" runat="server" />
            
        <table>
            <tr>
                <td class="style2" style="text-align: center">
                    <asp:Label ID="lblMessageHeader" runat="server" Font-Bold="True" 
                        Text="lblMessageHeader"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSubject" runat="server" Font-Bold="True" Text="主题"></asp:Label>
                    <br />
                    <asp:TextBox ID="txtSubject" runat="server" Width="100%" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSubject" Display="Dynamic" ID="valrSubject">
                    *
                    </asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="javascript:InsertTags('[B]','[/B]')"><img src="images/topicface/EditorBold.gif" alt="粗体" style="border:0"/></a>
                    <a href="javascript:InsertTags('[I]','[/I]')"><img src="images/topicface/EditorItalic.gif" alt="斜体" style="border:0"/></a>
                    <a href="javascript:InsertTags('[U]','[/U]')"><img src="images/topicface/EditorUnderline.gif" alt="下划线" style="border:0"/></a>
                    &nbsp;&nbsp;&nbsp;
                    <a href="javascript:InsertTag('[:)]')"><img src="images/topicface/smile.gif" alt="微笑" style="border:0"/></a>
                    <a href="javascript:InsertTag('[:D]')"><img src="images/topicface/LargeSmile.gif" alt="大笑" style="border:0"/></a>
                    <a href="javascript:InsertTag('[8)]')"><img src="images/topicface/Cool.gif" alt="酷" style="border:0"/></a>
                    <a href="javascript:InsertTag('[:o]')"><img src="images/topicface/Surprise.gif" alt="惊奇" style="border:0"/></a>
                    <a href="javascript:InsertTag('[:(]')"><img src="images/topicface/Sad.gif" alt="悲伤" style="border:0"/></a>
                    <a href="javascript:InsertTag('[:x]')"><img src="images/topicface/angry.gif" alt="生气" style="border:0"/></a>
                </td>
            </tr>
            <tr>
                <td>
                    <b>内容</b><br />
                    <asp:TextBox ID="txtMessage" runat="server" MaxLength="100" Rows="15" 
                        TextMode="MultiLine" Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMessage" Display="Dynamic" ID="valrMessage">
                        *
                        </asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:LinkButton ID="ibtnSubmitMessage" runat="server" 
                        onclick="ibtnSubmitMessage_Click">
                        [<img border="0" src="images/Command/Update.gif" alt="提交"/>提交]
                    </asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="lbtnCancelMessage" runat="server" 
                        CausesValidation="false" onclick="lbtnCancelMessage_Click">
                        [<img border="0" src="images/Command/Cancel.gif" alt="提交"/>取消]
                    </asp:LinkButton>
                </td>
            </tr>
        </table>

        <asp:SqlDataSource ID="sdsGetTopicMessage" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
            SelectCommand="GetTopicDetails" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="1" Name="topicID" 
                    QueryStringField="topicID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsGetReplyMessage" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
            SelectCommand="GetRepliesDetails" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="1" Name="replyID" 
                    QueryStringField="replyID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <wish:SiteFooter ID="SiteFooter1" runat="server" />
    </div>
    </form>
</body>
</html>
