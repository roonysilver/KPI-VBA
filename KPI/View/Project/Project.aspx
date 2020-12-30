<%@ Page Title="Project" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="Project.aspx.vb" Inherits="KPI.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%Dim user As KPI.UserInfo = KPI.UserCookieData.GetUserData() %>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary"><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, carHeader%>"></asp:Literal></h6>
        </div>
        <div class="card-body">
            <div style="display: flex; justify-content: space-between; margin-bottom: 5px">
                <div class="right" style="display: flex">
                    <%If user.RoleName = "Manager" Then %>

                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-success" Text="<%$Resources:KPI.language, btnAdd%>" />
                    <asp:Button ID="btnDelete" runat="server" Text="<%$Resources:KPI.language, btnDelete%>" CssClass="btn btn-danger btnDelete" />
                    <%End If %>
                </div>
                <div class="left input-group" style="display: flex">
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="<%$Resources:KPI.language, search%>" CssClass="form-control bg-light border-0 small" Text='<%#Session("Search") %>'></asp:TextBox>
                    <span class="input-group-btn input-group-append">
                        <asp:LinkButton runat="server" ID="lkbSearch" CssClass="btn btn-primary btn-flat"> <i class="fa fa-search"></i> 
                        </asp:LinkButton>
                    </span>
                </div>
            </div>
            <div class="table-responsive">
                <asp:GridView ID="grvProject" runat="server" Width="100%"
                    AutoGenerateColumns="False"
                    CssClass="table table-bordered table-striped"
                    ShowHeaderWhenEmpty="true"
                    EmptyDataText="<%$Resources:KPI.language, empData%>"
                    EmptyDataRowStyle-ForeColor="Red"
                    HeaderStyle-ForeColor="#444242"
                    HeaderStyle-CssClass="header_style"
                    AllowCustomPaging="true"
                    AllowPaging="true"
                    OnPageIndexChanging="RowIndexChanging"
                    PagerSettings-Mode="NumericFirstLast"
                    PagerSettings-FirstPageText="<<"
                    PagerSettings-LastPageText=">>" PageSize="10">
                    <Columns>
                        <asp:TemplateField HeaderText="" HeaderStyle-Width="5%">
                            <HeaderTemplate>
                                <input id="chkSelect" name="Select All" type="checkbox"></input>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="clbSelect" runat="server" CssClass="clbSelect" AutoPostBack="false" />
                                <asp:Label ID="lblID" Visible="False" runat="server" Text='<%# Eval("IdProject") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$Resources:KPI.language, clmNum%>" HeaderStyle-Width="5%">
                            <ItemTemplate>
                                <asp:Label ID="lblRowNumber" Text='<%# grvProject.PageIndex * 10 + Container.DataItemIndex + 1 %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$Resources:KPI.language, clmNP%>" HeaderStyle-Width="10%">
                            <ItemTemplate>
                                <asp:Label ID="lblNameProject" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "NameProject") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$Resources:KPI.language, clmDP%>" HeaderStyle-Width="20%">
                            <ItemTemplate>
                                <asp:Label ID="lblNameDepartment" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "NameDepartment") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$Resources:KPI.language, clmLeader%>" HeaderStyle-Width="20%">
                            <ItemTemplate>
                                <asp:Label ID="lblNameUser" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "NameUser") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$Resources:KPI.language, clmMember%>" HeaderStyle-Width="20%">
                            <ItemTemplate>
                                <asp:Label ID="lblNameMember" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "NameMember") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:Button ID="btnDetail" runat="server" CommandArgument='<%# Eval("IdProject") %>' OnClick="DetailClick" Text="<%$Resources:KPI.language, btnDetail%>" CssClass="btn btn-outline-info" />
                                <%If KPI.UserCookieData.GetUserData().RoleName = "Manager" Then %>
                                <asp:Button ID="btnEdit" runat="server" CommandArgument='<%# Eval("IdProject") %>' OnClick="EditClick" CssClass="btn btn-outline-success" Text="<%$Resources:KPI.language, btnEdit%>" />
                                <asp:LinkButton ID="hylDelete" runat="server" CommandArgument='<%# Eval("IdProject") %>' OnClick="OnClickHandler" OnClientClick="return ConfirmDelete()" CssClass="btn btn-outline-danger"><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, btnDelete%>"></asp:Literal></asp:LinkButton>
                                <%End If %>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                </asp:GridView>
            </div>
        </div>
    </div>
    <style>
        .btnDelete {
            margin-left: 5px
        }
    </style>
    <script src="Themes/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="Themes/vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <script type="text/javascript">
        // check list form checkbox with 1 or many row
        $('#accordionSidebar').hide()
        $('#sidebarToggleTop').hide()
        var numberOfCheck = 0;
        $('#chkSelect').on('change', function () {
            $(this).closest('table').find('td input:checkbox').prop('checked', this.checked);
            //count totak check box -1 
            if ($(this).prop("checked") == true) {
                numberOfCheck = $('input:checkbox:checked').length - 1;
            }
            else if ($(this).prop("checked") == false) {
                numberOfCheck = 0;
            }
            console.log(numberOfCheck);
        });
        $('.clbSelect').on('change', function () {
            //if uncheck any row then numberOfCheck++
            var input = $(this).children()
            if (input.prop("checked") == true) {
                numberOfCheck++;
            }
            else if (input.prop("checked") == false) {
                numberOfCheck--;
            }
            console.log(numberOfCheck);
            // in other hand numberOfCheck--
        });
        $('.btnDelete').on('click', function (e) {
            //keep stable if there's haven't select any row yet.
            if (numberOfCheck == 0) {
                e.preventDefault();
                confirm("<%=Resources.KPI.language.confCkDelete%>");
            } else {
                var cf = confirm("<%=Resources.KPI.language.confDelete%>");
                if (!cf) {
                    e.preventDefault();
                }
            }
        })
        function ConfirmDelete() {
            var cf = confirm("<%=Resources.KPI.language.confDelete%>");
            if (cf) return true;
            return false;
        }
    </script>
</asp:Content>
