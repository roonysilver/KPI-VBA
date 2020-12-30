Imports System.Drawing
Imports OfficeOpenXml
Imports OfficeOpenXml.Style

Public Class WebForm1
    Inherits Filter.Class.BasePage
    Dim targetService As New TargetService
    Dim phaseService As New PhaseService
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''show confim when click dowload csv
        btnDowloadCSV.OnClientClick = "return confirm('" + Resources.KPI.language.confDownload + "');"
        If Session("idProject") = 0 Or Session("idProject") = Nothing Then
            Response.Redirect("~/Project")
        End If
        'Session("notification") = "true"
    End Sub
    Public Function SetData() As TargetInfo
        Dim lstAnalysis = targetService.GetAnalysisContent(UserCookieData.GetUserData.IdUser, Session("idProject"), UserCookieData.GetUserData.RoleName)
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
        ''Header cell
        Sheet.Cells("A1").Value = Resources.KPI.language.clmNum
        Sheet.Cells("A1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("B1").Value = Resources.KPI.language.phase
        Sheet.Cells("B1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("C1").Value = Resources.KPI.language.menu
        Sheet.Cells("C1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("D1").Value = Resources.KPI.language.average
        Sheet.Cells("D1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        Sheet.Cells("E1").Value = Resources.KPI.language.tolerance
        Sheet.Cells("E1").Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
        ''body cell
        Dim objTarget = SetData()
        Dim intNo As Integer = 0
        For Each item As KPI_M_Phase In phaseService.GetListPhase
            intNo = intNo + 1
            Sheet.Cells(String.Format("A{0}", intNo + 1)).Value = intNo
            Sheet.Cells(String.Format("A{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
            If Session("lang") = "vi" Then
                Sheet.Cells(String.Format("B{0}", intNo + 1)).Value = item.NamePhase
                Sheet.Cells(String.Format("B{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("C{0}", intNo + 1)).Value = item.Target
                Sheet.Cells(String.Format("C{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
            Else
                Sheet.Cells(String.Format("B{0}", intNo + 1)).Value = item.NamePhaseJP
                Sheet.Cells(String.Format("B{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("C{0}", intNo + 1)).Value = item.TargetJP
                Sheet.Cells(String.Format("C{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
            End If
            If item.NamePhaseJP = "設計" Then
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Value = Math.Round(objTarget.DesignTarget, 4)
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Value = Math.Round(objTarget.DesignTarget * 0.7, 4).ToString + "~" + Math.Round(objTarget.DesignTarget * 1.3, 4).ToString
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
            End If
            If item.NamePhaseJP = "製造" Then
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Value = Math.Round(objTarget.CodeTarget, 4)
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Value = Math.Round(objTarget.CodeTarget * 0.7, 4).ToString + "~" + Math.Round(objTarget.CodeTarget * 1.3, 4).ToString
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
            End If
            If item.NamePhaseJP = "テスト" Then
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Value = Math.Round(objTarget.TestTarget, 4)
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Value = Math.Round(objTarget.TestTarget * 0.7, 4).ToString + "~" + Math.Round(objTarget.TestTarget * 1.3, 4).ToString
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
            End If
            If item.NamePhaseJP = "BRC内部受入" Then
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Value = Math.Round(objTarget.AcceptBRCTarget, 4)
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Value = Math.Round(objTarget.AcceptBRCTarget * 0.7, 4).ToString + "~" + Math.Round(objTarget.AcceptBRCTarget * 1.3, 4).ToString
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
            End If
            If item.NamePhaseJP = "OSC様受入" Then
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Value = Math.Round(objTarget.AcceptOSCTarget, 4)
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Value = Math.Round(objTarget.AcceptOSCTarget * 0.7, 4).ToString + "~" + Math.Round(objTarget.AcceptOSCTarget * 1.3, 4).ToString
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
            End If
            If item.NamePhaseJP = "業務側受入(リリース後含む" Then
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Value = Math.Round(objTarget.AcceptProfessionTarget, 4)
                Sheet.Cells(String.Format("D{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Value = Math.Round(objTarget.AcceptProfessionTarget * 0.7, 4).ToString + "~" + Math.Round(objTarget.AcceptProfessionTarget * 1.3, 4).ToString
                Sheet.Cells(String.Format("E{0}", intNo + 1)).Style.Border.BorderAround(Style.ExcelBorderStyle.Thin)
            End If
        Next
        Dim headerCells = Sheet.Cells(1, 1, 1, Sheet.Dimension.Columns)
        headerCells.Style.Fill.PatternType = Style.ExcelFillStyle.Solid
        headerCells.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(153, 255, 153))
        Sheet.Cells(Sheet.Dimension.Address).AutoFitColumns()
        Sheet.Cells("A1:E1").AutoFitColumns()
        Response.Clear()
        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        'Response.AddHeader("content-disposition", "attachment: filename=" + "KPITarget.xlsx")
        Response.AddHeader("content-disposition", String.Format("attachment;filename={0} {1}.xlsx", DateTime.Now.ToString("yyyy-MM-dd HH-mm-ss"), Resources.KPI.language.cardheaderTarget))
        Response.BinaryWrite(ep.GetAsByteArray())
        Response.End()
    End Sub
End Class