<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="DetailQuanlityAnalysis.aspx.vb" Inherits="KPI.DetailQuanlityAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/Site.css" rel="stylesheet" />

    <div class="container">
        <% 
            Dim idTask As Integer
            Try
                idTask = Request.QueryString("idTask")
            Catch ex As Exception
                Response.Redirect("~/Quanlity")
            End Try
            Dim userinfo = KPI.UserCookieData.GetUserData
            ''target detail
            Dim objTargetInfo = SetData()
            ''task detail
            Dim lstAnalysisContent As New List(Of KPI.QualityAnalysis)
            Dim aNalysisService As New KPI.EditContentService
            lstAnalysisContent = aNalysisService.GetListAnalysisContent(userinfo.IdUser, Session("idProject"), idTask, userinfo.RoleName)
            If lstAnalysisContent.Count = 0 Then
                Dim objAnalysis As New KPI.QualityAnalysis
                objAnalysis.Bug = 0
                objAnalysis.Hour = 0
                For item = 1 To 6
                    lstAnalysisContent.Add(objAnalysis)
                Next
            End If
        %>
        <div class="justify-content-center">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary"><asp:Literal ID="Literal31" runat="server" Text="<%$Resources:KPI.language, detailTarget%>"></asp:Literal></h6>
                </div>
                <div class="card-body">
                    <a href="/Quanlity" style="margin-bottom: 5px" class="btn btn-primary"><asp:Literal ID="Literal6" runat="server" Text="<%$Resources:KPI.language, btnBack%>"></asp:Literal></a>
                    <div class="demo-section k-content">
                        <div id="tabstrip">
                            <ul>
                                <li class="k-state-active"><asp:Literal ID="Literal7" runat="server" Text="<%$Resources:KPI.language, designPhase%>"></asp:Literal>
                                </li>
                                <li><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, codePhase%>"></asp:Literal>
                                </li>
                                <li><asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, testPhase%>"></asp:Literal>
                                </li>
                                <li><asp:Literal ID="Literal2" runat="server" Text="<%$Resources:KPI.language, BRCaccept%>"></asp:Literal>
                                </li>
                                <li><asp:Literal ID="Literal4" runat="server" Text="<%$Resources:KPI.language, OSCaccept%>"></asp:Literal>
                                </li>
                                <li><asp:Literal ID="Literal5" runat="server" Text="<%$Resources:KPI.language, majorAccept%>"></asp:Literal>
                                </li>
                            </ul>
                            <div>
                                <div class="grid-container">
                                    <span><asp:Literal ID="Literal8" runat="server" Text="<%$Resources:KPI.language, numJob%>"></asp:Literal> :</span>
                                    <span><%=lstAnalysisContent(5).Hour %> h</span>
                                    <span><asp:Literal ID="Literal9" runat="server" Text="<%$Resources:KPI.language, errorReview%>"></asp:Literal> :</span>
                                    <span><%=lstAnalysisContent(5).Bug %></span>
                                    <span><asp:Literal ID="Literal10" runat="server" Text="<%$Resources:KPI.language, errorRateOnJob%>"></asp:Literal> :</span>
                                    <span><%=If(lstAnalysisContent(5).Hour = 0, "", Math.Round(lstAnalysisContent(5).Bug / lstAnalysisContent(5).Hour, 4)) %></span>
                                    <span><asp:Literal ID="Literal11" runat="server" Text="<%$Resources:KPI.language, yesNoOverStand%>"></asp:Literal> :</span>
                                    <span><%=If(lstAnalysisContent(5).Hour = 0, "", If(objTargetInfo.DesignTarget < lstAnalysisContent(5).Bug / lstAnalysisContent(5).Hour, "★", "")) %></span>
                                </div>
                            </div>
                            <div>
                                <div class="grid-container">
                                    <span><asp:Literal ID="Literal12" runat="server" Text="<%$Resources:KPI.language, numJob%>"></asp:Literal> :</span>
                                    <span><%=lstAnalysisContent(4).Hour %> h</span>
                                    <span><asp:Literal ID="Literal13" runat="server" Text="<%$Resources:KPI.language, errorReview%>"></asp:Literal> :</span>
                                    <span><%=lstAnalysisContent(4).Bug %></span>
                                    <span><asp:Literal ID="Literal14" runat="server" Text="<%$Resources:KPI.language, errorRateOnJob%>"></asp:Literal> :</span>
                                    <span><%=If(lstAnalysisContent(4).Hour = 0, "", Math.Round(lstAnalysisContent(4).Bug / lstAnalysisContent(4).Hour, 4)) %></span>
                                    <span><asp:Literal ID="Literal15" runat="server" Text="<%$Resources:KPI.language, yesNoOverStand%>"></asp:Literal> :</span>
                                    <span><%=If(lstAnalysisContent(4).Hour = 0, "", If(objTargetInfo.CodeTarget < lstAnalysisContent(4).Bug / lstAnalysisContent(4).Hour, "★", "")) %></span>
                                </div>
                            </div>
                            <div>
                                <div class="grid-container">
                                    <span><asp:Literal ID="Literal16" runat="server" Text="<%$Resources:KPI.language, numTest%>"></asp:Literal> :</span>
                                    <div><%=lstAnalysisContent(2).Hour %> h</div>
                                    <span><asp:Literal ID="Literal17" runat="server" Text="<%$Resources:KPI.language, numBug%>"></asp:Literal> :</span>
                                    <span><%=lstAnalysisContent(2).Bug %></span>
                                    <span><asp:Literal ID="Literal18" runat="server" Text="<%$Resources:KPI.language, rateBugHit%>"></asp:Literal> :</span>
                                    <span><%=If(lstAnalysisContent(2).Hour = 0, "", Math.Round(lstAnalysisContent(2).Bug / lstAnalysisContent(2).Hour, 4)) %></span>
                                    <span><asp:Literal ID="Literal19" runat="server" Text="<%$Resources:KPI.language, yesNoOverStand%>"></asp:Literal> :</span>
                                    <span><%=If(lstAnalysisContent(2).Hour = 0, "", If(objTargetInfo.TestTarget < lstAnalysisContent(2).Bug / lstAnalysisContent(2).Hour, "★", "")) %></span>
                                </div>
                            </div>
                            <div>
                                <%Dim sumHour = lstAnalysisContent(2).Hour + lstAnalysisContent(4).Hour + lstAnalysisContent(5).Hour%>
                                <div class="grid-container">
                                    <span><asp:Literal ID="Literal20" runat="server" Text="<%$Resources:KPI.language, numJobDesignText%>"></asp:Literal>:</span>
                                    <span><%=sumHour %> h</span>
                                    <span><asp:Literal ID="Literal21" runat="server" Text="<%$Resources:KPI.language, errorAcceptBRC%>"></asp:Literal> :</span>
                                    <span><%=lstAnalysisContent(0).Bug %></span>
                                    <span><asp:Literal ID="Literal22" runat="server" Text="<%$Resources:KPI.language, rateBugHit%>"></asp:Literal>:</span>
                                    <span><%=If(sumHour = 0, "", Math.Round(lstAnalysisContent(0).Bug / sumHour, 4)) %></span>
                                    <span><asp:Literal ID="Literal23" runat="server" Text="<%$Resources:KPI.language, yesNoOverStand%>"></asp:Literal> :</span>
                                    <span><%=If(sumHour = 0, "", If(objTargetInfo.AcceptBRCTarget < lstAnalysisContent(0).Bug / sumHour, "★", "")) %></span>
                                </div>
                            </div>
                            <div>
                                <div class="grid-container">
                                    <span><asp:Literal ID="Literal24" runat="server" Text="<%$Resources:KPI.language, numJobDesignText%>"></asp:Literal>:</span>
                                    <span><%=sumHour %> h</span>
                                    <span><asp:Literal ID="Literal25" runat="server" Text="<%$Resources:KPI.language, errorAcceptOSC%>"></asp:Literal> :</span>
                                    <span><%=lstAnalysisContent(1).Bug %></span>
                                    <span><asp:Literal ID="Literal26" runat="server" Text="<%$Resources:KPI.language, rateBugHit%>"></asp:Literal> :</span>
                                    <span><%=If(sumHour = 0, "", Math.Round(lstAnalysisContent(1).Bug / sumHour, 4)) %></span>
                                    <span><asp:Literal ID="Literal27" runat="server" Text="<%$Resources:KPI.language, yesNoOverStand%>"></asp:Literal> :</span>
                                    <span><%=If(sumHour = 0, "", If(objTargetInfo.AcceptOSCTarget < lstAnalysisContent(1).Bug / sumHour, "★", "")) %></span>
                                </div>
                            </div>
                            <div>
                                <div class="grid-container">
                                    <span><asp:Literal ID="Literal28" runat="server" Text="<%$Resources:KPI.language, accepMajor%>"></asp:Literal> :</span>
                                    <span><%=lstAnalysisContent(3).Bug %></span>
                                    <span><asp:Literal ID="Literal29" runat="server" Text="<%$Resources:KPI.language, rateBugHit%>"></asp:Literal> :</span>
                                    <span><%=If(sumHour = 0, "", Math.Round(lstAnalysisContent(3).Bug / sumHour, 4)) %></span>
                                    <span><asp:Literal ID="Literal30" runat="server" Text="<%$Resources:KPI.language, yesNoOverStand%>"></asp:Literal> :</span>
                                    <span><%=If(sumHour = 0, "", If(objTargetInfo.AcceptProfessionTarget < lstAnalysisContent(3).Bug / sumHour, "★", "")) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <style>
        .k-link{
            color:#7bbe35 !important;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("#tabstrip").kendoTabStrip({
                animation: {
                    open: {
                        effects: "fadeIn"
                    }
                }
            });
        });
    </script>
</asp:Content>
