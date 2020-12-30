Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.Services
Imports OfficeOpenXml
Imports OfficeOpenXml.Style
Imports System.Drawing

Public Class TaskList
    Inherits Filter.Class.BasePage
    Dim errorAnalysisServer As ErrorAnalysisService
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
            Session("SortIconFirstName") = "button_change_GUID fas fa-sort"
            Session("SortIconLevel") = "button_change_GUID fas fa-sort"
            Session("SortIconCreateAt") = "button_change_GUID fas fa-sort"
            Databd()
        End If
    End Sub

    Public Sub Databd()
        ''Show total Task to List with Page size, all column and row with sorting matter base on id Project
        grvContent.PageSize = 10
        Dim ContentService As New ContentService()
        grvContent.VirtualItemCount = ContentService.GetCount(Session("idProject"), Session("Search"), useInfo.IdUser)
        Dim dataTable As New DataTable()
        grvContent.DataSource = ContentService.GetContentList(Session("idProject"), grvContent.PageIndex + 1, grvContent.PageSize, Session("Search"), Session("SortColumn"), Session("SortOrder"), useInfo.IdUser)
        grvContent.DataBind()
        If (grvContent.Rows.Count = 0) Then
            grvContent.DataBind()
        End If
        ''Check condition Role to show or hide Column 
        If UserCookieData.GetUserData().RoleName = "Manager" Then
            grvContent.Columns(0).Visible = False
        End If
    End Sub

    Protected Sub grvTodoList_IndexChange(sender As Object, e As GridViewPageEventArgs) Handles grvContent.PageIndexChanging
        grvContent.PageIndex = e.NewPageIndex
        Databd()
    End Sub

    Protected Sub grvContent_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grvContent.RowCommand
        ''Command name List show detail of every tasks
        If e.CommandName.Equals("List") Then
            Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Dim lblIdTask As Label = grvContent.Rows(rowIndex).FindControl("lblStt")
            Response.Redirect("~/ErrorAnalysis?id=" + lblIdTask.Text)
        End If
        ''Conmand name Edit move to Modify Page to edit a task row.
        If e.CommandName.Equals("Edit") Then
            Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Dim lblIdTask As Label = grvContent.Rows(rowIndex).FindControl("lblStt")
            Response.Redirect("~/Task/Edit?id=" + lblIdTask.Text)
        End If
        ''Command Delete perform delete single row 
        If e.CommandName.Equals("Delete") Then
            Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Dim lblIdTask As Label = grvContent.Rows(rowIndex).FindControl("lblStt")
            Dim contentService As New ContentService
            contentService.DeleteContent(lblIdTask.Text)
            Response.Redirect("~/Task")
        End If
        ''Sort rownum of the table
        If e.CommandName.Equals("SORTORDERROWNUM") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconFirstName") = "button_change_GUID fas fa-sort"
                Session("SortIconLevel") = "button_change_GUID fas fa-sort"
                Session("SortIconCreateAt") = "button_change_GUID fas fa-sort"
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
        ''sort Content Task List of the table
        If e.CommandName.Equals("SORTCONTENT") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconFirstName") = "button_change_GUID fas fa-sort"
                Session("SortIconLevel") = "button_change_GUID fas fa-sort"
                Session("SortIconCreateAt") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "Content"
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

        If e.CommandName.Equals("SORTFIRSTNAME") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconLevel") = "button_change_GUID fas fa-sort"
                Session("SortIconCreateAt") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "FirstName"
                If Session("SortIconFirstName") = "button_change_GUID fas fa-sort" Then
                    Session("SortIconFirstName") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                ElseIf Session("SortIconFirstName") = "button_change_GUID fas fa-sort-up" Then
                    Session("SortIconFirstName") = "button_change_GUID fas fa-sort-down"
                    Session("SortOrder") = "ASC"
                ElseIf Session("SortIconFirstName") = "button_change_GUID fas fa-sort-down" Then
                    Session("SortIconFirstName") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                End If
                Databd()
            Else
                Databd()
            End If
        End If
        ''sort level row
        If e.CommandName.Equals("SORTLEVEL") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconFirstName") = "button_change_GUID fas fa-sort"
                Session("SortIconCreateAt") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "Level"
                If Session("SortIconLevel") = "button_change_GUID fas fa-sort" Then
                    Session("SortIconLevel") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                ElseIf Session("SortIconLevel") = "button_change_GUID fas fa-sort-up" Then
                    Session("SortIconLevel") = "button_change_GUID fas fa-sort-down"
                    Session("SortOrder") = "ASC"
                ElseIf Session("SortIconLevel") = "button_change_GUID fas fa-sort-down" Then
                    Session("SortIconLevel") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                End If
                Databd()
            Else
                Databd()
            End If
        End If
        ''short create at row
        If e.CommandName.Equals("SORTCREATEAT") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconFirstName") = "button_change_GUID fas fa-sort"
                Session("SortIconLevel") = "button_change_GUID fas fa-sort"
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "CreateAt"
                If Session("SortIconCreateAt") = "button_change_GUID fas fa-sort" Then
                    Session("SortIconCreateAt") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                ElseIf Session("SortIconCreateAt") = "button_change_GUID fas fa-sort-up" Then
                    Session("SortIconCreateAt") = "button_change_GUID fas fa-sort-down"
                    Session("SortOrder") = "ASC"
                ElseIf Session("SortIconCreateAt") = "button_change_GUID fas fa-sort-down" Then
                    Session("SortIconCreateAt") = "button_change_GUID fas fa-sort-up"
                    Session("SortOrder") = "DESC"
                End If
                Databd()
            Else
                Databd()
            End If
        End If
    End Sub

    ''Delete multiSelect from 1 or more row selected 
    Protected Sub btnDeleteMulti_Click(sender As Object, e As EventArgs) Handles btnDeleteMulti.Click
        For Each row As GridViewRow In grvContent.Rows
            Dim chkDelete As CheckBox = row.FindControl("clbSelect")
            If chkDelete.Checked Then
                Dim lblTaskID As Label = row.Cells(1).FindControl("lblStt")
                Dim intTaskID As String = lblTaskID.Text
                Dim taskService As New ContentService()
                Dim objTask = taskService.DeleteContent(intTaskID)
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

    ''Function of button download Excel File
    Protected Sub btntoCsv_Click(sender As Object, e As EventArgs) Handles btntoCsv.Click
        Dim ep As New ExcelPackage()
        Dim Sheet As ExcelWorksheet = ep.Workbook.Worksheets.Add("Report")
        Dim sb As StringBuilder = New StringBuilder()
        If Session("lang") = "ja" Then
            Sheet.Cells().Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
            Sheet.Cells().Style.VerticalAlignment = ExcelVerticalAlignment.Center
            ''Header cell
            Sheet.Cells("A1").Value = "項番"
            Sheet.Cells("A1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("B1").Value = "改修内容"
            Sheet.Cells("B1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("C1").Value = "改修メイン担当"
            Sheet.Cells("C1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("D1").Value = "フェーズ/Phase"
            Sheet.Cells("D1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("E1").Value = "レビュー指摘事項・バグ分類"
            Sheet.Cells("E1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("F1").Value = "指摘・バグ件数"
            Sheet.Cells("F1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("G1").Value = "備考"
            Sheet.Cells("G1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
        Else
            Sheet.Cells().Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
            Sheet.Cells().Style.VerticalAlignment = ExcelVerticalAlignment.Center
            ''Header cell
            Sheet.Cells("A1").Value = "STT"
            Sheet.Cells("A1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("B1").Value = "Nội dung sửa"
            Sheet.Cells("B1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("C1").Value = "Chịu trách nhiệm sửa chính"
            Sheet.Cells("C1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("D1").Value = "Công đoạn"
            Sheet.Cells("D1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("E1").Value = "Hạng mục lỗi review ・Phân loại bug"
            Sheet.Cells("E1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("F1").Value = "Lỗi ・ số lượng bug"
            Sheet.Cells("F1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
            Sheet.Cells("G1").Value = "Tham khảo"
            Sheet.Cells("G1").Style.Border.BorderAround(ExcelBorderStyle.Thin)
        End If

        ''body cell
        Dim lstTask As List(Of ErrorAnalysisInfo)
        Dim intNo As Integer = 0
        Dim cellMerge As Integer = 0
        Dim taskService As New ContentService()
        lstTask = taskService.GetErrorAnalysis(2, useInfo.IdUser)
        Dim contentCell As String = ""
        If Session("lang") = "ja" Then
            For Each objTask As ErrorAnalysisInfo In lstTask
                intNo = intNo + 1
                Sheet.Cells(String.Format("A{0}", intNo + 1)).Value = intNo
                Sheet.Cells(String.Format("A{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("B{0}", intNo + 1)).Value = objTask.Content
                ''merge cell
                If objTask.Content <> contentCell Then
                    contentCell = objTask.Content
                    Sheet.Cells(String.Format("B{0}:B{1}", cellMerge + 1, intNo)).Merge = True
                    cellMerge = intNo
                End If
                Sheet.Cells(String.Format("B{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("C{0}", intNo + 1)).Value = objTask.FirstName + " " + objTask.LastName
                Sheet.Cells(String.Format("C{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Value = objTask.NamePhaseJP
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Value = objTask.NameErrorJP
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("F{0}", intNo + 1)).Value = objTask.Bug
                Sheet.Cells(String.Format("F{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("G{0}", intNo + 1)).Value = objTask.Reference
                Sheet.Cells(String.Format("G{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)

            Next
        Else
            For Each objTask As ErrorAnalysisInfo In lstTask
                intNo = intNo + 1
                Sheet.Cells(String.Format("A{0}", intNo + 1)).Value = intNo
                Sheet.Cells(String.Format("A{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("B{0}", intNo + 1)).Value = objTask.Content
                ''merge cell
                If objTask.Content <> contentCell Then
                    contentCell = objTask.Content
                    Sheet.Cells(String.Format("B{0}:B{1}", cellMerge + 1, intNo)).Merge = True
                    cellMerge = intNo
                End If
                Sheet.Cells(String.Format("B{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("C{0}", intNo + 1)).Value = objTask.FirstName + " " + objTask.LastName
                Sheet.Cells(String.Format("C{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Value = objTask.NamePhase
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Value = objTask.NameError
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("F{0}", intNo + 1)).Value = objTask.Bug
                Sheet.Cells(String.Format("F{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("G{0}", intNo + 1)).Value = objTask.Reference
                Sheet.Cells(String.Format("G{0}", intNo + 1)).Style.Border.BorderAround(ExcelBorderStyle.Thin)

            Next
        End If
        Sheet.Cells(String.Format("B{0}:B{1}", cellMerge + 1, intNo + 1)).Merge = True
        Dim headerCells = Sheet.Cells(1, 1, 1, Sheet.Dimension.Columns)
        headerCells.Style.Fill.PatternType = Style.ExcelFillStyle.Solid
        headerCells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(153, 255, 153))
        Sheet.Cells(Sheet.Dimension.Address).AutoFitColumns()
        Sheet.Cells("A1:G1").AutoFitColumns()
        Response.Clear()
        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        Response.AddHeader("content-disposition", String.Format("attachment;filename={0} レビュー指摘事項・バグ分類及び分析表.xlsx", DateTime.Now.ToString("yyyy-MM-dd HH-mm-ss")))
        Response.BinaryWrite(ep.GetAsByteArray())
        Response.End()
    End Sub

    ''Search text
    Protected Sub lkbSearch_Click(sender As Object, e As EventArgs) Handles lkbSearch.Click
        Session("Search") = txtSearch.Text
        Databd()
    End Sub
End Class