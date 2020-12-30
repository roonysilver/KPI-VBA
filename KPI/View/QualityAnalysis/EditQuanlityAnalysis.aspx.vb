Public Class EditQuanlityAnalysis
    Inherits Filter.Class.BasePage
    Dim editCOntentService As New EditContentService
    Dim aNalysisService As New KPI.EditContentService
    Dim userInfo = UserCookieData.GetUserData
    Dim idTask As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idProject") = 0 Then
            Response.Redirect("~/Project")
        End If
        Try
            idTask = Request.QueryString("idTask")
        Catch ex As Exception
            Response.Redirect("~/Quanlity")
        End Try
        If IsPostBack = False Then
            ShowData()
        End If
    End Sub
    'show data in edit form
    Protected Sub ShowData()
        Dim lstAnalysisContent As New List(Of KPI.QualityAnalysis)
        lstAnalysisContent = aNalysisService.GetListAnalysisContent(userInfo.IdUser, Session("idProject"), idTask, userInfo.RoleName)
        If lstAnalysisContent.Count = 0 Then
            Dim objAnalysis As New KPI.QualityAnalysis
            objAnalysis.Bug = 0
            objAnalysis.Hour = 0
            For item = 1 To 6
                lstAnalysisContent.Add(objAnalysis)
            Next
        End If
        txtReason.Text = editCOntentService.GetReasonOfTask(idTask, userInfo.RoleName, userInfo.IdUser, Session("idProject")).Reason
        txtWorkCode.Text = lstAnalysisContent(4).Hour
        txtWorkDesign.Text = lstAnalysisContent(5).Hour
        txtWorkTest.Text = lstAnalysisContent(2).Hour
    End Sub
    ''' <summary>
    ''' event when update buton
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        If txtWorkDesign.Text >= 0 And txtWorkTest.Text >= 0 And txtWorkCode.Text >= 0 Then
            If editCOntentService.UpdateReasonHour(userInfo.IdUser, userInfo.RoleName, Session("idProject"), idTask, txtWorkDesign.Text, txtWorkCode.Text, txtWorkTest.Text, txtReason.Text) Then
                Session("notification") = "true"
                Response.Redirect("~/Quanlity")
            Else
                Session("notification") = "false"
            End If
        End If
    End Sub
End Class