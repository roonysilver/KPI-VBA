<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResetPass.aspx.vb" Inherits="KPI.ResetPass" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>KPI Brycen - Reset password</title>

    <!-- Custom fonts for this template-->
    <link href="/Themes/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/Themes/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-primary">
    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4"><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, setPassword%>"></asp:Literal></h1>
                                    </div>
                                    <asp:Label ID="lblSucces" runat="server" Text="" ForeColor="#7bbe35"></asp:Label>
                                    <form class="user" runat="server">
                                        <div class="form-group">
                                            <%--<input type="hidden" value="" id="recaptcha" name="recaptcha" />--%>
                                            <asp:TextBox ID="txtPassword" CssClass="form-control newpass form-control-user" MaxLength="8" TextMode="Password" runat="server" placeholder="<%$Resources:KPI.language, passWord%>">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtPassword" runat="server" ErrorMessage="<%$Resources:KPI.language, noData%>" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox ID="txtRetypePassword" CssClass="form-control retype-newpass form-control-user" MaxLength="8" TextMode="Password" runat="server" placeholder="<%$Resources:KPI.language, retypePassword%>">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtRetypePassword" runat="server" ErrorMessage="<%$Resources:KPI.language, noData%>" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                        <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
                                        <asp:Button ID="btnResetPassword" CssClass="btn btn-primary btn-user btn-block btn-resetpass submitform" runat="server" Text="<%$Resources:KPI.language, send%>" />
                                    </form>
                                    <hr>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
    <%--    <script>
        $(function () {
            $(".checkbox").attr("id","customCheck")
        })
    </script>--%>
    <!-- Bootstrap core JavaScript-->
    <script src="/Themes/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/Themes/vendor/jquery/jquery.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="/Themes/vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="/Themes/js/sb-admin-2.min.js"></script>
<script>
    //$(".btn-resetpass").click(function (e) {
    //    if ($(".newpass").val().replace(/\s+/g, ' ').trim() == "") {
    //        $.trim($(".newpass").val(''));
    //    }
    //    if ($(".retype-newpass").val().replace(/\s+/g, ' ').trim() == "") {
    //        $.trim($(".retype-newpass").val(''));
    //    }
    //})
</script>
</body>

</html>
