<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Theme.Master" CodeBehind="WebForm3.aspx.vb" Inherits="KPI.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:GridView runat="server" ID="grvtest" AllowCustomPaging="true"
                    AllowPaging="true"
                    OnPageIndexChanged="RowIndexChanging"
                    PageSize="1"
                    PagerSettings-Mode="NumericFirstLast"
                    PagerSettings-FirstPageText="<<"
                    PagerSettings-LastPageText=">>" >

    </asp:GridView>
            <select id="optional" multiple="multiple" data-placeholder="Select attendees...">
                <option>Steven White</option>
                <option>Nancy King</option>
                <option>Nancy Davolio</option>
                <option>Robert Davolio</option>
                <option>Michael Leverling</option>
                <option>Andrew Callahan</option>
                <option>Michael Suyama</option>
                <option>Anne King</option>
                <option>Laura Peacock</option>
                <option>Robert Fuller</option>
                <option>Janet White</option>
                <option>Nancy Leverling</option>
                <option>Robert Buchanan</option>
                <option>Margaret Buchanan</option>
                <option>Andrew Fuller</option>
                <option>Anne Davolio</option>
                <option>Andrew Suyama</option>
                <option>Nige Buchanan</option>
                <option>Laura Fuller</option>
            </select>
            <button class="k-button" id="get">Send Invitation</button>
        <style>
            .demo-section label {
                display: block;
                margin: 15px 0 5px 0;
            }

            #get {
                float: right;
                margin: 25px auto 0;
            }
        </style>
        <script>
            $(document).ready(function () {
                // create MultiSelect from select HTML element
                var optional = $("#optional").kendoMultiSelect({
                    autoClose: false
                }).data("kendoMultiSelect");
                $("#get").click(function () {
                    alert("\nOptional: " + optional.value());
                });
            });
        </script>
</asp:Content>
