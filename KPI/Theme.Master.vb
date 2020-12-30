Imports System.IO
Imports System.Net

Public Class Theme
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("lang") = "vi" Then
            SiteMapDataSource1.SiteMapProvider = "SiteMapvi"
            SiteMapPath1.SiteMapProvider = "SiteMapvi"
        Else
            SiteMapDataSource1.SiteMapProvider = "SiteMapja"
            SiteMapPath1.SiteMapProvider = "SiteMapja"
        End If
        Try
            If Request.Cookies("idProject").Value <> "" Then

            End If
            If Session("idProject") = Nothing Then
                Session("idProject") = Request.Cookies("idProject").Value
            End If
        Catch ex As Exception
            Response.Cookies("idProject").Value = Session("idProject")
        End Try
        If Session("notification") = "true" Then
            Dim toastr As String = "iziToast.success({
                    title: 'Succeeded',
                    message: '" + Resources.KPI.language.ChangeDataSucces + "',
                })"
            Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
            Session("notification") = "no"
        End If
        If Session("notification") = "false" Then
            Dim toastr As String = "iziToast.success({
                    title: 'Error',
                    message: '" + Resources.KPI.language.ChangeDataFail + "',
                })"
            Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
            Session("notification") = "no"
        End If
    End Sub
    Protected Sub lkbLogout_Click(sender As Object, e As EventArgs) Handles lkbLogout.Click
        FormsAuthentication.SignOut()
        Session("idProject") = 0
        Request.Cookies("idProject").Expires = DateTime.Now.AddDays(-1)
        Response.Redirect("~/Login")
    End Sub
    Protected Sub lkbBack_Click(sender As Object, e As EventArgs) Handles lkbBack.Click
        Session("idProject") = 0
        Response.Redirect("~/Project")
    End Sub
    Protected Sub ImgbtnFlagVn_Click(sender As Object, e As ImageClickEventArgs) Handles ImgbtnFlagVn.Click
        Session("lang") = "vi"
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub ImgbtnFlagJapan_Click(sender As Object, e As ImageClickEventArgs) Handles ImgbtnFlagJapan.Click
        Session("lang") = "ja"
        Response.Redirect(Request.RawUrl)
    End Sub
End Class