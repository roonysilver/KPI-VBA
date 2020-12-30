Public Class Input
    Inherits Filter.Class.BasePage
    Dim dpmService As New DepartmentService
    Dim projectService As New ProjectService
    Dim plService As New DepartmentService
    Dim users As KPI.UserInfo = KPI.UserCookieData.GetUserData()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim idUser = users.IdUser
            'Response.Cookies("demo").Expires = DateTime.Now.AddDays(1)
            'Dim demo = Request.Cookies("demo").Value
            Dim idProject = Session("idProject")
            If idProject <> 0 Then
                lblTitle.Text = Resources.KPI.language.carHeaderEditProject
                LoadData(idProject, idUser)
            Else
                idProject = 0
                lblTitle.Text = Resources.KPI.language.carHeaderAddProject
                LoadPL("")
                'LoadUser()
                LoadDpm(idProject)
            End If
        End If
    End Sub
    Sub LoadData(idProject As Integer, idUser As String)
        Dim data = projectService.GetProject(idUser, idProject)
        txtDuAn.Text = data.NameProject
        LoadDpm(data.IdDepartment)
        LoadPL(data.IdUser)
        'LoadUser()
    End Sub
    Sub LoadDpm(idDpm As Integer)
        ddlBoPhan.DataTextField = "NameDepartment"
        ddlBoPhan.DataValueField = "IdDepartment"
        ddlBoPhan.DataSource = dpmService.ListDpm
        If idDpm <> 0 Then
            ddlBoPhan.SelectedValue = idDpm
        End If
        ddlBoPhan.DataBind()
    End Sub
    Sub LoadPL(idUser As String)
        dllPL.DataTextField = "FullName"
        dllPL.DataValueField = "IdUser"
        dllPL.DataSource = dpmService.ListPL(Session("idProject"))
        If idUser <> "" Then
            dllPL.SelectedValue = idUser
        End If
        dllPL.DataBind()
    End Sub
    'Sub LoadUser()
    '    Dim idUser = projectService.GetMemberProject(Request.QueryString("id"))
    '    If idUser.Count <> 0 Then
    '        For Each item In idUser
    '            lstMember.SelectedValue = item.IdMember
    '        Next
    '        lstMember.DataBind()
    '    End If
    'End Sub
    Protected Sub btnSub_Click(sender As Object, e As EventArgs) Handles btnSub.Click
        Dim idProject = Session("idProject")
        Dim nameProject = txtDuAn.Text.Trim()
        Dim department = ddlBoPhan.SelectedValue
        Dim pl = dllPL.SelectedValue
        Dim project = New ProjectInfo
        project.IdProject = idProject
        project.IdUser = users.IdUser
        project.IdDepartment = department
        project.IdPL = pl
        project.NameProject = nameProject
        If idProject <> 0 Then
            projectService.UpdateProject(project)
            Dim lstIdMember = txtListMember.Text.Split(",")
            For Each item In lstIdMember
                projectService.AddMember(idProject, item)
            Next
        Else
            Dim idProjectAdd = projectService.AddProject(project)
            Dim lstIdMember = txtListMember.Text.Split(",")
            For Each item In lstIdMember
                projectService.AddMember(idProjectAdd, item)
            Next

        End If
        Session("idProject") = 0
        Response.Redirect("~/Project")
    End Sub

    Protected Sub btnCancle_Click(sender As Object, e As EventArgs) Handles btnCancle.Click
        Session("idProject") = 0
        Response.Redirect("~/Project")
    End Sub
End Class