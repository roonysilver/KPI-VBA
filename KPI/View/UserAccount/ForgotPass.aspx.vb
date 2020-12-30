Imports System.Net
Imports System.Security.Policy
Imports Newtonsoft.Json.Linq
'Imports System.Net.Mail

Public Class ForgotPass
    Inherits Filter.Class.BasePage
    Dim userService As New UserService
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblError.Text = ""
        lblSucces.Text = ""
        Try
            If UserCookieData.GetUserData IsNot Nothing Then
                Response.Redirect("~/")
            End If
        Catch ex As Exception

        End Try
    End Sub
    ''' <summary>
    ''' evwnt when click button send email
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub btnSendEmail_Click(sender As Object, e As EventArgs) Handles btnSendEmail.Click
        Dim secretKey As String = "6LdQm6kZAAAAAF22PPW7ALrTFfs6BIc8BoIRffUe"
        Dim client = New WebClient()
        Dim result = client.DownloadString(String.Format("https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}", secretKey, txtRecaptcha.Text))
        Dim obj = JObject.Parse(result)
        Dim status = CBool(obj.SelectToken("success"))
        If status = False Then
            lblError.Text = Resources.KPI.language.capchaError
        Else
            If userService.CheckEmail(txtEmail.Text) IsNot Nothing Then
                Dim code As String = Guid.NewGuid().ToString()
                'set token and time when send mail
                userService.CreateCode(txtEmail.Text, code, DateTime.Now)
                'get url for email Resetpassword
                Dim domain = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority)
                Dim callbackUrl = Page.GetRouteUrl("ResetPassword", New With {Key .email = txtEmail.Text, Key .code = code})
                callbackUrl = domain + callbackUrl
                'Email.sendMail(callbackUrl, txtEmail.Text)
                SendMail.SendMail(callbackUrl, txtEmail.Text)
                lblSucces.Text = Resources.KPI.language.emaiSendFinish
            Else
                lblError.Text = Resources.KPI.language.emailNotDetail
            End If
        End If

    End Sub
End Class