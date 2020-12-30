Imports System.Data.SqlClient

Public Class Add
    Inherits Filter.Class.BasePage
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    Dim errorAnalysisService As New ErrorAnalysisService
    Dim IdErrorType As Integer
    Dim useInfo As UserInfo = UserCookieData.GetUserData
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idProject") = 0 Then
            Response.Redirect("~/Project")
        End If
        If IsPostBack = False Then
            Session("ErrorAnalysis") = ""
            Session("GUID") = ""
            DataDB()
        End If
    End Sub

    Public Sub DataDB()
        Dim IdProject As String = Session("idProject")
        Dim IdErrorAnalysis As String = Request.QueryString("id")
        Dim projectId As New KPI_T_Task
        Dim newErrorAnalysis As New ErrorAnalysisInfo
        Dim errorList = errorAnalysisService.ListError()
        Dim phaseList = errorAnalysisService.ListPhase()
        Dim taskList = errorAnalysisService.ListTask(Session("idProject"))
        If IdProject = 0 Then
            ''Chect Project Id
            projectId.IdProject = 0
            'Direct to Project List
            Response.Redirect("~/Task")
        Else
            newErrorAnalysis.IdErrorAnalysis = 0
            Session("ErrorAnalysis") = "改修のレビューの追加"
            Title = "エラー分析の作成"
            If Session("lang") = "ja" Then
                For Each item As KPI_M_Error In errorList
                    ddlError.Items.Add(New ListItem(item.NameErrorJP, item.IdError))
                Next

                For Each item As KPI_M_Phase In phaseList
                    ddlPhase.Items.Add(New ListItem(item.NamePhaseJP, item.IdPhase))
                Next
            Else
                For Each item As KPI_M_Error In errorList
                    ddlError.Items.Add(New ListItem(item.NameError, item.IdError))
                Next

                For Each item As KPI_M_Phase In phaseList
                    ddlPhase.Items.Add(New ListItem(item.NamePhase, item.IdPhase))
                Next
            End If
            For Each item As KPI_T_Task In taskList
                ddlTask.Items.Add(New ListItem(item.Content, item.IdTask))
            Next
        End If
    End Sub

    Protected Sub btnContent_Click(sender As Object, e As EventArgs) Handles btnContent.Click
        Dim IdErrorAnalysis As String = Request.QueryString("id")
        Dim IdTask As String = Request.QueryString("idTask")
        Dim bug = txtBug.Text
        Dim reference = txtReference.Text
        Dim createAt = DateTime.Now
        Dim objAddErrorAnalysis As New ErrorAnalysisInfo
        Dim objUserId As New KPI_T_ProjectUser
        Dim UserId As String = useInfo.IdUser
        objAddErrorAnalysis.IdErrorAnalysis = IdErrorAnalysis
        objAddErrorAnalysis.IdTask = ddlTask.SelectedValue
        objAddErrorAnalysis.IdPhase = ddlPhase.SelectedValue
        objAddErrorAnalysis.IdError = ddlError.SelectedValue
        objAddErrorAnalysis.Bug = bug
        objAddErrorAnalysis.Reference = reference
        objAddErrorAnalysis.CreateAt = createAt
        objAddErrorAnalysis.IdQualityAnalysis = Request.QueryString("idQualityAnalysis")
        objUserId.IdUser = UserId
        Dim errorAnalysisService As New ErrorAnalysisService
        If Session("GUID").ToString() Like txtGuid.Text = False Then
            Session("GUID") = txtGuid.Text
            If String.IsNullOrEmpty(bug.ToString) = False Then
                If txtBug.Text >= 0 Then
                    errorAnalysisService.CreateContentErrorType(objAddErrorAnalysis)
                    'MsgBox("Success")
                    Dim toastr As String = "iziToast.success({
                    title: 'Succeeded',
                    message: '正常に登録されました!',
                })"
                    Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
                    txtBug.Text = ""
                    txtReference.Text = ""
                    ddlTask.SelectedValue = 0
                    ddlError.SelectedValue = 0
                    ddlPhase.SelectedValue = 0
                End If
            End If
        Else
            DataDB()
        End If
    End Sub

    Protected Sub btnErrorAnalysis_Click(sender As Object, e As EventArgs) Handles btnErrorAnalysis.Click
        Dim IdErrorAnalysis As String = Request.QueryString("id")
        Dim IdTask As String = Request.QueryString("idTask")
        Dim bug = txtBug.Text
        Dim reference = txtReference.Text
        Dim createAt = DateTime.Now
        Dim objAddErrorAnalysis As New ErrorAnalysisInfo
        Dim objUserId As New KPI_T_ProjectUser
        Dim UserId As String = useInfo.IdUser
        objAddErrorAnalysis.IdErrorAnalysis = IdErrorAnalysis
        objAddErrorAnalysis.IdTask = ddlTask.SelectedValue
        objAddErrorAnalysis.IdPhase = ddlPhase.SelectedValue
        objAddErrorAnalysis.IdError = ddlError.SelectedValue
        objAddErrorAnalysis.Bug = bug
        objAddErrorAnalysis.Reference = reference
        objAddErrorAnalysis.CreateAt = createAt
        objAddErrorAnalysis.IdQualityAnalysis = Request.QueryString("idQualityAnalysis")
        objUserId.IdUser = UserId
        Dim errorAnalysisService As New ErrorAnalysisService

        If String.IsNullOrEmpty(bug.ToString) = False Then
            If txtBug.Text >= 0 Then
                errorAnalysisService.CreateContentErrorType(objAddErrorAnalysis)
                Session("notification") = "true"
                'MsgBox("Success")
                Response.Redirect("~/Task")
            End If
        End If
    End Sub

    Protected Sub ddlError_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub
End Class