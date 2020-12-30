Imports System.Data.SqlClient

Public Class ProjectService
    Implements IProject
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    Public Function GetListProject(idUser As String, roleName As String, pageSize As Integer, curentPage As Integer, Optional ByVal search As String = "") As List(Of ProjectInfo) Implements IProject.GetListProject
        Dim lstProject As New List(Of ProjectInfo)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_SELECT_PROJECT @idUser, @roleName,@pageSize,@curentPage,@search"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@idUser", idUser)
        cmd.Parameters.AddWithValue("@pageSize", pageSize)
        cmd.Parameters.AddWithValue("@curentPage", curentPage)
        cmd.Parameters.AddWithValue("@search", search)
        cmd.Parameters.AddWithValue("@roleName", roleName)
        Dim dbReader As SqlDataReader
        dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim objProject As New ProjectInfo
            objProject.NameDepartment = dbReader("NameDepartment").ToString
            objProject.NameProject = dbReader("NameProject").ToString
            objProject.NameUser = dbReader("FirstName").ToString + " " + dbReader("LastName").ToString
            objProject.IdProject = dbReader("IdProject").ToString
            lstProject.Add(objProject)
        Loop
        con.Close()
        Return lstProject
    End Function

    Public Function GetProject(idUser As String, idProject As Integer) As ProjectInfo Implements IProject.GetProject
        Dim project As ProjectInfo = Nothing
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_GET_PROJECT @idProject,@idUser"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@idProject", idProject)
        cmd.Parameters.AddWithValue("@idUser", idUser)
        Dim dbReader As SqlDataReader
        dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim objProject As New ProjectInfo
            objProject.NameDepartment = dbReader("NameDepartment").ToString
            objProject.IdDepartment = dbReader("IdDerpartment").ToString
            objProject.IdUser = dbReader("IdUser").ToString
            objProject.NameProject = dbReader("NameProject").ToString
            objProject.NameUser = dbReader("FirstName").ToString + " " + dbReader("LastName").ToString
            project = objProject
        Loop
        con.Close()
        Return project
    End Function

    Public Function DeleteProject(idProject As Integer) As Boolean Implements IProject.DeleteProject
        Dim count As Integer = 0
        con.Open()
        Dim cmd As New SqlCommand("dbo.SP_DELETE_PROJECT @idProject", con)
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@idProject", idProject)
        count = Convert.ToInt32(cmd.ExecuteNonQuery())
        con.Close()
        Return count > 0
    End Function

    Public Function UpdateProject(Project As ProjectInfo) As Boolean Implements IProject.UpdateProject
        Dim count As Integer = 0
        con.Open()
        Dim cmd As New SqlCommand("dbo.SP_UPDATE_PROJECT @idProject, @idUser, @idDepartment, @idPL, @nameProject", con)
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@idProject", Project.IdProject.ToString)
        cmd.Parameters.AddWithValue("@idUser", Project.IdUser.ToString)
        cmd.Parameters.AddWithValue("@idDepartment", Project.IdDepartment.ToString)
        cmd.Parameters.AddWithValue("@idPL", Project.IdPL.ToString)
        cmd.Parameters.AddWithValue("@nameProject", Project.NameProject.ToString)
        count = Convert.ToInt32(cmd.ExecuteNonQuery())
        con.Close()
        Return count > 0
    End Function

    Public Function AddProject(Project As ProjectInfo) As Integer Implements IProject.AddProject
        Dim idProject As Integer = 0
        con.Open()
        Dim cmd As New SqlCommand("dbo.SP_INSERT_PROJECT @idUser,@idDepartment,@idPL,@nameProject", con)
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@idUser", Project.IdUser)
        cmd.Parameters.AddWithValue("@idDepartment", Project.IdDepartment)
        cmd.Parameters.AddWithValue("@nameProject", Project.NameProject)
        cmd.Parameters.AddWithValue("@idPL", Project.IdPL)
        idProject = Convert.ToInt32(cmd.ExecuteScalar())
        con.Close()
        Return idProject
    End Function
    Public Function AddMember(ByVal idProject As Integer, ByVal idMember As String) As Integer Implements IProject.AddMember
        Dim count As Integer = 0
        con.Open()
        Dim cmd As New SqlCommand("dbo.SP_INSERT_MEMBER @idmember,@idProject", con)
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@idProject", idProject)
        cmd.Parameters.AddWithValue("@idmember", idMember)
        count = Convert.ToInt32(cmd.ExecuteScalar())
        con.Close()
        Return count
    End Function

    Public Function GetMemberProject(idProject As Integer) As List(Of ProjectInfo) Implements IProject.GetMemberProject
        Dim lstMember As New List(Of ProjectInfo)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_GET_MEMBER_PROJECT @idProject"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@idProject", idProject)
        Dim dbReader As SqlDataReader
        dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim objProjectInfo As New ProjectInfo
            objProjectInfo.NameMember = dbReader("Member").ToString()
            objProjectInfo.IdMember = dbReader("idUser").ToString()
            lstMember.Add(objProjectInfo)
        Loop
        con.Close()
        Return lstMember
    End Function

    Public Function GetProjectForRole(idUser As String, roleName As String) As KPI_T_ProjectUser Implements IProject.GetProjectForRole
        Dim objProjectUser As New KPI_T_ProjectUser
        Try
            con.Open()
            Dim cmd = New SqlCommand()
            cmd.CommandText = "SP_GET_PROJECT_FOR_ROLE @idUser, @roleName"
            cmd.CommandType = CommandType.Text
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@idUser", idUser)
            cmd.Parameters.AddWithValue("@roleName", roleName)
            Dim dbReader As SqlDataReader
            dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            dbReader.Read()
            objProjectUser.IdProject = dbReader("IdProject").ToString()
            con.Close()
            Return objProjectUser
        Catch ex As Exception
            objProjectUser = Nothing
            Return objProjectUser
        End Try
    End Function

    Public Function GetCountProject(idUser As String, rolename As String, search As String) As Integer Implements IProject.GetCountProject
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_GET_COUNT_PROJECT @idUser,@rolename,@search"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@idUser", idUser)
        cmd.Parameters.AddWithValue("@rolename", rolename)
        cmd.Parameters.AddWithValue("@search", search)
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        dbReader.Read()
        Dim count As Integer = 0
        count = dbReader("Count").ToString
        con.Close()
        Return count
    End Function
End Class
