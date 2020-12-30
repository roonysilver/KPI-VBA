Imports System.Net.Configuration
Imports System.Net.Mail
'Imports System.Net.Mime

Public Class Email
    Public Shared Sub sendMail(ByVal callbackUrl As String, ByVal email As String)
        Dim section As SmtpSection = CType(ConfigurationManager.GetSection("system.net/mailSettings/smtp"), SmtpSection)
        Dim from As String = section.From
        Dim host As String = section.Network.Host
        Dim port As Integer = section.Network.Port
        Dim enableSsl As Boolean = section.Network.EnableSsl
        Dim users As String = section.Network.UserName
        Dim password As String = section.Network.Password
        Dim msg As MailMessage = New MailMessage()
        msg.From = New MailAddress(from, "Brycen VN")
        msg.[To].Add(New MailAddress(email))
        msg.Subject = " Reset Password"
        msg.AlternateViews.Add(AlternateView.CreateAlternateViewFromString(getContentEmail(callbackUrl, email), Nothing, Net.Mime.MediaTypeNames.Text.Html))
        Dim smtpClient As SmtpClient = New SmtpClient(host, port)
        Dim credentials As System.Net.NetworkCredential = New System.Net.NetworkCredential(from, password)
        smtpClient.Credentials = credentials
        smtpClient.EnableSsl = enableSsl
        smtpClient.Send(msg)
    End Sub

    Public Shared Function getContentEmail(ByVal callbackUrl As String, ByVal email As String) As String
        Dim userService As New UserService
        Dim name = userService.CheckEmail(email).FirstName & " " + userService.CheckEmail(email).LastName
        Dim strContents As String = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("~/View/MailForm/Forgetpassword.html"))
        strContents = strContents.Replace("{email}", email)
        strContents = strContents.Replace("{Name}", name)
        strContents = strContents.Replace("{rspass}", callbackUrl)
        Return strContents
    End Function
End Class
