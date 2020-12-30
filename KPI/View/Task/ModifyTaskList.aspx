<%@ Page Title="Title" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="ModifyTaskList.aspx.vb" Inherits="KPI.ModifyContentList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:TextBox ID="txtGuid" runat="server" CssClass="GUID"></asp:TextBox>
    <link href="../../Content/QuanlityStyle/QuanlityStyle.css" rel="stylesheet" />
    <div class="container">
        <div class="justify-content-center" style="width: 100%">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary"><%=Session("Task")%></h6>
                </div>
                <div class="card-body">
                    <div class="container">
                        <div class="formUser">
                            <div class="form-group m-5">
                                <label for="dl">
                                    <b>
                                        <asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, clmTask%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                                <asp:TextBox ID="txtContent" Text="" CssClass="form-control form-control-user txtContent Content" placeholder="<%$Resources:KPI.language, phdTask%>" runat="server"></asp:TextBox>
                                <span class="error_content" style="color: red; display: none"><asp:Literal ID="Literal4" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal></span>
                            </div>
                            <div class="form-group m-5">
                                <label for="dl">
                                    <b>
                                        <asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, clmLevel%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                                <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control form-control-user txtLevel Level" Visible="True">
                                    <asp:ListItem Value="0" Text="<%$Resources:KPI.language, phdLevel%>"></asp:ListItem>
                                </asp:DropDownList>
                                <span class="error_level" style="color: red; display: none"><asp:Literal ID="Literal5" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal></span>
                            </div>
                            <div class="form-group m-5">
                                <label for="dl">
                                    <b>
                                        <asp:Literal ID="Literal2" runat="server" Text="<%$Resources:KPI.language, clmUser%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                                <asp:DropDownList ID="ddlUser" runat="server" CssClass="form-control form-control-user txtUser User" Visible="True" placeholder="Enter User">
                                    <asp:ListItem Value="0" Text="<%$Resources:KPI.language, phdUser%>"></asp:ListItem>
                                </asp:DropDownList>
                                <span class="error_user" style="color: red; display: none"><asp:Literal ID="Literal6" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal></span>
                            </div>
                            <div class="form-group m-5">
                                <div class="button-click row justify-content-end mr-5">
                                    <div style="margin-right: 5px">
                                        <asp:Button ID="btnContent" CssClass="btn btn-primary btn-user btn-block btnContent" runat="server" Text="<%$Resources:KPI.language, btnCfmContinue%>" Visible="false" />
                                    </div>
                                    <%--<div>
                                        <h2 id="h2" runat="server" visible="false">|</h2>
                                    </div>--%>
                                    <div>
                                        <asp:Button ID="btnTask" CssClass="btn btn-primary btn-user btn-block btnTask" runat="server" Text="<%$Resources:KPI.language, btnCfmReturn%>" />
                                    </div>
                                    <div>
                                        <a href="/Task" class="btn btn-danger btn-user btn-block" style="margin-left: 10px;"><asp:Literal ID="Literal7" runat="server" Text="<%$Resources:KPI.language, cancel%>"></asp:Literal></a>
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

        //Validate Submuit and continue button
        $(".btnTask").click(function (e) {
            if ($(".Content").val() == "") {
                e.preventDefault()
                $(".error_content").css("display", "block")

            }

            if ($(".Content").val() != "") {
                $(".Error_Content").css("display", "none")

            }

            if ($(".Level").val() == 0) {
                e.preventDefault()
                $(".error_level").css("display", "block")
            }

            if ($(".Level").val() != 0) {
                $(".error_level").css("display", "none")
            }

            if ($(".User").val() == 0) {
                e.preventDefault()
                $(".error_user").css("display", "block")
            }

            if ($(".User").val() != 0) {
                $(".error_user").css("display", "none")
            }
        })
        //Validate submit and Return button
        $(".btnContent").click(function (e) {
            if ($(".Content").val() == "") {
                e.preventDefault()
                $(".error_content").css("display", "block")

            }

            if ($(".Content").val() != "") {
                $(".Error_Content").css("display", "none")

            }

            if ($(".Level").val() == 0) {
                e.preventDefault()
                $(".error_level").css("display", "block")
            }

            if ($(".Level").val() != 0) {
                $(".error_level").css("display", "none")
            }

            if ($(".User").val() == 0) {
                e.preventDefault()
                $(".error_user").css("display", "block")
            }

            if ($(".User").val() != 0) {
                $(".error_user").css("display", "none")
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

        $(".txtContent").focusout(function () {
            textValue = $.trim($(this).val());
            if (textValue == '') {
                $.trim($(this).val('')); //to set it blank
            } else {
                return true;
            }
        });
    </script>
</asp:Content>
