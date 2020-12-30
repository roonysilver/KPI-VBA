Imports System.Web.Optimization
Imports System.Security.Principal
Public Class Global_asax
    Inherits HttpApplication

    Sub Application_Start(sender As Object, e As EventArgs)
        ' Fires when the application is started
        RouteConfig.RegisterRoutes(RouteTable.Routes)
        BundleConfig.RegisterBundles(BundleTable.Bundles)
        RegisterRoutes(RouteTable.Routes)
        ' 
    End Sub
    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        If HttpContext.Current.User IsNot Nothing Then
            ''check authorization 
            If HttpContext.Current.User.Identity.IsAuthenticated Then
                If TypeOf HttpContext.Current.User.Identity Is FormsIdentity Then
                    Dim id As FormsIdentity = DirectCast(HttpContext.Current.User.Identity, FormsIdentity)
                    Dim ticket As FormsAuthenticationTicket = id.Ticket
                    Dim userData As String = ticket.UserData
                    userData = UserCookieData.CookieStringToUser(userData).RoleName
                    Dim roles As String() = userData.Split(","c)
                    HttpContext.Current.User = New GenericPrincipal(id, roles)
                End If
            End If
        End If
    End Sub
    Private Shared Sub RegisterRoutes(routes As RouteCollection)
        'routes.MapPageRoute("", "", "~/View/")
        ''User url customer
        routes.MapPageRoute("404", "PageNotFound", "~/View/Error/404.aspx")
        routes.MapPageRoute("500", "ServerError", "~/View/Error/500.aspx")
        routes.MapPageRoute("Login", "Login", "~/View/UserAccount/Login.aspx")
        routes.MapPageRoute("ResetPassword", "ResetPassword", "~/View/UserAccount/ResetPass.aspx")
        routes.MapPageRoute("ForgotPassword", "ForgotPassword", "~/View/UserAccount/ForgotPass.aspx")
        routes.MapPageRoute("Profile", "Profile", "~/View/UserAccount/Profile.aspx")
        routes.MapPageRoute("ChangePassword", "ChangePassword", "~/View/UserAccount/ChangePass.aspx")
        ''target url customer
        routes.MapPageRoute("", "", "~/View/Target/Target.aspx")
        routes.MapPageRoute("Target", "Target", "~/View/Target/Target.aspx")
        ''Quanlity url customer
        routes.MapPageRoute("Quanlity", "Quanlity", "~/View/QualityAnalysis/QuanlityAnalysis.aspx")
        routes.MapPageRoute("QuanlityDetail", "Quanlity/Detail", "~/View/QualityAnalysis/DetailQuanlityAnalysis.aspx")
        routes.MapPageRoute("QuanlityEdit", "Quanlity/Edit", "~/View/QualityAnalysis/EditQuanlityAnalysis.aspx")
        ''Task url customer
        routes.MapPageRoute("Task", "Task", "~/View/Task/TaskList.aspx")
        routes.MapPageRoute("AddTask", "Task/Add", "~/View/Task/ModifyTaskList.aspx")
        routes.MapPageRoute("EditTask", "Task/Edit", "~/View/Task/ModifyTaskList.aspx")
        ''ErrorAnalysis url customer
        routes.MapPageRoute("ErrorAnalysis", "ErrorAnalysis", "~/View/ErrorAnalysis/ErrorAnalysisList.aspx")
        routes.MapPageRoute("ErrorAnalysisAdd", "ErrorAnalysis/Add", "~/View/ErrorAnalysis/ModifyErrorAnalysis.aspx")
        routes.MapPageRoute("ErrorAnalysisEdit", "ErrorAnalysis/Edit", "~/View/ErrorAnalysis/ModifyErrorAnalysis.aspx")
        routes.MapPageRoute("AddErrorAnalysis", "ErrorAnalysis/Create", "~/View/ErrorAnalysis/Add.aspx")
        ''project url customer
        routes.MapPageRoute("Project", "Project", "~/View/Project/Project.aspx")
        routes.MapPageRoute("ProjectEdit", "Project/Edit", "~/View/Project/Input.aspx")
        routes.MapPageRoute("ProjectAdd", "Project/Add", "~/View/Project/Input.aspx")
    End Sub
End Class