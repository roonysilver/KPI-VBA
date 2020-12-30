Imports System.Net.Configuration

Public Class SendMail
    Public Shared Sub SendMail(ByVal callbackUrl As String, ByVal ReceiverEmail As String)

        ''#################Sending Email##########################

        Const cdoSendUsingPort = 2 ' Send the message using SMTP
        Const cdoBasicAuth = 1 ' Clear-text authentication
        Const cdoTimeout = 60 ' Timeout for SMTP in seconds
        Dim section As SmtpSection = CType(ConfigurationManager.GetSection("system.net/mailSettings/smtp"), SmtpSection)
        Dim mailServer = section.Network.Host
        Dim SMTPport = section.Network.Port
        Dim mailusername = section.From
        Dim mailpassword = section.Network.Password
        Dim objEmail = CreateObject("CDO.Message")
        Dim objConf = objEmail.Configuration
        Dim enableSsl As Boolean = section.Network.EnableSsl
        Dim objFlds = objConf.Fields

        With objFlds
            .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
            .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = mailServer
            '.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = SMTPport
            '.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = enableSsl
            .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = cdoTimeout
            .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = cdoBasicAuth
            .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = mailusername
            .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = mailpassword
            .Update()
        End With

        objEmail.To = ReceiverEmail
        objEmail.From = section.From
        'objEmail.CC = CC
        'objEmail.BCC = BCC
        objEmail.Subject = "Đổi Mật Khẩu"
        objEmail.HTMLBody = getContentEmail(callbackUrl, ReceiverEmail)
        objEmail.BodyPart.Charset = "utf-8"
        objEmail.htmlBodyPart.Charset = "utf-8"
        'objEmail.AddAttachment "C:\report.pdf"
        objEmail.Send()
    End Sub
    Public Shared Function getContentEmail(ByVal callbackUrl As String, ByVal email As String) As String
        Dim userService As New UserService
        Dim name = userService.CheckEmail(email).FirstName & " " + userService.CheckEmail(email).LastName
        Dim strContents As String
        If HttpContext.Current.Session("lang") = "vi" Then
            strContents = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("~/View/MailForm/Forgetpassword.html"))
        Else
            strContents = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("~/View/MailForm/Forgetpassword-ja.html"))
        End If
        strContents = strContents.Replace("{email}", email)
        strContents = strContents.Replace("{Name}", name)
        strContents = strContents.Replace("{rspass}", callbackUrl)
        Return strContents
    End Function
End Class
