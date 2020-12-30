Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.Services
Imports System.Web.Script.Services
Imports OfficeOpenXml
Imports System.Drawing
Imports OfficeOpenXml.Style

Public Class QuanlityAnalysis
    Inherits Filter.Class.BasePage
    Dim EditContentService As New EditContentService
    Dim useInfo As UserInfo = UserCookieData.GetUserData
    Dim targetService As New TargetService
    Dim aNalysisService As New EditContentService
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idProject") = 0 Then
            Response.Redirect("~/Project")
        End If
        grvQA.EditIndex = -1
        ''show confim when click dowload csv
        btnDowloadCSV.OnClientClick = "return confirm('" + Resources.KPI.language.confDownload + "');"
        If IsPostBack = False Then
            ''save and compare guid send from client and assign values after compare
            Session("CheckGuid") = ""
            '' save column will sort, default Deadline
            Session("SortColumn") = "RowNum"
            ''save sort ASC(increase) or DESC(deincrease) for column order
            Session("SortOrder") = "ASC"
            '' save search text in textbox search
            Session("Search") = ""
            '' save icon sort will show on client
            Session("SortIconNumorder") = "button_change_GUID fas fa-sort-down"
            Session("SortIconContent") = "button_change_GUID fas fa-sort"
            Session("SortIconLevel") = "button_change_GUID fas fa-sort"
            Session("SortIconMember") = "button_change_GUID fas fa-sort"
            Session("SortIconReason") = "button_change_GUID fas fa-sort"
            SetDataSource()
        End If
    End Sub
    ''' <summary>
    ''' set data for gridview
    ''' </summary>
    Private Sub SetDataSource()
        Dim idProject = 0
        Try
            idProject = Integer.Parse(Session("idProject"))
        Catch ex As Exception

        End Try
        grvQA.PageSize = ConfigurationManager.AppSettings("PageSize").ToString()
        grvQA.VirtualItemCount = EditContentService.GetCountEditContent(Session("Search"), useInfo.RoleName, useInfo.IdUser, idProject)
        grvQA.DataSource = EditContentService.GetEditContent(grvQA.PageIndex + 1, grvQA.PageSize, Session("SortColumn"), Session("Search"), Session("SortOrder"), useInfo.RoleName, useInfo.IdUser, idProject)
        grvQA.DataBind()
    End Sub
    ''' <summary>
    ''' Occurs when one of the pager buttons is clicked
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub RowIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles grvQA.PageIndexChanging
        grvQA.PageIndex = e.NewPageIndex
        SetDataSource()
    End Sub
    ''' <summary>
    ''' change session store class icon sort and order sort
    ''' </summary>
    ''' <param name="nameColumn"></param>
    Protected Sub ChangeSortIcon(ByVal nameColumn As String)
        If Session("SortIcon" + nameColumn) = "button_change_GUID fas fa-sort" Then
            Session("SortIcon" + nameColumn) = "button_change_GUID fas fa-sort-up"
            Session("SortOrder") = "DESC"
        ElseIf Session("SortIcon" + nameColumn) = "button_change_GUID fas fa-sort-up" Then
            Session("SortIcon" + nameColumn) = "button_change_GUID fas fa-sort-down"
            Session("SortOrder") = "ASC"
        ElseIf Session("SortIcon" + nameColumn) = "button_change_GUID fas fa-sort-down" Then
            Session("SortIcon" + nameColumn) = "button_change_GUID fas fa-sort-up"
            Session("SortOrder") = "DESC"
        End If
    End Sub
    ''' <summary>
    ''' Occurs when a button is clicked
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grvQA.RowCommand
        ''event click icon sort rownum column
        If e.CommandName.Equals("SORTORDERROWNUM") Then
            'check event is viewstate  or event click
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconLevel") = "button_change_GUID fas fa-sort"
                Session("SortIconMember") = "button_change_GUID fas fa-sort"
                Session("SortIconReason") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "RowNum"
                ChangeSortIcon("Numorder")
                SetDataSource()
            Else
                SetDataSource()
            End If
        End If
        ''event click icon sort content column
        If e.CommandName.Equals("SORTCONTENT") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconLevel") = "button_change_GUID fas fa-sort"
                Session("SortIconMember") = "button_change_GUID fas fa-sort"
                Session("SortIconReason") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "Content"
                ChangeSortIcon("Content")
                SetDataSource()
            Else
                SetDataSource()
            End If
        End If
        ''event click icon sort level column
        If e.CommandName.Equals("SORTLEVEL") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconMember") = "button_change_GUID fas fa-sort"
                Session("SortIconReason") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "Level"
                ChangeSortIcon("Level")
                SetDataSource()
            Else
                SetDataSource()
            End If
        End If
        ''event click icon sort member column
        If e.CommandName.Equals("SORTMEMBER") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconReason") = "button_change_GUID fas fa-sort"
                Session("SortIconLevel") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "Member"
                ChangeSortIcon("Member")
                SetDataSource()
            Else
                SetDataSource()
            End If
        End If
        ''event click icon sort reason column
        If e.CommandName.Equals("SORTREASON") Then
            If Session("CheckGuid").ToString() Like txtGuid.Text <> True Then
                Session("CheckGuid") = txtGuid.Text
                'check if Page Load do not use this event
                Session("SortIconNumorder") = "button_change_GUID fas fa-sort"
                Session("SortIconContent") = "button_change_GUID fas fa-sort"
                Session("SortIconLevel") = "button_change_GUID fas fa-sort"
                Session("SortIconMember") = "button_change_GUID fas fa-sort"
                Session("SortColumn") = "Reason"
                ChangeSortIcon("Reason")
                SetDataSource()
            Else
                SetDataSource()
            End If
        End If
    End Sub

    Protected Sub lkbSearch_Click(sender As Object, e As EventArgs) Handles lkbSearch.Click
        Session("Search") = txtSearch.Text
        SetDataSource()
    End Sub
    Protected Sub btnDetail(ByVal sender As Object, ByVal e As EventArgs)
        Dim btnDetail As Button = CType(sender, Button)
        Response.Redirect("~/Quanlity/Detail?idTask=" + btnDetail.CommandArgument + "")
    End Sub
    Protected Sub btnEdit(ByVal sender As Object, ByVal e As EventArgs)
        Dim btnEdit As Button = CType(sender, Button)
        Response.Redirect("~/Quanlity/Edit?idTask=" + btnEdit.CommandArgument + "")
    End Sub
    <WebMethod()>
    <ScriptMethod(UseHttpGet:=True,
 ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=False)>
    Public Shared Function GetDemo() As String
        Return "demo"
    End Function
    Public Function Data() As TargetInfo
        Dim lstAnalysis = targetService.GetAnalysisContent(useInfo.IdUser, Session("idProject"), UserCookieData.GetUserData.RoleName)
        Dim objTarget As New TargetInfo
        Dim intHour As Double = 0
        Dim strCheckIdEditcontent = 0
        Dim countTask = 0
        For Each item As QualityAnalysis In lstAnalysis
            If strCheckIdEditcontent <> item.IdEditContent Then
                countTask = countTask + 1
                intHour = 0
                strCheckIdEditcontent = item.IdEditContent
                For Each i As QualityAnalysis In lstAnalysis
                    If i.IdEditContent = item.IdEditContent Then
                        intHour = intHour + i.Hour
                    End If
                Next
            End If
            If item.NamePhase = "設計" Then
                Try
                    If item.Hour <> 0 Then
                        objTarget.DesignTarget = item.Bug / item.Hour + objTarget.DesignTarget
                    End If
                Catch ex As Exception
                End Try
            End If
            If item.NamePhase = "製造" Then
                Try
                    If item.Hour <> 0 Then
                        objTarget.CodeTarget = item.Bug / item.Hour + objTarget.CodeTarget
                    End If
                Catch ex As Exception

                End Try
            End If
            If item.NamePhase = "テスト" Then
                Try
                    If item.Hour <> 0 Then
                        objTarget.TestTarget = item.Bug / item.Hour + objTarget.TestTarget
                    End If

                Catch ex As Exception

                End Try
            End If
            If item.NamePhase = "BRC内部受入" Then
                Try
                    If intHour <> 0 Then
                        objTarget.AcceptBRCTarget = item.Bug / intHour + objTarget.AcceptBRCTarget
                    End If

                Catch ex As Exception

                End Try
            End If
            If item.NamePhase = "OSC様受入" Then
                Try
                    If intHour <> 0 Then
                        objTarget.AcceptOSCTarget = item.Bug / intHour + objTarget.AcceptOSCTarget
                    End If

                Catch ex As Exception

                End Try
            End If
            If item.NamePhase = "業務側受入(リリース後含む" Then
                Try
                    If intHour <> 0 Then
                        objTarget.AcceptProfessionTarget = item.Bug / intHour + objTarget.AcceptProfessionTarget
                    End If
                Catch ex As Exception

                End Try
            End If
        Next
        objTarget.AcceptBRCTarget = objTarget.AcceptBRCTarget / countTask
        objTarget.AcceptOSCTarget = objTarget.AcceptOSCTarget / countTask
        objTarget.AcceptProfessionTarget = objTarget.AcceptProfessionTarget / countTask
        objTarget.CodeTarget = objTarget.CodeTarget / countTask
        objTarget.DesignTarget = objTarget.DesignTarget / countTask
        objTarget.TestTarget = objTarget.TestTarget / countTask
        Return objTarget
    End Function
    Protected Sub btnDowloadCSV_Click(sender As Object, e As EventArgs) Handles btnDowloadCSV.Click
        Dim ep As New ExcelPackage()
        Dim Sheet As ExcelWorksheet = ep.Workbook.Worksheets.Add("Report")
        Sheet.Cells().Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
        Sheet.Cells().Style.VerticalAlignment = ExcelVerticalAlignment.Center
        ''Row NO
        Sheet.Cells("A1").Value = Resources.KPI.language.clmNum
        Sheet.Cells("A1:A2").Merge = True
        Sheet.Cells("A1:A2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''Row Nội dung sửa
        Sheet.Cells("B1").Value = Resources.KPI.language.clmTask
        Sheet.Cells("B1:B2").Merge = True
        Sheet.Cells("B1:B2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''Row Độ khó
        Sheet.Cells("C1").Value = Resources.KPI.language.clmLevel
        Sheet.Cells("C1:C2").Merge = True
        Sheet.Cells("C1:C2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''Row Chịu trách nhiệm sửa chính
        Sheet.Cells("D1").Value = Resources.KPI.language.clmUser
        Sheet.Cells("D1:D2").Merge = True
        Sheet.Cells("D1:D2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''Row Thiết kế
        Sheet.Cells("E1").Value = Resources.KPI.language.designPhase
        Sheet.Cells("E1:H1").Merge = True
        Sheet.Cells("E1:H1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("E2").Value = Resources.KPI.language.numJob
        Sheet.Cells("E2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("F2").Value = Resources.KPI.language.errorReview
        Sheet.Cells("F2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("G2").Value = Resources.KPI.language.errorRateOnJob
        Sheet.Cells("G2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("H2").Value = Resources.KPI.language.yesNoOverStand
        Sheet.Cells("H2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''Row Code
        Sheet.Cells("I1").Value = Resources.KPI.language.codePhase
        Sheet.Cells("I1:L1").Merge = True
        Sheet.Cells("I1:L1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("I2").Value = Resources.KPI.language.numJob
        Sheet.Cells("I2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("J2").Value = Resources.KPI.language.errorReview
        Sheet.Cells("J2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("K2").Value = Resources.KPI.language.errorRateOnJob
        Sheet.Cells("K2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("L2").Value = Resources.KPI.language.yesNoOverStand
        Sheet.Cells("L2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''Row Test
        Sheet.Cells("M1").Value = Resources.KPI.language.testPhase
        Sheet.Cells("M1:P1").Merge = True
        Sheet.Cells("M1:P1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("M2").Value = Resources.KPI.language.numTest
        Sheet.Cells("M2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("N2").Value = Resources.KPI.language.numBug
        Sheet.Cells("N2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("O2").Value = Resources.KPI.language.rateBugHit
        Sheet.Cells("O2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("P2").Value = Resources.KPI.language.yesNoOverStand
        Sheet.Cells("P2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''Row Chấp nhận nội bộ
        Sheet.Cells("Q1").Value = Resources.KPI.language.BRCaccept
        Sheet.Cells("Q1:T1").Merge = True
        Sheet.Cells("Q1:T1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("Q2").Value = Resources.KPI.language.numJobDesignText
        Sheet.Cells("Q2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("R2").Value = Resources.KPI.language.errorAcceptBRC
        Sheet.Cells("R2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("S2").Value = Resources.KPI.language.rateBugHit
        Sheet.Cells("S2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("T2").Value = Resources.KPI.language.yesNoOverStand
        Sheet.Cells("T2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''Row Chấp nhận khách hàng BRC
        Sheet.Cells("U1").Value = Resources.KPI.language.OSCaccept
        Sheet.Cells("U1:X1").Merge = True
        Sheet.Cells("U1:X1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("U2").Value = Resources.KPI.language.numJobDesignText
        Sheet.Cells("U2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("V2").Value = Resources.KPI.language.errorAcceptOSC
        Sheet.Cells("V2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("W2").Value = Resources.KPI.language.rateBugHit
        Sheet.Cells("W2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("X2").Value = Resources.KPI.language.yesNoOverStand
        Sheet.Cells("X2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''Row Chấp nhận dịch vụ
        Sheet.Cells("Y1").Value = Resources.KPI.language.majorAccept
        Sheet.Cells("Y1:AA1").Merge = True
        Sheet.Cells("Y1:AA1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("Y2").Value = Resources.KPI.language.accepMajor
        Sheet.Cells("Y2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("Z2").Value = Resources.KPI.language.rateBugHit
        Sheet.Cells("Z2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("AA2").Value = Resources.KPI.language.yesNoOverStand
        Sheet.Cells("AA2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''Row phân tích nguyên nhân
        Sheet.Cells("AB1").Value = Resources.KPI.language.reasonCSV
        Sheet.Cells("AB1:AB2").Merge = True
        Sheet.Cells("AB1:AB2").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Dim headerCells = Sheet.Cells(1, 1, 1, Sheet.Dimension.Columns)
        headerCells.Style.Fill.PatternType = Style.ExcelFillStyle.Solid
        headerCells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(153, 255, 153))
        Dim Cellcolor = Sheet.Cells("E2:AA2")
        Cellcolor.Style.Fill.PatternType = Style.ExcelFillStyle.Solid
        Cellcolor.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(153, 255, 153))
        'set data for cell
        Dim no As Integer = 3
        Dim lstAnalysisContent As New List(Of QualityAnalysis)
        Dim idProject = Integer.Parse(Session("idProject"))
        Dim objTargetInfo = Data()
        For Each item In EditContentService.GetEditContent(1, EditContentService.GetCountEditContent("", useInfo.RoleName, useInfo.IdUser, idProject), "RowNum", "", "ASC", useInfo.RoleName, useInfo.IdUser, idProject)
            Sheet.Cells(String.Format("A{0}", no)).Value = item.RowNumber
            Sheet.Cells(String.Format("B{0}", no)).Value = item.Content
            Sheet.Cells(String.Format("C{0}", no)).Value = If(Session("lang") = "vi", item.Level, item.Levelja)
            Sheet.Cells(String.Format("D{0}", no)).Value = item.FullName
            Sheet.Cells(String.Format("AB{0}", no)).Value = item.Reason
            ''add data pharse cell
            lstAnalysisContent = aNalysisService.GetListAnalysisContent(useInfo.IdUser, idProject, item.IdTask, KPI.UserCookieData.GetUserData.RoleName)
            If lstAnalysisContent.Count = 0 Then
                Dim objAnalysis As New QualityAnalysis
                objAnalysis.Bug = 0
                objAnalysis.Hour = 0
                For i = 1 To 6
                    lstAnalysisContent.Add(objAnalysis)
                Next
            End If
            'design
            Sheet.Cells(String.Format("E{0}", no)).Value = lstAnalysisContent(5).Hour.ToString + " h"
            Sheet.Cells(String.Format("F{0}", no)).Value = lstAnalysisContent(5).Bug
            Sheet.Cells(String.Format("G{0}", no)).Value = If(lstAnalysisContent(5).Hour = 0, "", Math.Round(lstAnalysisContent(5).Bug / lstAnalysisContent(5).Hour, 4))
            Sheet.Cells(String.Format("H{0}", no)).Value = If(lstAnalysisContent(5).Hour = 0, "", If(objTargetInfo.DesignTarget < lstAnalysisContent(5).Bug / lstAnalysisContent(5).Hour, "★", ""))
            'code
            Sheet.Cells(String.Format("I{0}", no)).Value = lstAnalysisContent(4).Hour.ToString + " h"
            Sheet.Cells(String.Format("J{0}", no)).Value = lstAnalysisContent(4).Bug
            Sheet.Cells(String.Format("K{0}", no)).Value = If(lstAnalysisContent(4).Hour = 0, "", Math.Round(lstAnalysisContent(4).Bug / lstAnalysisContent(4).Hour, 4))
            Sheet.Cells(String.Format("L{0}", no)).Value = If(lstAnalysisContent(4).Hour = 0, "", If(objTargetInfo.DesignTarget < lstAnalysisContent(4).Bug / lstAnalysisContent(4).Hour, "★", ""))
            'test
            Sheet.Cells(String.Format("M{0}", no)).Value = lstAnalysisContent(2).Hour.ToString + " h"
            Sheet.Cells(String.Format("N{0}", no)).Value = lstAnalysisContent(2).Bug
            Sheet.Cells(String.Format("O{0}", no)).Value = If(lstAnalysisContent(2).Hour = 0, "", Math.Round(lstAnalysisContent(2).Bug / lstAnalysisContent(2).Hour, 4))
            Sheet.Cells(String.Format("P{0}", no)).Value = If(lstAnalysisContent(2).Hour = 0, "", If(objTargetInfo.DesignTarget < lstAnalysisContent(2).Bug / lstAnalysisContent(2).Hour, "★", ""))
            'accept brycen
            Dim sumHour = lstAnalysisContent(2).Hour + lstAnalysisContent(4).Hour + lstAnalysisContent(5).Hour
            Sheet.Cells(String.Format("Q{0}", no)).Value = sumHour.ToString + " h"
            Sheet.Cells(String.Format("R{0}", no)).Value = lstAnalysisContent(0).Bug
            Sheet.Cells(String.Format("S{0}", no)).Value = If(sumHour = 0, "", Math.Round(lstAnalysisContent(0).Bug / sumHour, 4))
            Sheet.Cells(String.Format("T{0}", no)).Value = If(sumHour = 0, "", If(objTargetInfo.AcceptBRCTarget < lstAnalysisContent(0).Bug / sumHour, "★", ""))
            'accept customer brycen
            Sheet.Cells(String.Format("U{0}", no)).Value = sumHour.ToString + " h"
            Sheet.Cells(String.Format("V{0}", no)).Value = lstAnalysisContent(1).Bug
            Sheet.Cells(String.Format("W{0}", no)).Value = If(sumHour = 0, "", Math.Round(lstAnalysisContent(1).Bug / sumHour, 4))
            Sheet.Cells(String.Format("X{0}", no)).Value = If(sumHour = 0, "", If(objTargetInfo.AcceptOSCTarget < lstAnalysisContent(1).Bug / sumHour, "★", ""))
            ' accept service
            Sheet.Cells(String.Format("Y{0}", no)).Value = lstAnalysisContent(3).Bug
            Sheet.Cells(String.Format("Z{0}", no)).Value = If(sumHour = 0, "", Math.Round(lstAnalysisContent(3).Bug / sumHour, 4))
            Sheet.Cells(String.Format("AA{0}", no)).Value = If(sumHour = 0, "", If(objTargetInfo.AcceptProfessionTarget < lstAnalysisContent(3).Bug / sumHour, "★", ""))
            no = no + 1
        Next
        'Sheet.Cells(String.Format("A{0}", 2)).Value = "demo"
        'Sheet.Cells("A2:B2").Merge = True
        Sheet.Cells(Sheet.Dimension.Address).AutoFitColumns()
        Sheet.Cells("A2:AZ2").AutoFitColumns()
        Response.Clear()
        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        'Response.AddHeader("content-disposition", "attachment: filename=" + "Report.xlsx")
        Response.AddHeader("content-disposition", String.Format("attachment;filename={0} {1}.xlsx", DateTime.Now.ToString("yyyy-MM-dd HH-mm-ss"), Resources.KPI.language.analysis))
        Response.BinaryWrite(ep.GetAsByteArray())
        Response.End()
    End Sub
End Class