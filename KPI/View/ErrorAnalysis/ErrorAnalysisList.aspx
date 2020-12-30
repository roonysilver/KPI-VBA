<%@ Page Title="バグ分類及び分析表" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="ErrorAnalysisList.aspx.vb" Inherits="KPI.ErrorAnalysisList" %>

<asp:Content ID="ErrorAnalysis" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page level plugins -->
    <div style="margin: 15px">
        <link href="../../Content/Site.css" rel="stylesheet" />
        <!-- Page Heading -->
        <%--<h1 class="h3 mb-2 text-gray-800">Hạng mục lỗi review ・bảng phân loại lỗi và phân tích</h1>--%>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary"><asp:Literal ID="Literal2" runat="server" Text="<%$Resources:KPI.language, titleErrorAnalysis%>"></asp:Literal></h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <div style="display: flex; justify-content: space-between;flex-wrap:wrap">
                        <div style="margin-bottom: 5px">
                            <asp:Button ID="btnReturn" CommandName="Return" CssClass="btn btn-success btn-user btnReturn" runat="server" Text="<%$Resources:KPI.language, btnBack%>" />
                            <%If KPI.UserCookieData.GetUserData().RoleName = "Leader" Then %>
                            <a href="/ErrorAnalysis/Add?idTask=<%=Request.QueryString("id") %>" class="btn btn-primary"><i class="fas fa-plus"></i><asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, btnAddError%>"></asp:Literal></a>
                            <asp:Button ID="btnDeleteMulti" CssClass="btn btn-danger btn-user btnDeleteMulti" runat="server" Text="<%$Resources:KPI.language, btnDelete%>" />
                            <%End If%>
                        </div>
                        <div class="input-group" style="display: flex; margin-bottom: 5px">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control bg-light border-0 small" Text='<%#Session("Search")%>' placeholder="<%$Resources:KPI.language, search%>"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:LinkButton ID="lkbSearch" runat="server" CssClass="btn btn-primary btnSearch"><i class="fas fa-search"></i></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <asp:GridView ID="grvErrorAnalysis" runat="server" Width="100%" HeaderStyle-CssClass="header-color"
                        AutoGenerateColumns="False"
                        AllowSorting="true"
                        AllowPaging="true"
                        AllowCustomPaging="true"
                        OnPageIndexChanging="grvErrorAnalysis_IndexChange"
                        EmptyDataText="<%$Resources:KPI.language, empData%>"
                        EmptyDataRowStyle-ForeColor="Red"
                        ShowHeaderWhenEmpty="true"
                        HeaderStyle-ForeColor="#444242"
                        CssClass="table table-bordered table-top table-striped">
                        <Columns>
                            <asp:TemplateField HeaderText="" HeaderStyle-Width="2%">
                                <HeaderTemplate>
                                    <input id="chkSelect" name="Select All" type="checkbox"></input>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="clbSelect" runat="server" CssClass="clbSelect" AutoPostBack="false" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="項番" HeaderStyle-Width="5%">
                                <HeaderTemplate>
                                    <asp:Label ID="lblHeaderNumOrder" runat="server" Text="<%$Resources:KPI.language, clmNum%>"></asp:Label><asp:LinkButton ID="lkbSortNumOrder" runat="server" CommandName="SORTORDERROWNUM" CssClass='<%#Session("SortIconNumorder") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblRownum" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "rownum") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="No" SortExpression="ContentId" HeaderStyle-Width="100px" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblStt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "IdErrorAnalysis") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="フェーズ" HeaderStyle-Width="8%">
                                  <HeaderTemplate>
                                    <asp:Label ID="lblHeaderPhase" runat="server" Text="<%$Resources:KPI.language, clmPhase%>"></asp:Label><asp:LinkButton ID="lkbSortPhase" runat="server" CommandName="SORTPHASE" CssClass='<%#Session("SortIconPhase") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>

                                    <asp:Label ID="lblPhase" runat="server" Text='<%#If(Session("lang") = "ja", DataBinder.Eval(Container.DataItem, "NamePhaseJP"), DataBinder.Eval(Container.DataItem, "NamePhase"))%>'></asp:Label>

                                </ItemTemplate>

                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="レビュー指摘事項・バグ分類" HeaderStyle-Width="500px">
                                <HeaderTemplate>
                                    <asp:Label ID="lblHeaderContent" runat="server" Text="<%$Resources:KPI.language, clmErrorAnalysis%>"></asp:Label><asp:LinkButton ID="lkbSortContent" runat="server" CommandName="SORTCONTENT" CssClass='<%#Session("SortIconContent") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>

                                    <asp:Label ID="lblError" runat="server" Text='<%#If(Session("lang") = "ja", DataBinder.Eval(Container.DataItem, "NameErrorJP"), DataBinder.Eval(Container.DataItem, "NameError"))%>'></asp:Label>

                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="指摘・バグ件数" HeaderStyle-Width="180px">
                                 <HeaderTemplate>
                                    <asp:Label ID="lblHeaderBug" runat="server" Text="<%$Resources:KPI.language, clmBug%>"></asp:Label><asp:LinkButton ID="lkbSortBug" runat="server" CommandName="SORTBUG" CssClass='<%#Session("SortIconBug") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>

                                    <asp:Label ID="lblBug" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Bug") %>'></asp:Label>

                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="備考" HeaderStyle-Width="30%">
                                 <HeaderTemplate>
                                    <asp:Label ID="lblHeaderReference" runat="server" Text="<%$Resources:KPI.language, clmReference%>"></asp:Label><asp:LinkButton ID="lkbSortReference" runat="server" CommandName="SORTREFERENCE" CssClass='<%#Session("SortIconReference") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>

                                    <asp:Label ID="lblReference" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Reference") %>'></asp:Label>

                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="<%$Resources:KPI.language, clmAction%>" ControlStyle-Width="70px" HeaderStyle-Width="11%" >

                                <ItemTemplate>
                                    <div>
                                        <asp:Button ID="btnEdit" CommandName="Edit" CssClass="btn btn-outline-primary btn-user btnEdit" runat="server" Text="<%$Resources:KPI.language, btnEdit%>" CommandArgument="<%# Container.DataItemIndex %>" />
                                        <asp:Button ID="btnDelete" CommandName="Delete" CssClass="btn btn-outline-danger btn-user btnDetail" runat="server" Text="<%$Resources:KPI.language, btnDelete%>" OnClientClick="return confirm($('.delete-confirm').text());" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </div>
                                </ItemTemplate>

                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>
                </div>
            </div>
        </div>
        <div class="delete-confirm" style="display:none"><asp:Literal ID="Literal4" runat="server" Text="<%$Resources:KPI.language, confDelete%>"></asp:Literal></div>
    </div>
    <style>
        .GUID {
            display: none;
        }

        .button_change_GUID {
            margin-left: 3px;
            text-decoration: none !important;
            color: #444242 !important;
        }
    </style>
    <!-- /.container-fluid -->
    <script type="text/javascript">
        // check list form checkbox with 1 or many row
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
        $('.btnDeleteMulti').on('click', function (e) {
            //keep stable if there's haven't select any row yet.
            if (numberOfCheck == 0) {
                e.preventDefault();
            } else {
                var cf = confirm('この改修レビューを本当に削除しますか？削除後は元に戻すことはできません。');
                if (!cf) {
                    e.preventDefault();
                }
            }
            FillTxtGuid();
        })

        //change GUID when click button
        $(".button_change_GUID").click(function () { ChangeGuid() })
        function GuidGenerate() {
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });
        }
        function ChangeGuid() {
            $(".GUID").val(GuidGenerate())
        }
    </script>
    <asp:TextBox ID="txtGuid" runat="server" CssClass="GUID"></asp:TextBox>
</asp:Content>
