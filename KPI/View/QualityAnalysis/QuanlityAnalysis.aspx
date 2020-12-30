<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="QuanlityAnalysis.aspx.vb" Inherits="KPI.QuanlityAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/QuanlityStyle/QuanlityStyle.css" rel="stylesheet" />
    <div class="justify-content-center" style="margin: 15px;">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary"><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, analysis%>"></asp:Literal></h6>
            </div>
            <div class="card-body">
                <div style="margin-bottom: 5px; display: flex; justify-content: space-between">
                    <asp:Button ID="btnDowloadCSV" CssClass="btn btn-success btndowload" runat="server" Text="<%$Resources:KPI.language, csv%>" />
                    <div style="display: flex" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control bg-light border-0 small" Text='<%#Session("Search")%>' placeholder="<%$Resources:KPI.language, search%>"></asp:TextBox>
                        <div class="input-group-append">
                            <asp:LinkButton ID="lkbSearch" runat="server" CssClass="btn btn-primary btnSearch"><i class="fas fa-search"></i></asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <asp:GridView CssClass="table table-bordered table-striped" ID="grvQA" runat="server" ShowHeaderWhenEmpty="true"
                        name="grvQA"
                        AllowCustomPaging="true"
                        AllowPaging="true"
                        OnRowCommand="RowCommand"
                        OnPageIndexChanging="RowIndexChanging"
                        PagerSettings-Mode="NumericFirstLast"
                        PagerSettings-FirstPageText="<<"
                        PagerSettings-LastPageText=">>"
                        ShowHeader="true"
                        HeaderStyle-CssClass="tableHeader"
                        HeaderStyle-ForeColor="#444242"
                        EmptyDataText="<%$Resources:KPI.language, empData%>"
                        EmptyDataRowStyle-ForeColor="Red"
                        AutoGenerateColumns="False">
                        <Columns>
                            <asp:TemplateField HeaderText="項番">
                                <HeaderTemplate>
                                    <asp:Label ID="lblHeaderNumOrder" runat="server" Text="<%$Resources:KPI.language, clmNum%>"></asp:Label><asp:LinkButton ID="lkbSortNumOrder" runat="server" CommandName="SORTORDERROWNUM" CssClass='<%#Session("SortIconNumorder") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblStt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "RowNumber") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="改修内容" ItemStyle-Width="30%">
                                <HeaderTemplate>
                                    <asp:Label ID="lblHeaderContent" runat="server" Text="<%$Resources:KPI.language, clmTask%>"></asp:Label><asp:LinkButton ID="lkbSortContent" runat="server" CommandName="SORTCONTENT" CssClass='<%#Session("SortIconContent") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblContent" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Content") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="難易度">
                                <HeaderTemplate>
                                    <asp:Label ID="lblHeaderLevel" runat="server" Text="<%$Resources:KPI.language, clmLevel%>"></asp:Label><asp:LinkButton ID="lkbSortLevel" runat="server" CommandName="SORTLEVEL" CssClass='<%#Session("SortIconLevel") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblTodoID" runat="server" Text='<%#If(Session("lang") = "vi", DataBinder.Eval(Container.DataItem, "Level"), DataBinder.Eval(Container.DataItem, "Levelja")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="修メイン担当">
                                <HeaderTemplate>
                                    <asp:Label ID="lblHeaderMember" runat="server" Text="<%$Resources:KPI.language, clmUser%>"></asp:Label><asp:LinkButton ID="lkbSortMember" runat="server" CommandName="SORTMEMBER" CssClass='<%#Session("SortIconMember") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblEditStatusID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "FullName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="★あり：問題の原因分析、改善方針等々  ★なし：成功の原因分析、波及方法等々">
                                <HeaderTemplate>
                                    <div class="text-overflow"><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, reason%>"></asp:Literal></div>
                                    <%--<asp:Label ID="lblHeaderReason"  runat="server" Text="<%$Resources:KPI.language, reason%>"></asp:Label>--%><asp:LinkButton ID="lkbSortReason" runat="server" CommandName="SORTREASON" CssClass='<%#Session("SortIconReason") %>'></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblReason" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Reason") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="<%$Resources:KPI.language, clmAction%>">
                                <ItemTemplate>
                                    <asp:Button ID="btnDetail" CssClass="btn btn-outline-success" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "IdTask") %>' OnClick="btnDetail" runat="server" Text="<%$Resources:KPI.language,btnDetail %>" />
                                    <%If KPI.UserCookieData.GetUserData.RoleName <> "Manager" And KPI.UserCookieData.GetUserData.RoleName <> "Admin" And KPI.UserCookieData.GetUserData.RoleName <> "User" Then
                                    %>
                                    <asp:Button ID="btnEdit" CssClass="btn btn-outline-primary" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "IdTask") %>' OnClick="btnEdit" runat="server" Text="<%$Resources:KPI.language,btnEdit %>" />
                                    <%
                                        End If
                                    %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    <asp:TextBox ID="txtGuid" runat="server" CssClass="GUID"></asp:TextBox>
    <script src="../../Scripts/QuanlityScript/QuanlityScript.js"></script>
</asp:Content>
