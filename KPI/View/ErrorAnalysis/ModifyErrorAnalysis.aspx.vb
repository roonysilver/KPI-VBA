Imports System.Data.SqlClient

Public Class ModifyErrorAnalysis
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

    ''Showing Data Function
    Public Sub DataDB()
        Dim IdProject As String = Session("idProject")
        Dim IdErrorAnalysis As String = Request.QueryString("id")
        Dim projectId As New KPI_T_Task
        Dim newErrorAnalysis As New ErrorAnalysisInfo
        Dim errorList = errorAnalysisService.ListError()
        Dim phaseList = errorAnalysisService.ListPhase()
        ''Check if Each ErrorAnalysis has IdTask or not
        If IdProject = 0 Then
            ''Chect Project Id
            projectId.IdProject = 0
            'Direct to Project List
            Response.Redirect("~/Task")
        Else
            ''Check Error Analysis Id. If It = 0 then Show Add Form, else show Edit Form be because Add and Edit Using 1 form.
            If IdErrorAnalysis = 0 Then
                ''Add Form
                newErrorAnalysis.IdErrorAnalysis = 0
                btnContent.Visible = True
                Session("ErrorAnalysis") = Resources.KPI.language.errorHeaderAdd
                Title = "エラー分析の作成"
                ''Show DropdownList
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
            Else
                ''Edit Form
                Dim errorAnalysisObj = errorAnalysisService.Check(IdErrorAnalysis, useInfo.IdUser)
                If errorAnalysisObj.Count <> 0 Then
                    Title = "エラー分析の更新"
                    Session("ErrorAnalysis") = Resources.KPI.language.errorHeaderEdit
                    txtBug.Text = errorAnalysisObj(0).Bug.ToString
                    txtReference.Text = errorAnalysisObj(0).Reference.ToString
                    newErrorAnalysis.IdError = errorAnalysisObj(0).IdError
                    newErrorAnalysis.IdPhase = errorAnalysisObj(0).IdPhase
                    If Session("lang") = "ja" Then
                        For Each item As KPI_M_Error In errorList
                            If item.IdError = errorAnalysisObj(0).IdError Then
                                Dim dropItem As New ListItem(item.NameErrorJP, item.IdError)
                                dropItem.Selected = True
                                ddlError.Items.Add(dropItem)
                            Else
                                ddlError.Items.Add(New ListItem(item.NameErrorJP, item.IdError))
                            End If
                        Next

                        For Each item As KPI_M_Phase In phaseList
                            If item.IdPhase = errorAnalysisObj(0).IdPhase Then
                                Dim dropItem As New ListItem(item.NamePhaseJP, item.IdPhase)
                                dropItem.Selected = True
                                ddlPhase.Items.Add(dropItem)
                            Else
                                ddlPhase.Items.Add(New ListItem(item.NamePhaseJP, item.IdPhase))
                            End If
                        Next
                    Else
                        For Each item As KPI_M_Error In errorList
                            If item.IdError = errorAnalysisObj(0).IdError Then
                                Dim dropItem As New ListItem(item.NameError, item.IdError)
                                dropItem.Selected = True
                                ddlError.Items.Add(dropItem)
                            Else
                                ddlError.Items.Add(New ListItem(item.NameError, item.IdError))
                            End If
                        Next

                        For Each item As KPI_M_Phase In phaseList
                            If item.IdPhase = errorAnalysisObj(0).IdPhase Then
                                Dim dropItem As New ListItem(item.NamePhase, item.IdPhase)
                                dropItem.Selected = True
                                ddlPhase.Items.Add(dropItem)
                            Else
                                ddlPhase.Items.Add(New ListItem(item.NamePhase, item.IdPhase))
                            End If
                        Next
                    End If
                End If
                End If
        End If


    End Sub
    ''' <summary>
    ''' Submit and Continue Button
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
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
        objAddErrorAnalysis.IdTask = IdTask
        objAddErrorAnalysis.IdPhase = ddlPhase.SelectedValue
        objAddErrorAnalysis.IdError = ddlError.SelectedValue
        objAddErrorAnalysis.Bug = bug
        objAddErrorAnalysis.Reference = reference
        objAddErrorAnalysis.CreateAt = createAt
        objAddErrorAnalysis.IdQualityAnalysis = Request.QueryString("idQualityAnalysis")
        objUserId.IdUser = UserId
        Dim errorAnalysisService As New ErrorAnalysisService
        ''Check Create New Row if Id ErrorAnalysis = 0 else Update selected row
        If IdErrorAnalysis = 0 Then
            ''Use GUID to stop Resubmit
            If Session("GUID").ToString() Like txtGuid.Text = False Then
                Session("GUID") = txtGuid.Text
                If String.IsNullOrEmpty(bug.ToString) = False Then
                    If txtBug.Text >= 0 Then
                        errorAnalysisService.CreateContentErrorType(objAddErrorAnalysis)
                        ''Using Toastr
                        Dim toastr As String = "iziToast.success({
                    title: 'Succeeded',
                    message: '正常に登録されました！',
                })"
                        Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
                        txtBug.Text = ""
                        txtReference.Text = ""
                        ddlError.SelectedValue = 0
                        ddlPhase.SelectedValue = 0
                    End If
                End If
            Else
                DataDB()
            End If
        Else
            If txtBug.Text >= 0 Then
                errorAnalysisService.UpdateContentErrorType(objAddErrorAnalysis, objUserId)
                Session("notification") = "true"
                Response.Redirect("~/ErrorAnalysis?id=" + IdTask)
            End If
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
        objAddErrorAnalysis.IdTask = IdTask
        objAddErrorAnalysis.IdPhase = ddlPhase.SelectedValue
        objAddErrorAnalysis.IdError = ddlError.SelectedValue
        objAddErrorAnalysis.Bug = bug
        objAddErrorAnalysis.Reference = reference
        objAddErrorAnalysis.CreateAt = createAt
        objAddErrorAnalysis.IdQualityAnalysis = Request.QueryString("idQualityAnalysis")
        objUserId.IdUser = UserId
        Dim errorAnalysisService As New ErrorAnalysisService
        If IdErrorAnalysis = 0 Then
            If String.IsNullOrEmpty(bug.ToString) = False Then
                If txtBug.Text >= 0 Then
                    errorAnalysisService.CreateContentErrorType(objAddErrorAnalysis)
                    Dim toastr As String = "iziToast.success({
                    title: 'Succeeded',
                    message: '正常に挿入されました!',
                })"
                    Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
                    Response.Redirect("~/ErrorAnalysis?id=" + IdTask)
                End If
            End If
        Else
            If txtBug.Text >= 0 Then
                errorAnalysisService.UpdateContentErrorType(objAddErrorAnalysis, objUserId)
                Session("notification") = "true"
                Response.Redirect("~/ErrorAnalysis?id=" + IdTask)
            End If
        End If

    End Sub
End Class