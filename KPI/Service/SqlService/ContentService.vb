Imports System.Data.SqlClient
Imports System.Web.Services

Public Class ContentService
    Implements IContent
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    Dim cmd = New SqlCommand()
    Public Function GetContent(Content As KPI_T_Task) As KPI_T_Task Implements IContent.GetContent
        Throw New NotImplementedException()
    End Function

    Public Function GetProject(ByVal idProject As String) As KPI_M_Project
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SELECT * FROM KPI_M_Project WHERE IdProject=@IdProject"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@IdProject", idProject)
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Dim projectObj As New KPI_M_Project
        Do While dbReader.Read()
            projectObj.IdProject = dbReader("IdProject").ToString
            projectObj.NameProject = dbReader("NameProject").ToString
        Loop
        con.Close()
        Return projectObj
    End Function

    Public Function GetContentList(IdProject As String, PageNumber As Integer, PageSize As Integer, search As String, sortColumn As String, sortOrder As String, idUser As String) As List(Of KPI_T_Task) Implements IContent.GetContentList
        Dim data As New List(Of KPI_T_Task)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_GET_TASKLIST @IdProject,@PageNumber,@PageSize,@search,@sortColumn,@sortOrder,@idUser"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@IdProject", IdProject)
        cmd.Parameters.AddWithValue("@PageNumber", PageNumber)
        cmd.Parameters.AddWithValue("@PageSize", PageSize)
        cmd.Parameters.AddWithValue("@search", search)
        cmd.Parameters.AddWithValue("@sortColumn", sortColumn)
        cmd.Parameters.AddWithValue("@sortOrder", sortOrder)
        cmd.Parameters.AddWithValue("@idUser", idUser)
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim Taskobj As New KPI_T_Task
            Taskobj.IdTask = dbReader("IdTask").ToString
            Taskobj.Content = dbReader("Content").ToString
            Taskobj.FirstName = dbReader("FirstName").ToString
            Taskobj.LastName = dbReader("LastName").ToString
            Taskobj.IdLevel = dbReader("IdLevel").ToString
            Taskobj.Level = dbReader("Level").ToString
            Taskobj.LevelJP = dbReader("LevelJP").ToString
            Taskobj.CreateAt = dbReader("CreateAt").ToString
            Taskobj.RowNum = dbReader("rownum").ToString
            Taskobj.NameProject = dbReader("NameProject").ToString
            data.Add(Taskobj)
        Loop
        con.Close()
        Return data
    End Function


    Public Function DeleteContent(id As Integer) As Boolean Implements IContent.DeleteContent
        Dim rowAffected As Integer = 0
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "UPDATE [KPI_T_Task] SET Deleted = 1 WHERE IdTask=@IdTask SELECT @@IDENTITY"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@IdTask", id))
        rowAffected = Int(cmd.ExecuteNonQuery())
        con.Close()
        Return rowAffected
    End Function

    Public Function UpdateContent(Task As KPI_T_Task, UserId As KPI_T_ProjectUser) As KPI_T_Task Implements IContent.UpdateContent
        con.Open()
        cmd.CommandText = "SP_UPDATE_TASKLIST @Content, @IdLevel, @IdUser,@IdTask,@UserId,@UpdateAt,@UpdateBy"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@IdTask", Task.IdTask))
        cmd.Parameters.Add(New SqlParameter("@Content", Task.Content))
        cmd.Parameters.Add(New SqlParameter("@IdLevel", Task.IdLevel))
        cmd.Parameters.Add(New SqlParameter("@IdUser", Task.IdUser))
        cmd.Parameters.Add(New SqlParameter("@UserId", UserId.IdUser))
        cmd.Parameters.Add(New SqlParameter("@UpdateAt", Task.UpdateAt))
        cmd.Parameters.Add(New SqlParameter("@UpdateBy", UserId.IdUser))
        cmd.ExecuteScalar()
        con.Close()
        Return Task
    End Function

    Public Function CreateContent(Task As KPI_T_Task) As KPI_T_Task Implements IContent.CreateContent
        con.Open()
        cmd.CommandText = "SP_INSERT_TASK @Content,@IdProject,@IdUser,@IdLevel,@CreateAt,@IdTask,@CreateBy"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@IdTask", Task.IdTask))
        cmd.Parameters.Add(New SqlParameter("@Content", Task.Content))
        cmd.Parameters.Add(New SqlParameter("@IdProject", Task.IdProject))
        cmd.Parameters.Add(New SqlParameter("@IdLevel", Task.IdLevel))
        cmd.Parameters.Add(New SqlParameter("@IdUser", Task.IdUser))
        cmd.Parameters.Add(New SqlParameter("@CreateAt", Task.CreateAt))
        cmd.Parameters.Add(New SqlParameter("@CreateBy", Task.CreateBy))
        cmd.ExecuteScalar()
        con.Close()
        Return Task
    End Function

    Public Function ListLevel() As List(Of KPI_M_Level)
        Dim data As New List(Of KPI_M_Level)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SELECT * FROM KPI_M_Level"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim LevelObj As New KPI_M_Level
            LevelObj.IdLevel = dbReader("IdLevel").ToString
            LevelObj.Level = dbReader("Level").ToString
            LevelObj.LevelJP = dbReader("LevelJP").ToString
            data.Add(LevelObj)
        Loop
        con.Close()
        Return data
    End Function

    Public Function ListUser(IdProject As Integer) As List(Of KPI_M_User)
        Dim data As New List(Of KPI_M_User)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_DDL_User @IdProject"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.Add(New SqlParameter("@IdProject", IdProject))
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim UserObj As New KPI_M_User
            UserObj.IdUser = dbReader("IdUser").ToString
            UserObj.FirstName = dbReader("FirstName").ToString
            UserObj.LastName = dbReader("LastName").ToString
            UserObj.IdProject = dbReader("IdProject").ToString
            data.Add(UserObj)
        Loop
        con.Close()
        Return data
    End Function

    Public Function Check(IdTask As Integer, IdProject As Integer, UserId As String) As List(Of KPI_T_Task)
        Dim content As New List(Of KPI_T_Task)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_CHECK_TASK @IdTask, @Projectid, @UserIds"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@IdTask", IdTask)
        cmd.Parameters.AddWithValue("@Projectid", IdProject)
        cmd.Parameters.AddWithValue("@UserIds", UserId)
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim Taskobj As New KPI_T_Task
            Taskobj.IdTask = dbReader("IdTask").ToString
            Taskobj.Content = dbReader("Content").ToString
            Taskobj.IdProject = dbReader("IdProject").ToString
            Taskobj.IdUser = dbReader("IdUser").ToString
            Taskobj.IdLevel = dbReader("IdLevel").ToString
            content.Add(Taskobj)
        Loop
        con.Close()
        Return content
    End Function

    Public Function GetCount(IdProject As Integer, search As String, IdUsers As String) As Integer
        Dim intCountRecord As Integer
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_GET_COUNT_TASK @IdProject, @search, @IdUsers"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@IdProject", IdProject)
        cmd.Parameters.AddWithValue("@search", search)
        cmd.Parameters.AddWithValue("@IdUsers", IdUsers)
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        dbReader.Read()
        intCountRecord = dbReader("Count").ToString
        con.Close()
        Return intCountRecord
    End Function

    Public Function GetErrorAnalysis(rownum As Integer, IdUser As String)
        Dim data As New List(Of ErrorAnalysisInfo)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_LISTCSV_ERRORANALYSIS @RowNum, @IdUserss"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@RowNum", rownum)
        cmd.Parameters.AddWithValue("@IdUserss", IdUser)
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim Taskobj As New ErrorAnalysisInfo
            Taskobj.IdErrorAnalysis = dbReader("IdErrorAnalysis").ToString
            Taskobj.Content = dbReader("Content").ToString
            Taskobj.FirstName = dbReader("FirstName").ToString
            Taskobj.LastName = dbReader("LastName").ToString
            Taskobj.NamePhase = dbReader("NamePhase").ToString
            Taskobj.NamePhaseJP = dbReader("NamePhaseJP").ToString
            Taskobj.NameError = dbReader("NameError").ToString
            Taskobj.NameErrorJP = dbReader("NameErrorJP").ToString
            Taskobj.Bug = dbReader("Bug").ToString
            Taskobj.Reference = dbReader("Reference").ToString
            Taskobj.Rownum = dbReader("rownum").ToString
            data.Add(Taskobj)
        Loop
        con.Close()
        Return data
    End Function
End Class