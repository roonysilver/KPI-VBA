Imports System.Data.SqlClient

Public Class ModifyContentList
    Inherits Filter.Class.BasePage
    Dim useInfo As UserInfo = UserCookieData.GetUserData
    ''Connect to Database to get Data
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    Dim contentService As New ContentService
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idProject") = 0 Then
            Response.Redirect("~/Project")
        End If

        If IsPostBack = False Then
            Session("Task") = ""
            Session("GUID") = ""
            DataDB()
        End If

    End Sub

    Protected Sub DataDB()
        'Drop Down List Level
        Dim IdProject As String = Session("idProject")
        Dim IdTask As String = Request.QueryString("id")
        Dim UserId As String = useInfo.IdUser
        Dim newContent As New KPI_T_Task
        Dim projectId As New KPI_T_Task
        Dim levelList = contentService.ListLevel()
        Dim userList = contentService.ListUser(Session("idProject"))
        If IdProject = 0 Then
            ''Chect Project Id
            projectId.IdProject = 0
            'Direct to Project List
            Response.Redirect("~/Task")
        Else
            ''check IdTask, if id Task = 0 => Show Add form Or else show Edit Form
            If IdTask = 0 Then
                newContent.IdTask = 0
                btnContent.Visible = True
                Session("Task") = Resources.KPI.language.taskHeaderAdd
                Title = "新しい仕事"

                If Session("lang") = "ja" Then
                    For Each item As KPI_M_Level In levelList
                        ddlLevel.Items.Add(New ListItem(item.LevelJP, item.IdLevel))
                    Next
                Else
                    For Each item As KPI_M_Level In levelList
                        ddlLevel.Items.Add(New ListItem(item.Level, item.IdLevel))
                    Next
                End If

                For Each item As KPI_M_User In userList
                    ddlUser.Items.Add(New ListItem(item.FirstName + " " + item.LastName, item.IdUser))
                Next
            Else
                Dim contentObj = contentService.Check(IdTask, IdProject, UserId)
                If contentObj.Count <> 0 Then
                    Session("Task") = Resources.KPI.language.taskHeaderEdit
                    Title = "タスクの編集"
                    'check Content in project include IdTask anh IdProject
                    'Show Edit Form
                    txtContent.Text = contentObj(0).Content.ToString
                    newContent.IdLevel = contentObj(0).IdLevel
                    newContent.IdUser = contentObj(0).IdUser
                    ''Loop show list of Level
                    If Session("lang") = "ja" Then
                        For Each item As KPI_M_Level In levelList
                            If item.IdLevel = contentObj(0).IdLevel Then
                                Dim dropItem As New ListItem(item.LevelJP, item.IdLevel)
                                dropItem.Selected = True
                                ddlLevel.Items.Add(dropItem)
                            Else
                                ddlLevel.Items.Add(New ListItem(item.LevelJP, item.IdLevel))
                            End If
                        Next
                    Else
                        For Each item As KPI_M_Level In levelList
                            If item.IdLevel = contentObj(0).IdLevel Then
                                Dim dropItem As New ListItem(item.Level, item.IdLevel)
                                dropItem.Selected = True
                                ddlLevel.Items.Add(dropItem)
                            Else
                                ddlLevel.Items.Add(New ListItem(item.Level, item.IdLevel))
                            End If
                        Next
                    End If
                    ''List that show User of this Project 
                    For Each item As KPI_M_User In userList
                            If item.IdUser = contentObj(0).IdUser Then
                                Dim dropItem As New ListItem(item.FirstName + " " + item.LastName, item.IdUser)
                                dropItem.Selected = True
                                ddlUser.Items.Add(dropItem)
                            Else
                                ddlUser.Items.Add(New ListItem(item.FirstName + " " + item.LastName, item.IdUser))
                            End If
                        Next

                    Else
                        'If Content doesn't exist in Project
                        'Return back to Project Page
                        Response.Redirect("~/Task")
                    End If
                End If
            End If

    End Sub


    ''Button save Data to DB
    Protected Sub btnContent_Click(sender As Object, e As EventArgs) Handles btnContent.Click

        Dim IdProject As String = Session("idProject")
        Dim IdTask As String = Request.QueryString("id")
        Dim UserId As String = useInfo.IdUser
        Dim content = txtContent.Text
        Dim createAt = DateTime.Now
        Dim updateAt = DateTime.Now
        Dim createBy = useInfo.IdUser
        Dim updateBy = useInfo.IdUser
        Dim objAddContent As New KPI_T_Task
        Dim objUserId As New KPI_T_ProjectUser
        objAddContent.IdTask = IdTask
        objAddContent.Content = content
        objAddContent.IdLevel = ddlLevel.SelectedValue
        objAddContent.IdUser = ddlUser.SelectedValue
        objAddContent.IdProject = IdProject
        objAddContent.CreateAt = createAt
        objAddContent.CreateBy = createBy
        objAddContent.UpdateAt = updateAt
        objAddContent.UpdateBy = updateBy
        objUserId.IdUser = UserId
        Dim ContentService As New ContentService

        If IdTask = 0 Then
            If Session("GUID").ToString() Like txtGuid.Text = False Then
                Session("GUID") = txtGuid.Text
                If String.IsNullOrEmpty(content.ToString) = False Then
                    ContentService.CreateContent(objAddContent)

                    Dim toastr As String = "iziToast.success({
                    title: 'Succeeded',
                    message: '正常に挿入されました!',
                })"
                    Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
                    txtContent.Text = ""
                    ddlLevel.SelectedValue = 0
                    ddlUser.SelectedValue = 0
                End If
            Else
                DataDB()
            End If
        Else
            ContentService.UpdateContent(objAddContent, objUserId)
            Session("notification") = "true"
            Response.Redirect("~/Task")
        End If




    End Sub

    Protected Sub btnTask_Click(sender As Object, e As EventArgs) Handles btnTask.Click
        Dim IdProject As String = Session("idProject")
        Dim IdTask As String = Request.QueryString("id")
        Dim UserId As String = useInfo.IdUser
        Dim content = txtContent.Text
        Dim createAt = DateTime.Now
        Dim createBy = useInfo.IdUser
        Dim updateBy = useInfo.IdUser
        Dim updateAt = DateTime.Now
        Dim objAddContent As New KPI_T_Task
        Dim objUserId As New KPI_T_ProjectUser
        objAddContent.IdTask = IdTask
        objAddContent.Content = content
        objAddContent.IdLevel = ddlLevel.SelectedValue
        objAddContent.IdUser = ddlUser.SelectedValue
        objAddContent.IdProject = IdProject
        objAddContent.CreateAt = createAt
        objAddContent.CreateBy = createBy
        objAddContent.UpdateAt = updateAt
        objAddContent.UpdateBy = updateBy
        objUserId.IdUser = UserId
        Dim ContentService As New ContentService
        If IdTask = 0 Then
            If String.IsNullOrEmpty(content.ToString) = False Then
                ContentService.CreateContent(objAddContent)
                Session("notification") = "true"
                Response.Redirect("~/Task")
            End If
        Else
            ContentService.UpdateContent(objAddContent, objUserId)
            Session("notification") = "true"
            Response.Redirect("~/Task")
        End If
    End Sub
End Class