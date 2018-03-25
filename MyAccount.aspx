<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyAccount.aspx.cs" Inherits="MyAccount" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="javascript" type="text/javascript" src="JS/JScript.js" ></script>
    <style type="text/css">
        .style1
        {
            width: 391px;
            text-align: right;
        }
        .style2
        {
            width: 391px;
            text-align: right;
        }
        .style4
        {
            text-align: center;
        }
    </style>
    <link  href="styles/Wish.css" rel="Stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <wish:SiteHeader ID="SiteHeader1" runat="server" />
    
        <table style="width: 863px">
            <tr>
                <td colspan="2" class="style4">
                    我的账户</td>
            </tr>
            <tr>
                <td class="style2" >
                    用户名</td>
                <td >
                    <asp:TextBox ID="txtUser" runat="server" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2" >
                    昵称</td>
                <td >
                    <asp:TextBox ID="txtNick" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    性别</td>
                <td>
                    <asp:RadioButtonList ID="rblSex" runat="server" 
                        RepeatDirection="Horizontal" RepeatLayout="Flow" Width="128px">
                        <asp:ListItem Value="M">男</asp:ListItem>
                        <asp:ListItem Value="F">女</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td class="style2" >
                    头像</td>
                <td >
                    <asp:DropDownList ID="dropFace" runat="server" ValidationGroup="shang" ></asp:DropDownList>
                    <asp:Image ID="imgFace" runat="server" Height="33px" Width="43px" />
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                    <asp:Button ID="btnSub" runat="server" onclick="btnSub_Click" Text="上传" ValidationGroup="shang" />
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Email</td>
                <td>
                    <asp:RadioButtonList ID="rblShowEmail" runat="server" 
                        RepeatDirection="Horizontal" RepeatLayout="Flow">
                        <asp:ListItem Value="true">显示</asp:ListItem>
                        <asp:ListItem Value="false">隐藏</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    个性签名</td>
                <td>
                    <asp:TextBox ID="txtSignature" runat="server" style="text-align: left" 
                        Height="66px" TextMode="MultiLine" Width="167px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    注册日期</td>
                <td >
                    <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    验证码</td>
                <td>
                    <asp:TextBox ID="txtCheckCode" runat="server" Width="64px"></asp:TextBox>
                    <img id="imgRandom" alt="验证码" src="RandomImage.aspx"/>
                    <a href="javascript:changeImage();">看不清？</a>
                    </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Blue" Text="Label"></asp:Label>
                </td>
                <td>
                    <asp:Button ID="btnUpdata" runat="server" Text="更新" onclick="btnUpdata_Click" />
                </td>
            </tr>
        </table>
    
    </div>
    <asp:SqlDataSource ID="sdsUpdata" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WishConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:WishConnectionString.ProviderName %>" 
        UpdateCommand="UpdateUser" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtNick" Name="NickName" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="rblSex" Name="Sex" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="rblShowEmail" Name="ShowEmail" 
                PropertyName="SelectedValue" Type="Boolean" />
            <asp:ControlParameter ControlID="dropFace" Name="imageUrl" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtSignature" Name="Signature" 
                PropertyName="Text" Type="String" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <wish:SiteFooter ID="SiteFooter1" runat="server" />
    </form>
</body>
</html>
