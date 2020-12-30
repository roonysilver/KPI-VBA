<%@ Page Title="Title" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="ModifyErrorAnalysis.aspx.vb" Inherits="KPI.ModifyErrorAnalysis" %>

<asp:Content ID="ModifyErrorAnalysis" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/ModifyTaskListStyle/ModifyTaskListStyle.css" rel="stylesheet" />
        <asp:TextBox ID="txtGuid" runat="server" CssClass="GUID"></asp:TextBox>
    <div class="container">
        <div class="justify-content-center" style="width: 100%">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary"><%=Session("ErrorAnalysis")%></h6>
                </div>
                <div class="card-body">
                    <div class="container">
                        <div class="formUser">
                            <div class="form-group m-5">
                                <label for="dl"><b><asp:Literal ID="Literal2" runat="server" Text="<%$Resources:KPI.language, phase%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                                <asp:DropDownList ID="ddlPhase" runat="server" CssClass="form-control form-control-phase Phase" Visible="True">
                                    <asp:ListItem Value="0" Text="<%$Resources:KPI.language, phdPhase%>"></asp:ListItem>
                                </asp:DropDownList>
                                <span class="error_phase" style="color: red; display: none"><asp:Literal ID="Literal4" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal></span>
                            </div>
                            <div class="form-group m-5">
                                <label for="dl"><b><asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, clmErrorAnalysis%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                                <asp:DropDownList ID="ddlError" runat="server" CssClass="form-control form-control-user Error" Visible="True">
                                    <asp:ListItem Value="0" Text="<%$Resources:KPI.language, phdError%>"></asp:ListItem>
                                </asp:DropDownList>
                                <span class="error_error" style="color: red; display: none"><asp:Literal ID="Literal5" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal></span>
                            </div>
                            <div class="form-group m-5">
                                <label for="dl"><b><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, clmBug%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                                <asp:TextBox ID="txtBug" Type="number" Min="0" CssClass="form-control form-control-user txtBug Bug" placeholder="<%$Resources:KPI.language, phdBug%>" runat="server"></asp:TextBox>
                                <span class="error_bug" style="color: red; display: none"><asp:Literal ID="Literal6" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal></span>
                            </div>
                            <div class="form-group m-5">
                                <asp:Label ID="lblReference" runat="server" CssClass="font-weight-bold" Text="<%$Resources:KPI.language, clmReference%>"></asp:Label>
                                <asp:TextBox ID="txtReference" Type="text" TextMode="multiline" CssClass="form-control form-control-user txtReferenece Reference" placeholder="<%$Resources:KPI.language, phdReference%>" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group m-5">

                                <%--<a href="login.html" class="btn btn-primary btn-user btn-block">Reset Password
                            </a>--%>
                                <div class="button-click row justify-content-end mr-5">
                                    <%--<div class="col-xl-6 col-lg-6 col-md-1">
                            </div>--%>
                                    <div style="margin-right:5px">
                                        <asp:Button ID="btnContent" CssClass="btn btn-primary btn-user btn-block btnContent" runat="server" Text="<%$Resources:KPI.language, btnCfmContinue%>" Visible="false" />
                                    </div>
                                       <div>
                                        <%--<h2 id="h2" runat="server" visible="false">|</h2>--%>
                                    </div>
                                    <div>
                                        <asp:Button ID="btnErrorAnalysis" CssClass="btn btn-primary btn-user btn-block btnErrorAnalysis" runat="server" Text="<%$Resources:KPI.language, btnCfmReturn%>" />
                                    </div>
                                    <div>
                                        <a href="/ErrorAnalysis?id=<%=Request.QueryString("idTask")%>" class="btn btn-danger btn-user btn-block" style="margin-left: 10px;"><asp:Literal ID="Literal7" runat="server" Text="<%$Resources:KPI.language, cancel%>"></asp:Literal></a>
                                        <%--<asp:Button ID="btnCa" CssClass="btn btn-danger btn-user btn-block" runat="server" Text="Cancel" />--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <style>
        .GUID {
            display: none;
        }
    </style>
    <script>
        //Validate Submit and Return Button
        $(".btnErrorAnalysis").click(function (e) {
            if ($(".Phase").val() == 0) {
                e.preventDefault()
                $(".error_phase").css("display", "block")

            }

            if ($(".Phase").val() != 0) {
                $(".error_phase").css("display", "none")

            }

            if ($(".Error").val() == 0) {
                e.preventDefault()
                $(".error_error").css("display", "block")
            }

            if ($(".Error").val() != 0) {
                $(".error_error").css("display", "none")
            }

            if ($(".Bug").val() == "") {
                e.preventDefault()
                $(".error_bug").css("display", "block")
            }

            if ($(".Bug").val() != "") {
                $(".error_bug").css("display", "none")
            }
        })
        //Validate Submit and Continue Button
        $(".btnContent").click(function (e) {
            if ($(".Phase").val() == 0) {
                e.preventDefault()
                $(".error_phase").css("display", "block")

            }

            if ($(".Phase").val() != 0) {
                $(".error_phase").css("display", "none")

            }

            if ($(".Error").val() == 0) {
                e.preventDefault()
                $(".error_error").css("display", "block")
            }

            if ($(".Error").val() != 0) {
                $(".error_error").css("display", "none")
            }

            if ($(".Bug").val() == "") {
                e.preventDefault()
                $(".error_bug").css("display", "block")
            }

            if ($(".Bug").val() != "") {
                $(".error_bug").css("display", "none")
            }
        })

        function createGuid() {
            function S4() {
                return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
            }
            return (S4() + S4() + "-" + S4() + "-4" + S4().substr(0, 3) + "-" + S4() + "-" + S4() + S4() + S4()).toLowerCase();
        }

        //Prevent Resubmit after Refresh
        function FillTxtGuid() {
            $(".GUID").val(createGuid())
        }

        $(".btnContent").click(function () {
            FillTxtGuid()
        })
    </script>
</asp:Content>
