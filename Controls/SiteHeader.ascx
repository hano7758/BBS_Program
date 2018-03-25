<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SiteHeader.ascx.cs" Inherits="Controls_SiteHeader" %>
<table width="100%">
        <tr>
            <td width="50%">
                <asp:HyperLink ID="lnkWishLogo" runat="server" ImageUrl="~/images/Wishlogo.bmp" 
                    NavigateUrl="~/Default.aspx">HyperLink</asp:HyperLink>
            </td>
            <td>
                <asp:Label ID="lblGreeting" runat="server" Text="Label"></asp:Label>
                <asp:HyperLink ID="lnkUser" runat="server">HyperLink</asp:HyperLink>
                <asp:LinkButton ID="lbtnSignOut" runat="server" CausesValidation="False" onclick="lbtnSignOut_Click" Visible="False">注销</asp:LinkButton>
                <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Register.aspx">注册</asp:HyperLink>
            </td>
        </tr>
    </table>
