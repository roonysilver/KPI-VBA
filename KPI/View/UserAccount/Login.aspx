<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="KPI.Login" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>KPI Brycen - Login</title>

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
                            <div class="col-lg-6 d-none d-lg-block bg-login-image">
                            </div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4"><asp:Literal ID="Literal1" runat="server" Text="<%$Resources:KPI.language, login%>"></asp:Literal></h1>
                                    </div>
                                    <form class="user" runat="server">
                                        <div class="form-group">
                                            <%--<input type="email" class="form-control form-control-user" id="txtEmail" aria-describedby="emailHelp" placeholder="Enter Username">--%>
                                            <asp:TextBox ID="txtUser" CssClass="form-control form-control-user" runat="server" placeholder="<%$Resources:KPI.language, usename%>"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtUser" runat="server" ErrorMessage="<%$Resources:KPI.language, noDataID%>" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="form-group">
                                            <%--<input type="password" class="form-control form-control-user" id="txtPassword" placeholder="Password">--%>
                                            <asp:TextBox ID="txtPassword" CssClass="form-control form-control-user" TextMode="Password" runat="server" placeholder="<%$Resources:KPI.language, passWord%>"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtPassword" runat="server" ErrorMessage="<%$Resources:KPI.language, noDatapass%>" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>

                                        <asp:Label ID="lblEr" runat="server" ForeColor="Red" Text=""></asp:Label>
                                        <%--                                        <div class="form-group">
                                            <asp:CheckBox ID="chkPersistCookie" runat="server" />
                                            <label>Remember Me</label>
                                        </div>--%>
                                        <%--<a href="/" class="btn btn-primary btn-user btn-block">
                      Login
                    </a>--%>
                                        <asp:Button ID="btnLogin" CssClass="btn btn-primary btn-user btn-block" runat="server" Text="<%$Resources:KPI.language, login%>" />
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="/ForgotPassword"><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, forGotPassword%>"></asp:Literal></a>
                                    </div>
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

</body>

</html>

