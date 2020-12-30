Public Class ResetPass
    Inherits Filter.Class.BasePage

    Dim userService As New UserService
    Dim userInfo As KPI_M_User
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblError.Text = ""
        Try
            If UserCookieData.GetUserData IsNot Nothing Then
                Response.Redirect("~/")
            End If
        Catch ex As Exception

        End Try
        Dim email = Request.QueryString("email")
        Dim code = Request.QueryString("code")
        If email Is Nothing Or code Is Nothing Then
            Response.Redirect("~/PageNotFound")
        End If
        userInfo = userService.CheckForgetPassword(email, code)
        If userInfo Is Nothing Then
            Response.Redirect("~/PageNotFound")
        Else
            'check time now with time in forget password
            Dim timeDiff = DateTime.Now - userInfo.TimeForget
            Dim timeWait As TimeSpan = TimeSpan.FromMinutes(5)
            If timeDiff > timeWait Then
                Dim codeCreate As String = Guid.NewGuid().ToString()
                userService.CreateCode(email, codeCreate, userInfo.TimeForget)
                Response.Redirect("~/PageNotFound")
                'Else
                'Dim codeCreate As String = Guid.NewGuid().ToString()
                'userService.CreateCode(email, codeCreate, userInfo.TimeForget)
            End If
        End If
    End Sub
    ''' <summary>
    ''' event when click resetpassword
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub btnResetPassword_Click(sender As Object, e As EventArgs) Handles btnResetPassword.Click
        Dim timeDiff = DateTime.Now - userInfo.TimeForget
        Dim timeWait As TimeSpan = TimeSpan.FromMinutes(5)
        If timeDiff <= timeWait Then
            If (txtPassword.Text.Length <= 8 And txtPassword.Text.Length > 0) Or (txtRetypePassword.Text.Length <= 8 And txtRetypePassword.Text.Length > 0) Then
                If txtPassword.Text = txtRetypePassword.Text Then
                    If userService.UpdatePassword(userInfo.Username, txtPassword.Text) Then
                        userService.UpdateLockUser(0, userInfo.Username)
                        Dim codeCreate As String = Guid.NewGuid().ToString()
                        userService.CreateCode(userInfo.email, codeCreate, userInfo.TimeForget)
                        Response.Redirect("~/Login")
                    End If
                Else
                    lblError.Text = Resources.KPI.language.passDiffrent
                End If
            End If
        Else
            Response.Redirect("~/PageNotFound")
        End If
    End Sub

End Class