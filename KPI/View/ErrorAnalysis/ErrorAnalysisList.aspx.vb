Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.Services
Imports System.Web.Script.Services
Imports OfficeOpenXml
Imports System.Drawing
Imports OfficeOpenXml.Style


Public Class ErrorAnalysisList
    Inherits Filter.Class.BasePage
    Private Shared prevPage As String = String.Empty
    Dim useInfo As UserInfo = UserCookieData.GetUserData
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idProject") = 0 Then
            Response.Redirect("~/Project")
        End If
        If IsPostBack = False Then
            ''save and compare guid send from client and assign values after compare
            Session("CheckGuid") = ""
            '' save column will sort, default Deadline
            Session("SortColumn") = "rownum"
            ''save sort ASC(increase) or DESC(deincrease) for column order
            Session("SortOrder") = "ASC"
            '' save search text in textbox search
            Session("Search") = ""
            '' save icon sort will show on client
            Session("SortIconNumorder") = "button_change_GUID fas fa-sort-down"
            Session("SortIconContent") = "button_change_GUID fas fa-sort"
            Session("SortIconBug") = "button_change_GUID fas fa-sort"
            Session("SortIconPhase") = "button_change_GUID fas fa-sort"
            Session("SortIconReference") = "button_change_GUID fas fa-sort"
            Databd()
        End If
    End Sub

    Protected Sub Databd()
        Try
            grvErrorAnalysis.PageSize = 10
            Dim ErrorAnalysisService As New ErrorAnalysisService()
            grvErrorAnalysis.VirtualItemCount = ErrorAnalysisService.GetCount(Request.QueryString("id"), Session("Search"), useInfo.IdUser)
            Dim dataTable As New DataTable()
            grvErrorAnalysis.DataSource = ErrorAnalysisService.GetContentErrorTypeList(Request.QueryString("id"), grvErrorAnalysis.PageIndex + 1, grvErrorAnalysis.PageSize, Session("Search"), Session("SortColumn"), Session("SortOrder"), useInfo.IdUser)
            grvErrorAnalysis.DataBind()
            If (grvErrorAnalysis.Rows.Count = 0) Then
                'grvErrorAnalysis.DataSource = Me.Get_EmptyDataTable()
                grvErrorAnalysis.DataBind()
                'grvErrorAnalysis.Rows(0).Visible = False
            End If
            ''Authentication between Manager and Admin can't see checkbox and Action Columns
            If useInfo.RoleName = "Manager" Or useInfo.RoleName = "Admin" Then
                grvErrorAnalysis.Columns(0).Visible = False
                grvErrorAnalysis.Columns(7).Visible = False
            End If
        Catch ex As Exception
            Response.Redirect("~/Task")
        End Try

    End Sub

    'Public Function Get_EmptyDataTable() As DataTable
    '    Dim dtEmpty As DataTable = New DataTable()
    '    dtEmpty.Columns.Add("IdErrorAnalysis", GetType(String))
    '    dtEmpty.Columns.Add("rownum", GetType(String))
    '    dtEmpty.Columns.Add("Bug", GetType(String))
    '    dtEmpty.Columns.Add("Reference", GetType(Date))
    '    dtEmpty.Columns.Add("NameError", GetType(String))
    '    dtEmpty.Columns.Add("NamePhase", GetType(String))
    '    Dim datatRow As DataRow = dtEmpty.NewRow()
    '    dtEmpty.Rows.Add(datatRow)
    '    Return dtEmpty
    'End Function

    Protected Sub grvErrorAnalysis_IndexChange(sender As Object, e As GridViewPageEventArgs) Handles grvErrorAnalysis.PageIndexChanging
        grvErrorAnalysis.PageIndex = e.NewPageIndex
        Databd()
    End Sub
    ''Return button to task List
    Protected Sub btnReturn_Click(sender As Object, e As EventArgs) Handles btnReturn.Click
        Response.Redirect("~/Task")
    End Sub

    Protected Sub grvErrorAnalysis_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grvErrorAnalysis.RowCommand
        If e.CommandName.Equals("Edit") Then
            Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Dim lblIdEditErrorAnalysis As Label = grvErrorAnalysis.Rows(rowIndex).FindControl("lblStt")
            Response.Redirect("~/ErrorAnalysis/Edit?id=" + lblIdEditErrorAnalysis.Text + "&idTask=" + Request.QueryString("id"))
        End If
        If e.CommandName.Equals("Delete") Then
            Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Dim lblIdDeleteErrorAnalysis As Label = grvErrorAnalysis.Rows(rowIndex).FindControl("lblStt")
            Dim errorAnalysisService As New ErrorAnalysisService
            errorAnalysisService.DeleteContentErrorType(lblIdDeleteErrorAnalysis.Text)
            Response.Redirect("~/ErrorAnalysis?id=" + Request.QueryString("Id"))
        End If
        If e.CommandName.Equals("SORTORDERROWNUM") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconBug") = "button_change_GUID fas fa-sort"
                Session("SortIconPhase") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "rownum"
                If Session("SortIconNumorder") = "button_change_GUID fas fa-sort" Then
                    Session("SortIconNumorder") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                ElseIf Session("SortIconNumorder") = "button_change_GUID fas fa-sort-up" Then
                    Session("SortIconNumorder") = "button_change_GUID fas fa-sort-down"
                    Session("SortOrder") = "ASC"
                ElseIf Session("SortIconNumorder") = "button_change_GUID fas fa-sort-down" Then
                    Session("SortIconNumorder") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                End If
                Databd()
            Else
                Databd()
            End If
        End If
        If e.CommandName.Equals("SORTCONTENT") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconBug") = "button_change_GUID fas fa-sort"
                Session("SortIconPhase") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "NameError"
                If Session("SortIconContent") = "button_change_GUID fas fa-sort" Then
                    Session("SortIconContent") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                ElseIf Session("SortIconContent") = "button_change_GUID fas fa-sort-up" Then
                    Session("SortIconContent") = "button_change_GUID fas fa-sort-down"
                    Session("SortOrder") = "ASC"
                ElseIf Session("SortIconContent") = "button_change_GUID fas fa-sort-down" Then
                    Session("SortIconContent") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                End If
                Databd()
            Else
                Databd()
            End If
        End If
        If e.CommandName.Equals("SORTBUG") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconPhase") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "Bug"
                If Session("SortIconBug") = "button_change_GUID fas fa-sort" Then
                    Session("SortIconBug") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "ASC"
                ElseIf Session("SortIconBug") = "button_change_GUID fas fa-sort-up" Then
                    Session("SortIconBug") = "button_change_GUID fas fa-sort-down"
                    Session("SortOrder") = "DESC"
                ElseIf Session("SortIconBug") = "button_change_GUID fas fa-sort-down" Then
                    Session("SortIconBug") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "ASC"
                End If
                Databd()
            Else
                Databd()
            End If
        End If

        If e.CommandName.Equals("SORTPHASE") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconBug") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "Phase"
                If Session("SortIconPhase") = "button_change_GUID fas fa-sort" Then
                    Session("SortIconPhase") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                ElseIf Session("SortIconPhase") = "button_change_GUID fas fa-sort-up" Then
                    Session("SortIconPhase") = "button_change_GUID fas fa-sort-down"
                    Session("SortOrder") = "ASC"
                ElseIf Session("SortIconPhase") = "button_change_GUID fas fa-sort-down" Then
                    Session("SortIconPhase") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                End If
                Databd()
            Else
                Databd()
            End If
        End If

        If e.CommandName.Equals("SORTREFERENCE") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconBug") = "button_change_GUID fas fa-sort"
                Session("SortIconPhase") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "Reference"
                If Session("SortIconReference") = "button_change_GUID fas fa-sort" Then
                    Session("SortIconReference") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                ElseIf Session("SortIconReference") = "button_change_GUID fas fa-sort-up" Then
                    Session("SortIconReference") = "button_change_GUID fas fa-sort-down"
                    Session("SortOrder") = "ASC"
                ElseIf Session("SortIconReference") = "button_change_GUID fas fa-sort-down" Then
                    Session("SortIconReference") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                End If
                Databd()
            Else
                Databd()
            End If
        End If
    End Sub

    Protected Sub btnDeleteMulti_Click(sender As Object, e As EventArgs) Handles btnDeleteMulti.Click
        For Each row As GridViewRow In grvErrorAnalysis.Rows
            Dim chkDelete As CheckBox = row.FindControl("clbSelect")
            If chkDelete.Checked Then
                Dim lblErrorAnalysisID As Label = row.Cells(1).FindControl("lblStt")
                Dim intErrorAnalysisID As String = lblErrorAnalysisID.Text
                Dim errorAnalysisService As New ErrorAnalysisService()
                Dim objErrorAnalysis = errorAnalysisService.DeleteContentErrorType(intErrorAnalysisID)
                Dim toastr As String = "iziToast.success({
                title: 'Deleted',
                message: '正常に削除されました!',
            })"
                ''Toastr will pop up after confirm deleted a row
                Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
                Databd()
            End If
        Next
    End Sub

    Protected Sub lkbSearch_Click(sender As Object, e As EventArgs) Handles lkbSearch.Click
        Session("Search") = txtSearch.Text
        Databd()
    End Sub
End Class