<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="Profile.aspx.vb" Inherits="KPI.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <% Dim user As KPI.UserInfo = KPI.UserCookieData.GetUserData()%>
    <div class="container">
        <div class="">
                <div class="card shadow mb-4">
                    <div class="card-header py-3 with-border">
                        <h5 class="m-0 font-weight-bold text-primary"><asp:Literal ID="Literal8" runat="server" Text="<%$Resources:KPI.language, infouser%>"></asp:Literal></h5>
                       <%-- <h3>Thông tin cá nhân</h3>--%>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered colorFont table-striped">
                            <thead>
                                <tr>
                                   <th><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, conternt%>"></asp:Literal></th>
                                  <th><asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, detailContent%>"></asp:Literal></th>
                                </tr>
                            </thead>
                            <tbody>
                           <tr>
                            <td><asp:Literal ID="Literal2" runat="server" Text="<%$Resources:KPI.language, usename%>"></asp:Literal></td>
                            <td> <%=user.FirstName + " " + user.LastName %></td>
                            </tr>
                            <tr>
                                <td><asp:Literal ID="Literal4" runat="server" Text="<%$Resources:KPI.language, birthDate%>"></asp:Literal></td>
                                <td> <%=user.Dob.Split(" ")(0)%></td>
                            </tr>
                            <tr>
                                <td><asp:Literal ID="Literal5" runat="server" Text="<%$Resources:KPI.language, address%>"></asp:Literal></td>
                                <td> <%=user.Address %></td>
                            </tr>
                            <tr>
                                <td><asp:Literal ID="Literal6" runat="server" Text="<%$Resources:KPI.language, email%>"></asp:Literal></td>
                                <td> <%=user.email %></td>
                            </tr>
                            <tr>
                                <td><asp:Literal ID="Literal7" runat="server" Text="<%$Resources:KPI.language, numberPhane%>"></asp:Literal></td>
                                <td><%=user.Phone %></td>
                            </tr>
                           </tbody>
                        </table>
                    </div>
            </div>
        </div>
    </div>
</asp:Content>
