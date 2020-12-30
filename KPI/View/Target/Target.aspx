<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="Target.aspx.vb" Inherits="KPI.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%Dim objData = SetData()
        If objData.AcceptOSCTarget.ToString() = "NaN" Then
            objData.AcceptOSCTarget = 0
        End If
        If objData.AcceptBRCTarget.ToString() = "NaN" Then
            objData.AcceptBRCTarget = 0
        End If
        If objData.AcceptProfessionTarget.ToString() = "NaN" Then
            objData.AcceptProfessionTarget = 0
        End If
        If objData.CodeTarget.ToString() = "NaN" Then
            objData.CodeTarget = 0
        End If
        If objData.DesignTarget.ToString() = "NaN" Then
            objData.DesignTarget = 0
        End If
        If objData.TestTarget.ToString() = "NaN" Then
            objData.TestTarget = 0
        End If
        %>
    <div class="justify-content-center" style="margin: 15px;">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary"><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, cardheaderTarget%>"></asp:Literal></h6>
            </div>
            <div class="card-body">
                <div style="margin-bottom:5px; display:flex; justify-content:flex-start">
                    <%--<a href="/View/Project/Project.aspx" class="btn btn-primary btnBack">戻る</a>--%>
                    <asp:Button ID="btnDowloadCSV" CssClass="btn btn-success btndowload" runat="server" Text="<%$Resources:KPI.language, csv%>"  />
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped" style="min-width:550px">
                        <thead>
                            <tr>
                                <th scope="col"><asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, clmNum%>"></asp:Literal></th>
                                <th scope="col"><asp:Literal ID="Literal2" runat="server" Text="<%$Resources:KPI.language, phase%>"></asp:Literal></th>
                                <th scope="col"><asp:Literal ID="Literal4" runat="server" Text="<%$Resources:KPI.language, menu%>"></asp:Literal></th>
                                <th scope="col" ><asp:Literal ID="Literal5" runat="server" Text="<%$Resources:KPI.language, average%>"></asp:Literal></th>
                                <th scope="col"><asp:Literal ID="Literal6" runat="server" Text="<%$Resources:KPI.language, tolerance%>"></asp:Literal></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">1</th>
                                <td><asp:Literal ID="Literal7" runat="server" Text="<%$Resources:KPI.language, designPhase%>"></asp:Literal></td>
                                <td><asp:Literal ID="Literal13" runat="server" Text="<%$Resources:KPI.language, errorRateOndesign%>"></asp:Literal></td>
                                <td><%=Math.Round(objData.DesignTarget, 4)%></td>
                                <td><%=Math.Round(objData.DesignTarget * 0.7, 4)%>~<%=Math.Round(objData.DesignTarget * 1.3, 4)%></td>
                            </tr>
                            <tr>
                                <th scope="row">2</th>
                                <td><asp:Literal ID="Literal8" runat="server" Text="<%$Resources:KPI.language, codePhase%>"></asp:Literal></td>
                                <td><asp:Literal ID="Literal14" runat="server" Text="<%$Resources:KPI.language, errorRateOnCode%>"></asp:Literal></td>
                                <td><%=Math.Round(objData.CodeTarget, 4)%></td>
                                <td><%=Math.Round(objData.CodeTarget * 0.7, 4)%>~<%=Math.Round(objData.CodeTarget * 1.3, 4)%></td>
                            </tr>
                            <tr>
                                <th scope="row">3</th>
                                <td><asp:Literal ID="Literal9" runat="server" Text="<%$Resources:KPI.language, testPhase%>"></asp:Literal></td>
                                <td><asp:Literal ID="Literal15" runat="server" Text="<%$Resources:KPI.language, errorRateOnTest%>"></asp:Literal></td>
                                <td><%=Math.Round(objData.TestTarget, 4)%></td>
                                <td><%=Math.Round(objData.TestTarget * 0.7, 4)%>~<%=Math.Round(objData.TestTarget * 1.3, 4)%></td>
                            </tr>
                            <tr>
                                <th scope="row">4</th>
                                <td><asp:Literal ID="Literal10" runat="server" Text="<%$Resources:KPI.language, BRCaccept%>"></asp:Literal></td>
                                <td><asp:Literal ID="Literal16" runat="server" Text="<%$Resources:KPI.language, errorRateOndesign-test%>"></asp:Literal></td>
                                <td><%=Math.Round(objData.AcceptBRCTarget, 4)%></td>
                                <td><%=Math.Round(objData.AcceptBRCTarget * 0.7, 4)%>~<%=Math.Round(objData.AcceptBRCTarget * 1.3, 4)%></td>
                            </tr>
                            <tr>
                                <th scope="row">5</th>
                                <td><asp:Literal ID="Literal11" runat="server" Text="<%$Resources:KPI.language, OSCaccept%>"></asp:Literal></td>
                                <td><asp:Literal ID="Literal17" runat="server" Text="<%$Resources:KPI.language, errorRateOndesign-test%>"></asp:Literal></td>
                                <td><%=Math.Round(objData.AcceptOSCTarget, 4)%></td>
                                <td><%=Math.Round(objData.AcceptOSCTarget * 0.7, 4)%>~<%=Math.Round(objData.AcceptOSCTarget * 1.3, 4)%></td>
                            </tr>
                            <tr>
                                <th scope="row">6</th>
                                <td><asp:Literal ID="Literal12" runat="server" Text="<%$Resources:KPI.language, majorAccept%>"></asp:Literal></td>
                                <td><asp:Literal ID="Literal18" runat="server" Text="<%$Resources:KPI.language, errorRateOndesign-test%>"></asp:Literal></td>
                                <td><%=Math.Round(objData.AcceptProfessionTarget, 4)%></td>
                                <td><%=Math.Round(objData.AcceptProfessionTarget * 0.7, 4)%>~<%=Math.Round(objData.AcceptProfessionTarget * 1.3, 4)%></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
