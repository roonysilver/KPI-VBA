<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="ChangePass.aspx.vb" Inherits="KPI.ChangePass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/UserStyle/ChangePassStyle.css" rel="stylesheet" type="text/css" />
    <div class="container">
        <div class="justify-content-center">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <asp:Literal ID="Literal8" runat="server" Text="<%$Resources:KPI.language, changePass%>"></asp:Literal></h6>
                </div>
                <div class="card-body">
                    <div class="container">
                        <div class="formUser">
                            <div class="form-group m-5">
                                <label for="dl">
                                    <b>
                                        <asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, oldPass%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                                <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="form-control form-control-user txtPassword password" placeholder="<%$Resources:KPI.language, holderOldPass%>" runat="server"></asp:TextBox>
                                <asp:Label ID="lblErrorPassword" CssClass="errorPassword" runat="server" ForeColor="Red" Text=""></asp:Label>
                                <label class="error errPassword" style="color: red; display: none; font-size: 15px">
                                    <asp:Literal ID="Literal4" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal>

                                </label>
                            </div>
                            <div class="form-group m-5">
                                <label for="dl">
                                    <b>
                                        <asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, newPass%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                                <asp:TextBox ID="txtNewPassword" MaxLength="8" TextMode="Password" CssClass="form-control form-control-user txtNewPassword password" placeholder="<%$Resources:KPI.language, holderNewPass%>" runat="server"></asp:TextBox>
                                <label class="error errNewPassword" style="color: red; display: none; font-size: 15px">
                                    <asp:Literal ID="Literal5" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal>
                                </label>
                                <label class="error errOverChar-NewPassword" style="padding-top:3px; color: red; display: none; font-size: 15px">
                                    <asp:Literal ID="Literal9" runat="server" Text="<%$Resources:KPI.language, ErrorOverEight%>"></asp:Literal>
                                </label>
                            </div>
                            <div class="form-group m-5">
                                <label for="dl">
                                    <b>
                                        <asp:Literal ID="Literal2" runat="server" Text="<%$Resources:KPI.language, retypeNewPass%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                                <asp:TextBox ID="txtTypeNewPassword" MaxLength="8" TextMode="Password" CssClass="form-control form-control-user txtTypeNewPassword password" placeholder="<%$Resources:KPI.language, holderRetypeNewPass%>" runat="server"></asp:TextBox>
                                <asp:Label ID="lblErrorNewPassword" ForeColor="Red" runat="server" Text=""></asp:Label>
                                <label class="error errTypeNewPassword" style="color: red; display: none; font-size: 15px">
                                    <asp:Literal ID="Literal6" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal>
                                </label>
                                <label class="error errOverChar-TypeNewPassword" style="padding-top:3px;color: red; display: none; font-size: 15px">
                                    <asp:Literal ID="Literal10" runat="server" Text="<%$Resources:KPI.language, ErrorOverEight%>"></asp:Literal>
                                </label>
                            </div>
                            <%--<a href="login.html" class="btn btn-primary btn-user btn-block">Reset Password
                            </a>--%>
                            <div class="button-click row justify-content-end mr-5">
                                <%--<div class="col-xl-6 col-lg-6 col-md-1">
                            </div>--%>
                                <div>
                                    <asp:Button ID="btnChangePassword" CssClass="btn btn-primary btn-user btn-block btnChangePassword" runat="server" Text="<%$Resources:KPI.language, btnChange%>" />
                                </div>
                                <div>
                                    <a href="/" class="btn btn-danger btn-user btn-block" style="margin-left: 10px;">
                                        <asp:Literal ID="Literal7" runat="server" Text="<%$Resources:KPI.language, cancel%>"></asp:Literal>

                                    </a>
                                    <%--<asp:Button ID="btnCa" CssClass="btn btn-danger btn-user btn-block" runat="server" Text="Cancel" />--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../../Scripts/UserScript/ChangeStypeScript.js"></script>
</asp:Content>
