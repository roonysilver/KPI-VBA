Public Class ChangePass
    Inherits Filter.Class.BasePage
    Dim userService As New UserService
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblErrorPassword.Text = ""
        lblErrorNewPassword.Text = ""
    End Sub
    ''' <summary>
    ''' event when click button change password
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub btnChangePassword_Click(sender As Object, e As EventArgs) Handles btnChangePassword.Click
        If (txtNewPassword.Text.Length <= 8 And txtNewPassword.Text.Length > 0) Or (txtTypeNewPassword.Text.Length <= 8 And txtTypeNewPassword.Text.Length > 0) Then
            Dim user As New KPI_M_User
            user.PassWord = txtPassword.Text
            user.Username = HttpContext.Current.User.Identity.Name
            Dim userinfo = userService.GetUser(user)
            If userinfo.Username IsNot Nothing Then
                If txtNewPassword.Text = txtTypeNewPassword.Text Then
                    If userService.UpdatePassword(userinfo.Username, txtNewPassword.Text) Then
                        Session("notification") = "true"
                        Response.Redirect("/")
                    Else
                        Session("notification") = "false"
                    End If
                Else
                    lblErrorNewPassword.Text = Resources.KPI.language.passDiffrent
                End If
            Else
                lblErrorPassword.Text = Resources.KPI.language.passANotdetail
            End If
        End If
    End Sub
End Class