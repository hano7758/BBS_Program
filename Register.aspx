<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
    <style type="text/css">
        .style3
        {
            text-align: center;
        }
        .style8
        {
            text-align: center;
            font-weight: bold;
        }
        #imgRandom
        {
            width: 47px;
            height: 22px;
        }
    </style>
    <link  href="styles/Wish.css" rel="Stylesheet"/>
    <script language="javascript" type="text/javascript" src="JS/JScript.js" ></script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <wish:SiteHeader ID="SiteHeader1" runat="server" />
    
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
            HeaderText="您的注册中有如下错误" Height="79px" />
    
        <table style="width: 82%">
            <tr>
                <td class="style8" colspan="4">
                    新用户注册表单</td>
            </tr>
            <tr>
                <td class="style3" >
                    用户账户</td>
                <td class="style3" >
                    <asp:TextBox ID="txtUserName" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valrUserName" runat="server" 
                        ControlToValidate="txtUserName" Display="Dynamic" 
                        ErrorMessage="您必须提供一个用户账户" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="valeUserName" runat="server" 
                        ControlToValidate="txtUserName" Display="Dynamic" ErrorMessage="用户名不合法" 
                        ValidationExpression="\w{3,16}" ForeColor="Red">*</asp:RegularExpressionValidator>
                </td>
                <td style="text-align: center" >
                    提示问题</td>
                <td class="style3">
                    <asp:TextBox ID="txtQuestion" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valrQuestion" runat="server" 
                        ControlToValidate="txtQuestion" Display="Dynamic" ErrorMessage="提示问题不能为空" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style3" >
                    中文昵称</td>
                <td class="style3">
                    <asp:TextBox ID="txtNickName" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valrNickname" runat="server" 
                        ControlToValidate="txtNickName" Display="Dynamic" 
                        ErrorMessage="您必须提供一个中文昵称" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
                <td style="text-align: center">
                    问题答案</td>
                <td class="style3">
                    <asp:TextBox ID="txtAnswer" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valrAnswer" runat="server" 
                        ControlToValidate="txtAnswer" Display="Dynamic" ErrorMessage="问题答案不能为空" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style3" >
                    密码</td>
                <td class="style3" >
                    <asp:TextBox ID="txtPassword1" runat="server" TextMode="Password" Width="150px" 
                        ToolTip="密码不得小于8个字符多于16个字符"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valrPassword1" runat="server" 
                        ControlToValidate="txtPassword1" Display="Dynamic" 
                        ErrorMessage="您必须提供一个密码" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="valePassword1" runat="server" 
                        ControlToValidate="txtPassword1" Display="Dynamic" ErrorMessage="密码不合法" 
                        ValidationExpression="\S{8,16}" ForeColor="Red">*</asp:RegularExpressionValidator>
                </td>
                <td style="text-align: center" >
                    性别</td>
                <td class="style3">
                    <asp:RadioButtonList ID="radlSex" runat="server" Height="28px" 
                        RepeatDirection="Horizontal" RepeatLayout="Flow" style="text-align: center" 
                        Width="126px">
                        <asp:ListItem Selected="True" Value="M">男</asp:ListItem>
                        <asp:ListItem Value="F">女</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td class="style3" >
                    确认密码</td>
                <td class="style3" >
                    <asp:TextBox ID="txtPassword2" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valrPassword2" runat="server" 
                        ControlToValidate="txtPassword2" Display="Dynamic" 
                        ErrorMessage="您必须提供一个确认密码" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="valcPassword2" runat="server" 
                        ControlToCompare="txtPassword1" ControlToValidate="txtPassword2" 
                        Display="Dynamic" ErrorMessage="确认密码必须与密码相同" ForeColor="Red">*</asp:CompareValidator>
                </td>
                <td class="style3" >
                    头像</td>
                <td style="text-align: center">
                    <asp:DropDownList ID="dropFace" runat="server" >
                    </asp:DropDownList>
                    <img id="imgFace" alt="头像" src="images/faces/1.bmp" 
                        style="height: 32px; width: 39px" /></td>
            </tr>
            <tr>
                <td style="text-align: center" >
                    Email</td>
                <td class="style3" >
                    <asp:TextBox ID="txtEmail" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valrEmail" runat="server" 
                        ControlToValidate="txtEmail" Display="Dynamic" 
                        ErrorMessage="您必须提供一个Email地址" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="valeEmail" runat="server" 
                        ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="请输入一个有效的Email地址" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                        ForeColor="Red">*</asp:RegularExpressionValidator>
                </td>
                <td class="style3" >
                    验证码</td>
                <td class="style3">
                    <asp:TextBox ID="txtCheckCode" runat="server" Width="64px"></asp:TextBox>
                    <img id="imgRandom" alt="验证码" src="RandomImage.aspx" /><asp:RequiredFieldValidator 
                        ID="valrCheckCode" runat="server" ControlToValidate="txtCheckCode" 
                        Display="Dynamic" ErrorMessage="验证码不能为空" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <a href="javascript:changeImage();">看不清？</a>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="style3">
                    <asp:Label ID="lblMessage" runat="server" Text="Label" CssClass="message"></asp:Label>
                </td>
                <td colspan="2" style="text-align: right">
                    <asp:Button ID="btnRegister" runat="server" Text="注册" 
                        onclick="btnRegister_Click" />
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sdsRegister" runat="server" 
        ConnectionString="Data Source=.;Initial Catalog=Wish;Persist Security Info=True;User ID=sa;Password=sa" 
        ProviderName="System.Data.SqlClient" InsertCommand="InsertUser" 
        InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="txtUserName" Name="UserName" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtNickName" Name="NickName" 
                PropertyName="Text" Type="String" />
            <asp:Parameter Name="Password" Type="String" />
            <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="txtQuestion" Name="Question" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtAnswer" Name="Answer" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="radlSex" Name="Sex" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="dropFace" Name="ImageUrl" 
                PropertyName="SelectedValue" Type="String" />
            <asp:Parameter Direction="InputOutput" Name="UserID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <wish:SiteFooter ID="SiteFooter1" runat="server" />
    </form>
</body>
</html>
