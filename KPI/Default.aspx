<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Theme.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="KPI._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid">
        <a href="?lang=ja" runat="server" id="linkEnglishLang">
            <asp:Literal ID="Literal1" runat="server" Text="japan" />
        </a>
        <a href="?lang=vi" runat="server" id="linkVietnameseLang">
            <asp:Literal ID="Literal2" runat="server" Text="vietnam" />
        </a>
        <h1 class="h3 mb-4 text-gray-800">
            <asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, mnuHome%>"></asp:Literal></h1>
    </div>
</asp:Content>
