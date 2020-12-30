<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="EditQuanlityAnalysis.aspx.vb" Inherits="KPI.EditQuanlityAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/QuanlityStyle/QuanlityStyle.css" rel="stylesheet" />
    <div class="container">
        <div class="justify-content-center" style="width: 100%">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary"><asp:Literal ID="Literal6" runat="server" Text="<%$Resources:KPI.language, editQuanlity%>"></asp:Literal></h6>
                </div>
                <div class="card-body">
                    <div class="container">
                        <div class="formUser">
                            <div class="form-group m-5">
                                <label class="font-weight-bold"><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, targetDesign%>"></asp:Literal></label>
                                <asp:TextBox ID="txtWorkDesign" TextMode="Number" min="0" CssClass="form-control form-control-user txtWork"  runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group m-5">
                                <label class="font-weight-bold"><asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, targetCode%>"></asp:Literal></label>
                                <asp:TextBox ID="txtWorkCode" TextMode="Number" min="0" CssClass="form-control form-control-user"  runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group m-5">
                                <label class="font-weight-bold"><asp:Literal ID="Literal2" runat="server" Text="<%$Resources:KPI.language, targetTest%>"></asp:Literal></label>
                                <asp:TextBox ID="txtWorkTest" TextMode="Number" min="0" CssClass="form-control form-control-user"  runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group m-5">
                                <label class="font-weight-bold"><asp:Literal ID="Literal4" runat="server" Text="<%$Resources:KPI.language, reason%>"></asp:Literal></label>
                                <asp:TextBox ID="txtReason" TextMode="MultiLine" CssClass="form-control form-control-user txtReason"  runat="server"></asp:TextBox>
                                <span class="error_reason" style="color: red; display: none"><asp:Literal ID="Literal7" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal></span>
                            </div>
                            <%--<a href="login.html" class="btn btn-primary btn-user btn-block">Reset Password
                            </a>--%>
                            <div class="row button-click justify-content-end mr-5">
                                <%--<div class="col-xl-6 col-lg-6 col-md-1">
                            </div>--%>
                                <div>
                                    <asp:Button ID="btnUpdate" CssClass="btn btn-primary btn-user btn-block" runat="server" Text="<%$Resources:KPI.language, btnEdit%>" />
                                </div>
                                <div>
                                    <a href="/Quanlity" class="btn btn-danger btn-user btn-block" style="margin-left: 10px;"><asp:Literal ID="Literal5" runat="server" Text="<%$Resources:KPI.language, cancel%>"></asp:Literal></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>               
        $(".btnUpdate").click(function (e) {
            if ($(".txtReason").val() == "") {
                e.preventDefault()
                $(".error_reason").css("display", "block")

            }

            if ($(".txtReason").val() != "") {
                $(".error_reason").css("display", "none")

            }
        });

        $(".txtReason").focusout(function () {
            textValue = $.trim($(this).val());
            if (textValue == '') {
                $.trim($(this).val('')); //to set it blank
            } else {
                return true;
            }
        });
    </script>
</asp:Content>
