Public Class Login
    Inherits Filter.Class.BasePage
    Dim userService As New UserService
    Dim projectService As New ProjectService
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblEr.Text = ""
        Try
            If UserCookieData.GetUserData IsNot Nothing Then
                Response.Redirect("~/")
            End If
        Catch ex As Exception

        End Try
    End Sub
    ''' <summary>
    ''' event click login
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        Dim userLogin As New KPI_M_User
        userLogin.Username = txtUser.Text
        userLogin.PassWord = txtPassword.Text
        Dim user As UserInfo = userService.GetUser(userLogin)
        Dim countLoginFail As Integer = userService.GetLockUser(userLogin.Username)
        ''check idproject exist in database 
        Try
            If user.RoleName = "Leader" Or user.RoleName = "User" Then
                Dim idproject = projectService.GetProjectForRole(user.IdUser, user.RoleName).IdProject
                If user.Username IsNot Nothing And user.LoginFail <= 2 Then
                    'reset number count login fail =0
                    userService.UpdateLockUser(0, user.Username)
                    'create ticket
                    Dim tkt As New FormsAuthenticationTicket(1, user.Username, DateTime.Now, DateTime.Now.AddDays(15), False, UserCookieData.UserToCookieString(user))
                    'create cookie store ticket
                    Dim cookiestr As String
                    Dim ck As HttpCookie
                    cookiestr = FormsAuthentication.Encrypt(tkt)
                    ck = New HttpCookie(FormsAuthentication.FormsCookieName, cookiestr)
                    'If chkPersistCookie.Checked Then
                    '    ck.Expires = tkt.Expiration
                    'End If
                    ck.Path = FormsAuthentication.FormsCookiePath
                    Response.Cookies.Add(ck)
                    ''set cookie for iduser
                    Try
                        Session("idProject") = projectService.GetProjectForRole(user.IdUser, user.RoleName).IdProject
                        Response.Cookies("idProject").Value = projectService.GetProjectForRole(user.IdUser, user.RoleName).IdProject
                        Response.Cookies("idProject").Expires = DateTime.Now.AddDays(1)
                    Catch ex As Exception
                        Session("idProject") = 0
                        Response.Cookies("idProject").Value = 0
                        Response.Cookies("idProject").Expires = DateTime.Now.AddDays(1)
                    End Try
                    Dim redirectPage = Request("ReturnUrl")
                    If redirectPage Is Nothing Then
                        redirectPage = "~/Project"
                    End If
                    Response.Redirect(redirectPage)
                    'if login fail > 3 show error and lock
                ElseIf countLoginFail >= 3 Then
                    lblEr.Text = Resources.KPI.language.errorLoginFailOver
                ElseIf user.Username Is Nothing And countLoginFail < 3 Then
                    'if login password not correct set loginfail+1 and show error
                    lblEr.Text = Resources.KPI.language.errorLoginFail
                    countLoginFail = countLoginFail + 1
                    userService.UpdateLockUser(countLoginFail, userLogin.Username)
                End If
            Else
                If user.Username IsNot Nothing And user.LoginFail <= 2 Then
                    userService.UpdateLockUser(0, user.Username)
                    Dim tkt As New FormsAuthenticationTicket(1, user.Username, DateTime.Now, DateTime.Now.AddDays(15), False, UserCookieData.UserToCookieString(user))
                    Dim cookiestr As String
                    Dim ck As HttpCookie
                    cookiestr = FormsAuthentication.Encrypt(tkt)
                    ck = New HttpCookie(FormsAuthentication.FormsCookieName, cookiestr)
                    'If chkPersistCookie.Checked Then
                    '    ck.Expires = tkt.Expiration
                    'End If
                    ck.Path = FormsAuthentication.FormsCookiePath
                    Response.Cookies.Add(ck)
                    ''set cookie for idproject
                    Try
                        Session("idProject") = projectService.GetProjectForRole(user.IdUser, user.RoleName).IdProject
                    Catch ex As Exception
                        Session("idProject") = 0
                    End Try
                    Dim redirectPage = Request("ReturnUrl")
                    If redirectPage Is Nothing Then
                        redirectPage = "~/Project"
                    End If
                    Response.Redirect(redirectPage)
                ElseIf countLoginFail >= 3 Then
                    lblEr.Text = Resources.KPI.language.errorLoginFailOver
                ElseIf user.Username Is Nothing And countLoginFail < 3 Then
                    lblEr.Text = Resources.KPI.language.errorLoginFail
                    countLoginFail = countLoginFail + 1
                    userService.UpdateLockUser(countLoginFail, userLogin.Username)
                End If
            End If
        Catch ex As Exception
            lblEr.Text = Resources.KPI.language.noProject
        End Try

    End Sub
End Class