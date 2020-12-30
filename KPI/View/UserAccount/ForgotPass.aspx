<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ForgotPass.aspx.vb" Inherits="KPI.ForgotPass" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>KPI Brycen - Forgor Password</title>

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
                                        <h1 class="h4 text-gray-900 mb-4"><asp:Literal ID="Literal3" runat="server" Text="<%$Resources:KPI.language, forGotPassword%>"></asp:Literal></h1>
                                    </div>
                                    <asp:Label ID="lblSucces" runat="server" Text="" ForeColor="#7bbe35"></asp:Label>
                                    <form class="user" runat="server">
                                        <div class="form-group">
                                            <asp:TextBox ID="txtRecaptcha" CssClass="recaptcha" runat="server"></asp:TextBox>
                                            <%--<input type="hidden" value="" id="recaptcha" name="recaptcha" />--%>
                                            <asp:TextBox ID="txtEmail" CssClass="form-control form-control-user" runat="server" placeholder="<%$Resources:KPI.language, email%>">
                                            </asp:TextBox>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtEmail" runat="server" ErrorMessage="<%$Resources:KPI.language, noData%>" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="g-recaptcha" data-sitekey="6LdQm6kZAAAAAGT7LO3W7EMnfi6guGKvJOblx9Mv" style="margin-bottom: 10px; margin-left: 18px"></div>
                                        <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
                                        <asp:Button ID="btnSendEmail" CssClass="btn btn-primary btn-user btn-block submitform" runat="server" Text="<%$Resources:KPI.language, send%>" />
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
    <script src="/Themes/vendor/jquery/jquery.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="/Themes/vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Bootstrap core JavaScript-->
    <script src="/Themes/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <style>
        .recaptcha {
            display: none
        }
        @media only screen and (max-width: 500px) {
            .g-recaptcha{
                margin-left:-15px !important
            }
        }
    </style>
    <!-- Custom scripts for all pages-->
    <script src="/Themes/js/sb-admin-2.min.js"></script>
    <script>
        //send response with code after check captcha
        $(".submitform").click(function (event) {
            $(".recaptcha").val(window.grecaptcha.getResponse());
            console.log(window.grecaptcha.getResponse());
        });
    </script>
    <script src='https://www.google.com/recaptcha/api.js' type="text/javascript"></script>
</body>

</html>
