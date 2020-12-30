Public Class WebForm2
    Inherits Filter.Class.BasePage
    Dim projectService As New ProjectService()
    Dim user As KPI.UserInfo = UserCookieData.GetUserData()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            Session("Search") = ""
            DataBD()
        End If
    End Sub
    '' get data and binding data
    Protected Sub DataBD()
        Dim pageSize = 10
        Dim lstProjectInfo As List(Of ProjectInfo)
        grvProject.VirtualItemCount = projectService.GetCountProject(user.IdUser, user.RoleName, Session("Search"))
        lstProjectInfo = projectService.GetListProject(user.IdUser, user.RoleName, pageSize, grvProject.PageIndex + 1, Session("Search"))
        For Each item In lstProjectInfo
            For Each i In projectService.GetMemberProject(item.IdProject)
                If item.NameMember = Nothing Then
                    item.NameMember = i.NameMember
                Else
                    item.NameMember = item.NameMember + "," + i.NameMember
                End If
            Next
        Next
        grvProject.DataSource = lstProjectInfo
        grvProject.DataBind()
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
        Dim idProject As Integer
        Dim i As Integer = 0
        For Each row As GridViewRow In grvProject.Rows
            Dim chkdelete As CheckBox = TryCast(row.Cells(0).FindControl("clbSelect"), CheckBox)
            If chkdelete IsNot Nothing And chkdelete.Checked Then
                idProject = CType(grvProject.Rows(i).FindControl("lblID"), Label).Text
                Dim is_delete = projectService.DeleteProject(idProject)
            End If
            i += 1
        Next
        DataBD()
    End Sub
    Protected Sub OnClickHandler(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnk As LinkButton = CType(sender, LinkButton)
        projectService.DeleteProject(lnk.CommandArgument)
        DataBD()
    End Sub
    Protected Sub DetailClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim detail As Button = CType(sender, Button)
        Session("idProject") = detail.CommandArgument
        Response.Cookies("idProject").Value = detail.CommandArgument
        Response.Cookies("idProject").Expires = DateTime.Now.AddDays(1)
        Response.Redirect("~/")
    End Sub
    Protected Sub EditClick(ByVal sender As Object, ByVal e As EventArgs)
        Dim Edit As Button = CType(sender, Button)
        Session("idProject") = Edit.CommandArgument
        Response.Cookies("idProject").Value = Edit.CommandArgument
        Response.Cookies("idProject").Expires = DateTime.Now.AddDays(1)
        Response.Redirect("~/Project/Edit")
    End Sub
    Protected Sub lkbSearch_Click(sender As Object, e As EventArgs) Handles lkbSearch.Click
        Session("Search") = txtSearch.Text
        DataBD()
        'If grvProject.Rows.Count <= 0 Then
        '    lblError.Text = "Không tìm thấy"
        '    lblError.CssClass = "btn btn-success"
        'Else
        '    lblError.Text = ""
        '    lblError.CssClass = ""
        'End If
    End Sub

    Protected Sub btnAdd_Click(sender As Object, e As EventArgs) Handles btnAdd.Click
        Session("idProject") = 0
        Response.Cookies("idProject").Value = 0
        Response.Cookies("idProject").Expires = DateTime.Now.AddDays(1)
        Response.Redirect("~/Project/Add")
    End Sub

    Protected Sub RowIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles grvProject.PageIndexChanging
        grvProject.PageIndex = e.NewPageIndex
        DataBD()
    End Sub
End Class