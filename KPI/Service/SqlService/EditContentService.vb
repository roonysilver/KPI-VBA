Imports System.Data.SqlClient

Public Class EditContentService
    Implements IEditContent
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    ''' <summary>
    ''' get info task
    ''' </summary>
    ''' <param name="page"></param>
    ''' <param name="pageSize"></param>
    ''' <param name="sortColumn"></param>
    ''' <param name="search"></param>
    ''' <param name="sortOrder"></param>
    ''' <param name="role"></param>
    ''' <param name="idUser"></param>
    ''' <param name="idProject"></param>
    ''' <returns>list info task</returns>
    Public Function GetEditContent(ByVal page As Integer, ByVal pageSize As Integer, ByVal sortColumn As String, ByVal search As String, ByVal sortOrder As String, ByVal role As String, ByVal idUser As String, ByVal idProject As Integer) As List(Of EditContentInfo) Implements IEditContent.GetEditContent
        Dim lstEditContent As New List(Of EditContentInfo)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_GET_LIST_EDIT_CONTENT @page,@pageSize,@sortColumn,@sortOrder,@search,@role,@idUser,@idProject"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@page", page)
        cmd.Parameters.AddWithValue("@pageSize", pageSize)
        cmd.Parameters.AddWithValue("@sortColumn", sortColumn)
        cmd.Parameters.AddWithValue("@sortOrder", sortOrder)
        cmd.Parameters.AddWithValue("@search", search)
        cmd.Parameters.AddWithValue("@role", role)
        cmd.Parameters.AddWithValue("@idUser", idUser)
        cmd.Parameters.AddWithValue("@idProject", idProject)
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim objEditContent As New EditContentInfo
            objEditContent.Content = dbReader("Content").ToString
            objEditContent.FullName = dbReader("FirstName").ToString + " " + dbReader("LastName").ToString
            objEditContent.Reason = dbReader("Reason").ToString
            objEditContent.Level = dbReader("Level").ToString
            objEditContent.RowNumber = dbReader("RowNumber").ToString
            objEditContent.IdTask = dbReader("IdTask").ToString
            objEditContent.Levelja = dbReader("LevelJP").ToString
            lstEditContent.Add(objEditContent)
        Loop
        con.Close()
        Return lstEditContent
    End Function
    ''' <summary>
    ''' get number count record task
    ''' </summary>
    ''' <param name="search"></param>
    ''' <param name="role"></param>
    ''' <param name="idUser"></param>
    ''' <param name="idProject"></param>
    ''' <returns>number count record task</returns>
    Public Function GetCountEditContent(search As String, role As String, idUser As String, idProject As Integer) As Integer Implements IEditContent.GetCountEditContent
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_COUNT_EDIT_CONTENT @search,@role,@idUser,@idProject"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@search", search)
        cmd.Parameters.AddWithValue("@role", role)
        cmd.Parameters.AddWithValue("@idUser", idUser)
        cmd.Parameters.AddWithValue("@idProject", idProject)
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        dbReader.Read()
        Dim intCountRecord As Integer = 0
        intCountRecord = dbReader("Count").ToString
        con.Close()
        Return intCountRecord
    End Function
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="idUser"></param>
    ''' <param name="idProject"></param>
    ''' <param name="idTask"></param>
    ''' <param name="role"></param>
    ''' <returns></returns>
    Public Function GetListAnalysisContent(idUser As String, idProject As Integer, idTask As Integer, role As String) As List(Of QualityAnalysis) Implements IEditContent.GetListAnalysisContent
        Dim lstAnalysisContent As New List(Of QualityAnalysis)
        con.Open()
        Try
            Dim cmd = New SqlCommand()
            cmd.CommandText = "SP_GET_ANALYSYSCONTENT_WITH_IDEDITCONTENT @idUser, @role, @idProject, @idTask"
            cmd.CommandType = CommandType.Text
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@idUser", idUser)
            cmd.Parameters.AddWithValue("@role", role)
            cmd.Parameters.AddWithValue("@idProject", idProject)
            cmd.Parameters.AddWithValue("@idTask", idTask)
            Dim dbReader As SqlDataReader
            dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            Do While dbReader.Read()
                Dim objAnalysisContent As New QualityAnalysis
                objAnalysisContent.NamePhase = dbReader("NamePhase").ToString
                Try
                    objAnalysisContent.Bug = dbReader("Bug").ToString
                Catch ex As Exception
                    objAnalysisContent.Bug = 0
                End Try
                objAnalysisContent.Hour = dbReader("Hour").ToString
                objAnalysisContent.IdEditContent = dbReader("IdTask").ToString
                lstAnalysisContent.Add(objAnalysisContent)
            Loop
            con.Close()
            Return lstAnalysisContent
        Catch ex As Exception
            con.Close()
            Dim objAnalysisContent As New List(Of QualityAnalysis)
            Return objAnalysisContent
        End Try
    End Function
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="idUser"></param>
    ''' <param name="role"></param>
    ''' <param name="idProject"></param>
    ''' <param name="idTask"></param>
    ''' <param name="hourDesign"></param>
    ''' <param name="hourCode"></param>
    ''' <param name="hourTest"></param>
    ''' <param name="Reason"></param>
    ''' <returns></returns>
    Public Function UpdateReasonHour(idUser As String, role As String, idProject As Integer, idTask As Integer, hourDesign As String, hourCode As String, hourTest As String, Reason As String) As Boolean Implements IEditContent.UpdateReasonHour
        Try
            con.Open()
            Dim cmd = New SqlCommand()
            cmd.CommandText = "UPDATE_REASON_AND_HOUR @idUser, @role,@idProject,@idTask,@hourDesign,@hourCode,@hourTest,@Reason"
            cmd.CommandType = System.Data.CommandType.Text
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@idUser", idUser)
            cmd.Parameters.AddWithValue("@role", role)
            cmd.Parameters.AddWithValue("@idProject", idProject)
            cmd.Parameters.AddWithValue("@idTask", idTask)
            cmd.Parameters.AddWithValue("@hourDesign", hourDesign)
            cmd.Parameters.AddWithValue("@hourCode", hourCode)
            cmd.Parameters.AddWithValue("@hourTest", hourTest)
            cmd.Parameters.AddWithValue("@Reason", Reason)
            cmd.ExecuteScalar()
            con.Close()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="idTask"></param>
    ''' <param name="role"></param>
    ''' <param name="idUser"></param>
    ''' <param name="idProject"></param>
    ''' <returns></returns>
    Public Function GetReasonOfTask(idTask As Integer, role As String, idUser As String, idProject As Integer) As KPI_T_Task Implements IEditContent.GetReasonOfTask
        Dim objAnalysisContent As New KPI_T_Task
        con.Open()
        Try
            Dim cmd = New SqlCommand()
            cmd.CommandText = "GET_REASON_OF_TASK @idUser, @role, @idProject, @idTask"
            cmd.CommandType = CommandType.Text
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@idUser", idUser)
            cmd.Parameters.AddWithValue("@role", role)
            cmd.Parameters.AddWithValue("@idProject", idProject)
            cmd.Parameters.AddWithValue("@idTask", idTask)
            Dim dbReader As SqlDataReader
            dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            dbReader.Read()
            objAnalysisContent.Reason = dbReader("Reason").ToString
            con.Close()
            Return objAnalysisContent
        Catch ex As Exception
            con.Close()
            Return objAnalysisContent
        End Try
    End Function
End Class
