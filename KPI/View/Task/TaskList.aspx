<%@ Page Title="タスクリスト" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="TaskList.aspx.vb" Inherits="KPI.TaskList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin: 15px">
        <link href="../../Content/Site.css" rel="stylesheet" />
        <!-- Page Heading -->
        <%--        <h1 class="h3 mb-2 text-gray-800">Hạng mục lỗi review ・bảng phân loại lỗi và phân tích</h1>--%>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary"><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, taskHeader%>"></asp:Literal></h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <div style="display: flex; justify-content: space-between; flex-wrap:wrap">                       
                        <div style="margin-bottom: 5px">
                            <%If KPI.UserCookieData.GetUserData().RoleName = "Leader" Then %>
                            <a href="/Task/Add" class="btn btn-primary"><i class="fas fa-plus"></i><asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, btnAddTask%>"></asp:Literal></a>
                            <a href="/ErrorAnalysis/Create" class="btn btn-primary"><i class="fas fa-plus"></i><asp:Literal ID="Literal2" runat="server" Text="<%$Resources:KPI.language, btnAddError%>"></asp:Literal></a>
                            <asp:Button ID="btnDeleteMulti" CssClass="btn btn-danger btnDeleteMulti" runat="server" Text="<%$Resources:KPI.language, btnDelete%>"></asp:Button>
                            <%End If %>
                            <asp:Button ID="btntoCsv" runat="server" CssClass="btn btn-success" Text="<%$Resources:KPI.language, csv%>" OnClick="btntoCsv_Click" OnClientClick="return confirm($('.download-confirm').text());" />
                        </div>
                         <div class="input-group" style="display: flex; margin-bottom: 5px">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control bg-light border-0 small" Text='<%#Session("Search")%>' placeholder="<%$Resources:KPI.language, search%>"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:LinkButton ID="lkbSearch" runat="server" CssClass="btn btn-primary btnSearch"><i class="fas fa-search"></i></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <asp:GridView ID="grvContent" runat="server" Width="100%" HeaderStyle-CssClass="header-color"
                        AutoGenerateColumns="False"
                        AllowSorting="true"
                        AllowPaging="true"
                        AllowCustomPaging="true"
                        OnPageIndexChanging="grvTodoList_IndexChange"
                        EmptyDataText="<%$Resources:KPI.language, empData%>"
                        EmptyDataRowStyle-ForeColor="Red"
                        ShowHeaderWhenEmpty="true"
                        HeaderStyle-ForeColor="#444242"
                        CssClass="table table-bordered table-top table-striped">
                        <Columns>
                            <asp:TemplateField HeaderText="">
                                <HeaderTemplate>
                                    <input id="chkSelect" name="Select All" type="checkbox"></input>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="clbSelect" runat="server" CssClass="clbSelect" AutoPostBack="false"  Width="1%"/>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="項番" ItemStyle-Width="70px">
                                <HeaderTemplate>
                                    <asp:Label ID="lblHeaderNumOrder" runat="server" Text="<%$Resources:KPI.language, clmNum%>"></asp:Label><asp:LinkButton ID="lkbSortNumOrder" runat="server" CommandName="SORTORDERROWNUM" CssClass='<%#Session("SortIconNumorder") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblRownum" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "rownum") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="STT" SortExpression="ContentId" HeaderStyle-Width="100px" Visible="false">

                                <ItemTemplate>
                                    <asp:Label ID="lblStt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "IdTask") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="改修内容" ItemStyle-Width="50%">
                                <HeaderTemplate>
                                    <asp:Label ID="lblHeaderContent" runat="server" Text="<%$Resources:KPI.language, clmTask%>"></asp:Label><asp:LinkButton ID="lkbSortContent" runat="server" CommandName="SORTCONTENT" CssClass='<%#Session("SortIconContent") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>

                                    <asp:Label ID="lblContent" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Content") %>' Width="100%"></asp:Label>

                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="改修メイン担当">
                                 <HeaderTemplate>
                                    <asp:Label ID="lblHeaderName" runat="server" Text="<%$Resources:KPI.language, clmUser%>"></asp:Label><asp:LinkButton ID="lkbSortFirstName" runat="server" CommandName="SORTFIRSTNAME" CssClass='<%#Session("SortIconFirstName") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>

                                    <asp:Label ID="lblUser" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "FirstName") %>'></asp:Label>
                                    <asp:Label ID="lblLastName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "LastName") %>'></asp:Label>

                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="難易度">
                                <HeaderTemplate>
                                    <asp:Label ID="lblHeaderLevel" runat="server" Text="<%$Resources:KPI.language, clmLevel%>"></asp:Label><asp:LinkButton ID="lkbSortLevel" runat="server" CommandName="SORTLEVEL" CssClass='<%#Session("SortIconLevel") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    
                                    <asp:Label ID="lblLevel" runat="server" Text='<%#If(Session("lang") = "ja", DataBinder.Eval(Container.DataItem, "LevelJP"), DataBinder.Eval(Container.DataItem, "Level"))%>'></asp:Label>

                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="作成日">
                                 <HeaderTemplate>
                                    <asp:Label ID="lblHeaderCreateAt" runat="server" Text="<%$Resources:KPI.language, clmCreateAt%>"></asp:Label><asp:LinkButton ID="lkbSortCreateAt" runat="server" CommandName="SORTCREATEAT" CssClass='<%#Session("SortIconCreateAt") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>

                                    <asp:Label ID="lblCreateAt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CreateAt") %>' Width="100%"></asp:Label>

                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="<%$Resources:KPI.language, clmAction%>">

                                <ItemTemplate>
                                    <div>
                                        <asp:Button ID="btnDetail" CommandName="List" CssClass="btn btn-outline-success btnDetail" runat="server" Text="<%$Resources:KPI.language, btnDetail%>" CommandArgument="<%# Container.DataItemIndex %>" />
                                        <%If KPI.UserCookieData.GetUserData().RoleName = "Leader" Then %>
                                        <asp:Button ID="btnEdit" CommandName="Edit" CssClass="btn btn-outline-primary btn-user btn-user btnEdit" runat="server" Text="<%$Resources:KPI.language, btnEdit%>" CommandArgument="<%# Container.DataItemIndex %>" />
                                        <asp:Button ID="btnDelete" CommandName="Delete" CssClass="btn btn-outline-danger btn-user btnDetail" runat="server" Text="<%$Resources:KPI.language, btnDelete%>" OnClientClick="return confirm($('.delete-confirm').text());" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </div>
                                    <%End If%>
                                </ItemTemplate>

                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>
                </div>
            </div>
        </div>
        <div class="delete-confirm" style="display:none"><asp:Literal ID="Literal4" runat="server" Text="<%$Resources:KPI.language, confDelete%>"></asp:Literal></div>
        <div class="download-confirm" style="display:none"><asp:Literal ID="Literal8" runat="server" Text="<%$Resources:KPI.language, confDownload%>"></asp:Literal></div>
    </div>
    <!-- /.container-fluid -->
    <script type="text/javascript">
        // check list form checkbox with 1 or many row
        var numberOfCheck = 0;
        $('#chkSelect').on('change', function () {
            $(this).closest('table').find('td input:checkbox').prop('checked', this.checked);
            //count total check box -1 
            if ($(this).prop("checked") == true) {
                numberOfCheck = $('input:checkbox:checked').length - 1;
            }
            else if ($(this).prop("checked") == false) {
                numberOfCheck = 0;
            }
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
            // in other hand numberOfCheck--
        });
        $('.btnDeleteMulti').on('click', function (e) {
            //keep stable if there's haven't select any row yet.
            if (numberOfCheck == 0) {
                e.preventDefault();
            } else {
                var cf = confirm($('.delete-confirm').text());
                if (!cf) {
                    e.preventDefault();
                }
            }
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
