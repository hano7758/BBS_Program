<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgetPassword.aspx.cs" Inherits="ForgetPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link  href="styles/Wish.css" rel="Stylesheet"/>
    <script language="javascript" type="text/javascript" src="JS/JScript.js" ></script>
    <style type="text/css">
        .style1
        {
            width: 65%;
        }
        .style2
        {
            text-align: right;
            width: 403px;
        }
    </style>
    <link  href="styles/Wish.css" rel="Stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <wish:SiteHeader ID="SiteHeader1" runat="server" />
    <table class="style1">
        <tr>
            <td class="style2">
                用户名</td>
            <td>
                <asp:TextBox ID="txtUserName" runat="server">qiaobo</asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style2">
                提示问题</td>
            <td>
                <asp:TextBox ID="txtQuestion" runat="server">123456</asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style2">
                提示答案</td>
            <td>
                <asp:TextBox ID="txtAnswer" runat="server">123456</asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style2">
                验证码</td>
            <td id="txt">
                <asp:TextBox ID="txtCheckCode" runat="server" Width="68px"></asp:TextBox>
                <img id="imgRandom" alt="验证码" src="RandomImage.aspx"/>
                <a href="javascript:changeImage();">看不清？</a>
            </td>
        </tr>
        <tr>
            <td class="style2">
                新密码</td>
            <td>
                <asp:Label ID="lblNewPassword" runat="server" ForeColor="Red" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">
                <asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>
            </td>
            <td style="text-align: left">
                <asp:Button ID="btnNewPassword" runat="server" Text="提交" 
                    onclick="btnNewPassword_Click" />
            </td>
        </tr>
    </table>
    <wish:SiteFooter ID="SiteFooter1" runat="server" />
    <asp:SqlDataSource ID="sdsForget" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
        SelectCommand="ValidateQuestion" SelectCommandType="StoredProcedure" 
        UpdateCommand="UpdatePassword" UpdateCommandType="StoredProcedure" 
        DataSourceMode="DataReader">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtUserName" Name="UserName" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtQuestion" Name="Question" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtAnswer" Name="Answer" PropertyName="Text" 
                Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Password" Type="String" />
            <asp:Parameter Name="UserId" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </form>
    </body>
</html>
