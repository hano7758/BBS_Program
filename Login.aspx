<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
    <style type="text/css">
        .style4
        {
            width: 288px;
        }
        .style5
        {
            width: 135px;
        }
        .style6
        {
            width: 135px;
            text-align: center;
        }
    </style>
    <link  href="styles/Wish.css" rel="Stylesheet"/>
    <script language="javascript" type="text/javascript" src="JS/JScript.js" ></script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
                    <asp:Label ID="lblMessage" runat="server" Text="Label" CssClass="message"></asp:Label>
    
                    <wish:SiteHeader ID="SiteHeader1" runat="server" />
    
        <table >
            <tr>
                <td class="style6" >
                    用户名</td>
                <td class="style4">
                    <asp:TextBox ID="txtUserName" runat="server" Width="150px" Text="admin"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valrUserName" runat="server" 
                        ControlToValidate="txtUserName" Display="Dynamic">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style6" >
                    密码</td>
                <td class="style4" >
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valrPassword" runat="server" 
                        ControlToValidate="txtPassword" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <a href="ForgetPassword.aspx">忘记密码？</a>
                </td>
            </tr>
            <tr>
                <td class="style6" >
                    验证码</td>
                <td class="style4">
                    <asp:TextBox ID="txtCheckCode" runat="server" Width="64px"></asp:TextBox>
                    <img alt="验证码" src="RandomImage.aspx" style="height: 21px; width: 47px" 
                        id="imgRandom" /><asp:RequiredFieldValidator ID="valrCheckCode" 
                        runat="server" Display="Dynamic" ErrorMessage="验证码不能为空" 
                        ControlToValidate="txtCheckCode">*</asp:RequiredFieldValidator>
&nbsp;<a href="javascript:changeImage();">看不清？</a></td>
            </tr>
            <tr>
                <td class="style6">
                    Cookie</td>
                <td class="style4">
                    <asp:DropDownList ID="dropRemember" runat="server">
                        <asp:ListItem Value="0">不保存</asp:ListItem>
                        <asp:ListItem Value="1">保存一天</asp:ListItem>
                        <asp:ListItem Value="31">保存一月</asp:ListItem>
                        <asp:ListItem Value="365">保存一年</asp:ListItem>
                    </asp:DropDownList>
                    </td>
                     
            </tr>
            <tr>
                <td class="style5" >
                    &nbsp;</td>
                <td class="style4" >
                    <asp:Button ID="btnLogin" runat="server" Text="登录" onclick="btnLogin_Click" />
                    <a href="Register.aspx">注册</a>
                </td>
            </tr>
        </table>
    
    </div>
    <wish:SiteFooter ID="SiteFooter1" runat="server" />
    <asp:SqlDataSource ID="sdsLogin" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
        DataSourceMode="DataReader" SelectCommand="ValidateLogin" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtUserName" Name="UserName" 
                PropertyName="Text" Type="String" />
            <asp:Parameter Name="CryptPassword" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
