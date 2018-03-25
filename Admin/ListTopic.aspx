<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListTopic.aspx.cs" Inherits="Admin_ListTopic" %>

<%@ Register Assembly="Meta.Web.Controls" Namespace="Meta.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style7
        {
            width: 258px;
        }
        .style8
        {
            width: 123px;
        }
        .style9
        {
            width: 250px;
        }
        .style10
        {
            width: 183px;
        }
    </style>
    <link  href="../styles/Wish.css" rel="Stylesheet"/>
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
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <wish:SiteHeader ID="SiteHeader1" runat="server" />
        <table>
            <tr>
                <td class="style10" >
                    选择版区</td>
                <td class="style9" >
                    <asp:DropDownList ID="dropCategories" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsCategories" DataTextField="CategoryName" 
                        DataValueField="CategoryID"  AppendDataBoundItems="True" 
                        onselectedindexchanged="dropCategories_SelectedIndexChanged">
                        <asp:ListItem Value="0">全部版区</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="style8" >
                    选择论坛</td>
                <td class="style7" >
                    <asp:DropDownList ID="dropForums" runat="server" DataSourceID="sdsForums" 
                        DataTextField="ForumName" DataValueField="ForumID" Visible="false">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style10">
                    使用那种时间段查询</td>
                <td class="style9">
                    <asp:RadioButtonList ID="radlTime" runat="server" RepeatDirection="Horizontal" 
                        RepeatLayout="Flow">
                        <asp:ListItem Value="1" Selected="True" >按发帖时间</asp:ListItem>
                        <asp:ListItem Value="2">按回复时间</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td class="style8">
                    &nbsp;</td>
                <td class="style7">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style10">
                    开始时间</td>
                <td class="style9">
                    <asp:TextBox ID="txtStart" runat="server"></asp:TextBox>
                    <asp:Button ID="btnStrar" runat="server" Text="选择时间" onclick="btnStrar_Click" 
                        Width="75px" />
                    <cc1:DropDownCalendar ID="dropStrar" runat="server" Width="100px">
                    </cc1:DropDownCalendar>
                </td>
                <td class="style8">
                    结束时间</td>
                <td class="style7">
                    <asp:TextBox ID="txtEnd" runat="server" style="margin-left: 0px"></asp:TextBox>
                    <asp:Button ID="btnEnd" runat="server" Text="选择时间" onclick="btnEnd_Click" 
                        Width="75px" />
                    <cc1:DropDownCalendar ID="dropEnd" runat="server" Width="110px">
                    </cc1:DropDownCalendar>
                </td>
            </tr>
            <tr>
                <td class="style10">
                    搜索主题关键字</td>
                <td class="style9">
                    <asp:TextBox ID="txtTopicKey" runat="server"></asp:TextBox>
                </td>
                <td class="style8" >
                    &nbsp;</td>
                <td class="style7">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style10">
                    搜索用户</td>
                <td class="style9">
                    <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                </td>
                <td class="style8">
                    &nbsp;</td>
                <td class="style7">
                </td>
            </tr>
            <tr>
                <td class="style10">
                    <asp:Button ID="btnSearch" runat="server" Text="搜索" onclick="btnSearch_Click" />
                </td>
                <td class="style9">
                    &nbsp;</td>
                <td class="style8">
                    &nbsp;</td>
                <td class="style7">
                    &nbsp;</td>
            </tr>
        </table>
    
    
    <asp:Label ID="lblMessage" runat="server" Text="lblMessage"></asp:Label>
    <asp:SqlDataSource ID="sdsCategories" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
        SelectCommand="GetCategories" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsForums" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
        SelectCommand="GetForums" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="dropCategories" Name="CategoryID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSearch" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
        SelectCommand="GetTopicsByCondition" SelectCommandType="StoredProcedure" 
        DeleteCommand="DeleteTopics" DeleteCommandType="StoredProcedure" >
        <DeleteParameters>
            <asp:Parameter Name="TopicID" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="dropForums" Name="ForumID" 
                PropertyName="SelectedValue" Type="String" 
                ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="radlTime" Name="TimeType" 
                PropertyName="SelectedValue" Type="String" 
                ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="txtStart" Name="StartTime" PropertyName="Text" 
                Type="String" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="txtEnd" Name="EndTime" PropertyName="Text" 
                Type="String" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="txtTopicKey" Name="TopicKey" 
                PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />
            <asp:ControlParameter ControlID="txtUserName" Name="UserName" 
                PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="grvResult" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" ForeColor="#333333" GridLines="None"  DataKeyNames="TopicID"
        onrowdatabound="grvResult_RowDataBound" 
        onrowdeleting="grvResult_RowDeleting" AllowPaging="True" PageSize="5" 
        onpageindexchanged="grvResult_PageIndexChanged" 
        onpageindexchanging="grvResult_PageIndexChanging" Width="724px" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField>
                <ItemStyle HorizontalAlign="Center" />
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkAll" runat="server" Visible='<%#IsAdmin %>'/>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSelect" runat="server" Visible='<%#IsAdmin %>' />
                    </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="主题">
                <ItemTemplate>
                    <asp:HyperLink runat="server" NavigateUrl='<%#"~/Topic.aspx?TopicID="+Eval("TopicID") %>' ID="lnkSubject"
                    Text='<%#"<b>"+Eval("Subject")+"</b> ["+Eval("CategoryName")+"] ["+Eval("ForumName")+"]"%>'></asp:HyperLink>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="作者">
                <ItemTemplate>
                    <asp:Label ID="lblUserName" runat="server" Text='<%#"<b>"+Eval("UserName")+"</b> ["+Eval("NickName")+"]<br/>["+Eval("AddedDate","{0:HH:mm:ss:tt}")+"]"%>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="回复数">
                <ItemTemplate>
                    <asp:Label ID="lblTopicReplies" runat="server" Text='<%#"<b>"+Eval("TopicReplies")+"</b>"%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="最后更新时间">
                <ItemTemplate>
                    <asp:Label ID="lblTopicLastPostDate" runat="server" Text='<%#"<b>"+Eval("TopicLastPostDate")+"</b>"%>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>
                 <ItemTemplate>
                    <asp:ImageButton ID="ibtnDelete" runat="server" CommandName="Delete" AlternateText="删除" Visible='<%#IsAdmin %>'
                    OnClientClick='<%# "if(!confirm(\"你确定要删除"+Eval("Subject").ToString()+"吗?\"))return false;" %>' ImageUrl="~/images/Command/Delete.gif"/>
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

    <wish:SiteFooter ID="SiteFooter1" runat="server" />
    </div>
    </form>
</body>
</html>
