Imports System.Globalization
Imports System.Threading

Namespace Filter.[Class]
    Public Class BasePage
        Inherits System.Web.UI.Page
        ''' <summary>
        ''' check session langguage and translate   
        ''' </summary>
        Protected Overrides Sub InitializeCulture()
            'If Not String.IsNullOrEmpty(Request("lang")) Then
            '    Session("lang") = Request("lang")
            'End If

            Dim lang As String = Convert.ToString(Session("lang"))
            Dim culture As String = String.Empty
            If lang.ToLower().CompareTo("vi") = 0 Then
                culture = "vi-VN"
            End If
            If lang.ToLower().CompareTo("ja") = 0 Then
                culture = "ja-JP"
            End If
            If lang.ToLower().CompareTo("ja") <> 0 And lang.ToLower().CompareTo("vi") <> 0 Then
                culture = "vi-VN"
                Session("lang") = "vi"
            End If
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture)
            Thread.CurrentThread.CurrentUICulture = New CultureInfo(culture)
            MyBase.InitializeCulture()
        End Sub
    End Class
End Namespace

