<%@ Page Title="Project" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="Input.aspx.vb" Inherits="KPI.Input" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/ProjectStyle/ProjectStyle.css" rel="stylesheet" />
    <div class="container" style="width: 100%">
        <asp:Label runat="server" ID="lblMess" Text="" Font-Size="20px" CssClass="m-0 font-weight-bold text-primary"></asp:Label>
        <div class="">
            <div class="card shadow mb-4">
                <div class="card-header py-3 with-border">
                    <asp:Label runat="server" ID="lblTitle" Text="" Font-Size="20px" CssClass="Messager m-0 font-weight-bold text-primary"></asp:Label>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label for="dl"><b><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, clmNP%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                        <asp:TextBox ID="txtDuAn" runat="server" CssClass="form-control txt-project txtProject"></asp:TextBox>
                        <label class="error-nameProject" style="color: red; font-weight: bold; display: none"><asp:Literal ID="Literal5" runat="server" Text="<%$Resources:KPI.language, errorNullProject%>"></asp:Literal></label>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="期日入力してください" ControlToValidate="txtDuAn" ForeColor="Red" Font-Bold="true" CausesValidation="false"></asp:RequiredFieldValidator>--%>
                    </div>
                    <div class="form-group">
                        <label for="dl"><b><asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, clmDP%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                        <asp:DropDownList ID="ddlBoPhan" runat="server" CssClass="form-control Def">
                             <asp:ListItem Value="0">--担当者・リーダーを選択してください--</asp:ListItem>
                        </asp:DropDownList>
                        <label class="error_def" style="color: red; font-weight: bold; display: none"><asp:Literal ID="Literal7" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal></label>
                    </div>
                    <div class="form-group" id="selection_model">
                        <label for="dl"><b><asp:Literal ID="Literal2" runat="server" Text="<%$Resources:KPI.language, clmLeader%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                        <asp:DropDownList ID="dllPL" runat="server" SelectionMode="Multiple" data-placeholder="Select PL" CssClass="form-control PL" />
                        <label class="error_PL" style="color: red; font-weight: bold; display: none"><asp:Literal ID="Literal8" runat="server" Text="<%$Resources:KPI.language, errorNullData%>"></asp:Literal></label>
                    </div>
                    <div class=" form-group">
                        <input id="inpHide" type="hidden" runat="server" />
                        <label for="dl"><b><asp:Literal ID="Literal4" runat="server" Text="<%$Resources:KPI.language, clmMember%>"></asp:Literal></b><span style="font-weight: bold; color: red">(*)</span></label>
                        <select class="mutilselect" multiple="multiple" data-placeholder="<%=Resources.KPI.language.holderMemberSelect %>" id="member">
                            <% Dim objUser As New KPI.DepartmentService
                    Dim projectService As New KPI.ProjectService()
                    Dim lstidMember = projectService.GetMemberProject(Session("idProject"))
                    If lstidMember.Count <> 0 Then
                        For Each i In objUser.ListUser(Session("idProject"))
                            Dim flagMemberSelected As Integer = 0
                            For Each item As KPI.ProjectInfo In lstidMember
                                If i.IdUser = item.IdMember Then
                                    flagMemberSelected = 1
                                    Exit For
                                End If
                            Next
                            If flagMemberSelected Then
                            %>
                            <option value="<%=i.IdUser %>" selected><%=i.FullName %></option>
                            <%
                    Else
                            %>
                            <option value="<%=i.IdUser %>"><%=i.FullName %></option>
                            <%
                                        End If
                                    Next

                                Else
                                    For Each item As KPI.UserInfo In objUser.ListUser(Session("idProject"))
                            %>
                            <option value="<%=item.IdUser %>"><%=item.FullName %></option>
                            <%
                        Next
                    End If

                            %>
                        </select>

                        <label class="error_member" style="color: red; font-weight: bold; display: none"><asp:Literal ID="Literal6" runat="server" Text="<%$Resources:KPI.language, errorNullMember%>"></asp:Literal></label>
                        <%--<asp:ListBox runat="server" ID="lstMember" CssClass="mutilselect form-control" SelectionMode="Multiple">
                        </asp:ListBox>--%>
                        <%--<asp:DropDownList ID="dlluser" runat="server" SelectionMode="Multiple" data-placeholder="Select PL" CssClass="form-control mutilselect" />--%>
                    </div>
                </div>
                <asp:TextBox ID="txtListMember" runat="server" CssClass="lstMember" Text=""></asp:TextBox>
                <div class=" row justify-content-end mr-3 mb-3">
                    <asp:Button ID="btnSub" runat="server" Text="<%$Resources:KPI.language, accept%>" CssClass="btn btn-success mr-3 btnSubmit" />
                    <%--<a href="../"class="btn btn-danger">キャンセル</a>--%>
                    <asp:Button ID="btnCancle" CssClass="btn btn-danger" runat="server" Text="<%$Resources:KPI.language, cancel%>" />
                </div>
            </div>
        </div>
    </div>
    <style>
        .lstMember {
            display: none
        }


    </style>
    <script>
        $(document).ready(function () {
            $('#accordionSidebar').hide()
            $('#sidebarToggleTop').hide()
            // create MultiSelect from select HTML element
            var optional = $(".mutilselect").kendoMultiSelect({
                autoClose: false
            }).data("kendoMultiSelect");
            $(".btnSubmit").click(function (e) {
                if (optional.value().length == 0) {
                    e.preventDefault()
                    $(".error_member").css("display", "block")
                }
                if ($(".txt-project").val().replace(/\s+/g, ' ').trim() == "") {
                    e.preventDefault()
                    $(".error-nameProject").css("display", "block")
                }
                if ($(".Def").val().trim() == "") {
                    e.preventDefault()
                    $(".error_def").css("display", "block")
                }
                if ($(".PL").val() == 0) {
                    e.preventDefault()
                    $(".error_PL").css("display", "block")
                }
                $('.lstMember').val(optional.value())
            })
        });
    </script>
</asp:Content>
