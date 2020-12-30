Imports System.Data.SqlClient


Public Class ErrorAnalysisService
    Implements IErrorAnalysis
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    Dim cmd = New SqlCommand()
    Public Function GetContentErrorType(ContentErrorType As KPI_T_ErrorAnalysis) As KPI_T_ErrorAnalysis Implements IErrorAnalysis.GetContentErrorType
        Throw New NotImplementedException()
    End Function

    Public Function GetContentErrorTypeList(IdTask As String, PageNumber As Integer, PageSize As Integer, search As String, sortColumn As String, sortOrder As String, IdUser As String) As List(Of ErrorAnalysisInfo) Implements IErrorAnalysis.GetContentErrorTypeList
        Dim data As New List(Of ErrorAnalysisInfo)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_GETLIST_ERRORANALYSIS @IdTask,@PageNumber,@PageSize,@search,@sortColumn,@sortOrder, @IdUser"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@IdTask", IdTask)
        cmd.Parameters.AddWithValue("@PageNumber", PageNumber)
        cmd.Parameters.AddWithValue("@PageSize", PageSize)
        cmd.Parameters.AddWithValue("@search", search)
        cmd.Parameters.AddWithValue("@sortColumn", sortColumn)
        cmd.Parameters.AddWithValue("@sortOrder", sortOrder)
        cmd.Parameters.AddWithValue("@IdUser", IdUser)
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim ErrorAnalysisObj As New ErrorAnalysisInfo
            ErrorAnalysisObj.IdErrorAnalysis = dbReader("IdErrorAnalysis").ToString
            ErrorAnalysisObj.NameError = dbReader("NameError").ToString
            ErrorAnalysisObj.NameErrorJP = dbReader("NameErrorJP").ToString
            'ErrorAnalysisObj.IdUser = dbReader("IdUser").ToString
            'ErrorAnalysisObj.IdPhase = dbReader("IdPhase").ToString
            ErrorAnalysisObj.NamePhase = dbReader("NamePhase").ToString
            ErrorAnalysisObj.NamePhaseJP = dbReader("NamePhaseJP").ToString
            ErrorAnalysisObj.Bug = dbReader("Bug").ToString
            ErrorAnalysisObj.Reference = dbReader("Reference").ToString
            ErrorAnalysisObj.Rownum = dbReader("rownum").ToString
            ErrorAnalysisObj.IdTask = dbReader("IdTask").ToString
            'ErrorAnalysisObj.CreateAt = dbReader("CreateAt").ToString
            data.Add(ErrorAnalysisObj)
        Loop
        con.Close()
        Return data
    End Function

    Public Function DeleteContentErrorType(id As Integer) As Boolean Implements IErrorAnalysis.DeleteContentErrorType
        Dim rowAffected As Integer = 0
        con.Open()
        cmd.CommandText = "UPDATE [KPI_T_ErrorAnalysis] SET Deleted = 1, Bug = 0 WHERE IdErrorAnalysis=@IdErrorAnalysis SELECT @@IDENTITY"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@IdErrorAnalysis", id))
        rowAffected = Int(cmd.ExecuteNonQuery())
        con.Close()
        Return rowAffected
    End Function

    Public Function UpdateContentErrorType(ContentErrorType As ErrorAnalysisInfo, IdUser As KPI_T_ProjectUser) As ErrorAnalysisInfo Implements IErrorAnalysis.UpdateContentErrorType
        con.Open()
        cmd.CommandText = "SP_UPDATE_ERRORANALYSIS @Bug,@Reference,@IdError,@idPhase,@idTask, @IdErrorAnalysis, @IdUsers"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@idTask", ContentErrorType.IdTask))
        cmd.Parameters.Add(New SqlParameter("@Bug", ContentErrorType.Bug))
        cmd.Parameters.Add(New SqlParameter("@Reference", ContentErrorType.Reference))
        cmd.Parameters.Add(New SqlParameter("@idPhase", ContentErrorType.IdPhase))
        cmd.Parameters.Add(New SqlParameter("@IdQualityAnalysis", ContentErrorType.IdQualityAnalysis))
        cmd.Parameters.Add(New SqlParameter("@IdErrorAnalysis", ContentErrorType.IdErrorAnalysis))
        cmd.Parameters.Add(New SqlParameter("@IdError", ContentErrorType.IdError))
        cmd.Parameters.Add(New SqlParameter("@IdUsers", IdUser.IdUser))
        cmd.ExecuteScalar()
        con.Close()
        Return ContentErrorType
    End Function

    Public Function CreateContentErrorType(ContentErrorType As ErrorAnalysisInfo) As ErrorAnalysisInfo Implements IErrorAnalysis.CreateContentErrorType
        con.Open()
        cmd.CommandText = "SP_INSERT_ERRORANALYSIS @Bug,@Reference,@IdError,@idPhase,@CreateAt,@idTask"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@Bug", ContentErrorType.Bug))
        cmd.Parameters.Add(New SqlParameter("@Reference", ContentErrorType.Reference))
        cmd.Parameters.Add(New SqlParameter("@IdError", ContentErrorType.IdError))
        cmd.Parameters.Add(New SqlParameter("@IdQualityAnalysis", ContentErrorType.IdQualityAnalysis))
        cmd.Parameters.Add(New SqlParameter("@idTask", ContentErrorType.IdTask))
        cmd.Parameters.Add(New SqlParameter("@idPhase", ContentErrorType.IdPhase))
        cmd.Parameters.Add(New SqlParameter("@CreateAt", ContentErrorType.CreateAt))
        cmd.ExecuteScalar()
        con.Close()
        Return ContentErrorType
    End Function

    Public Function ListError() As List(Of KPI_M_Error)
        Dim data As New List(Of KPI_M_Error)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SELECT IdError, NameError, NameErrorJP FROM KPI_T_Error"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim ErrorObj As New KPI_M_Error
            ErrorObj.IdError = dbReader("IdError").ToString
            ErrorObj.NameError = dbReader("NameError").ToString
            ErrorObj.NameErrorJP = dbReader("NameErrorJP").ToString
            data.Add(ErrorObj)
        Loop
        con.Close()
        Return data
    End Function

    Public Function ListErrorType() As List(Of KPI_M_ErrorType)
        Dim data As New List(Of KPI_M_ErrorType)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SELECT IdErrorType, NameErrorType FROM KPI_M_ErrorType"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim ErrorTypeObj As New KPI_M_ErrorType
            ErrorTypeObj.IdErrorType = dbReader("IdErrorType").ToString
            ErrorTypeObj.NameErrorType = dbReader("NameErrorType").ToString
            data.Add(ErrorTypeObj)
        Loop
        con.Close()
        Return data
    End Function

    Public Function ListPhase() As List(Of KPI_M_Phase)
        Dim data As New List(Of KPI_M_Phase)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SELECT IdPhase, NamePhase, NamePhaseJP FROM KPI_M_Phase"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim phaseObj As New KPI_M_Phase
            phaseObj.IdPhase = dbReader("IdPhase").ToString
            phaseObj.NamePhase = dbReader("NamePhase").ToString
            phaseObj.NamePhaseJP = dbReader("NamePhaseJP").ToString
            data.Add(phaseObj)
        Loop
        con.Close()
        Return data
    End Function

    Public Function ListTask(IdProject As Integer) As List(Of KPI_T_Task)
        Dim data As New List(Of KPI_T_Task)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_TASKLIST @IdProject"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@IdProject", IdProject))
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim taskObj As New KPI_T_Task
            taskObj.IdTask = dbReader("IdTask").ToString
            taskObj.Content = dbReader("Content").ToString
            data.Add(taskObj)
        Loop
        con.Close()
        Return data
    End Function

    Public Function Check(IdErrorAnalysis As Integer, IdUser As String) As List(Of ErrorAnalysisInfo)
        Dim content As New List(Of ErrorAnalysisInfo)
        con.Open()
        cmd.CommandText = "SP_CHECK_ERRORANALYSIS @IdErrorAnalysis ,@UserIds"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@IdErrorAnalysis", IdErrorAnalysis)
        cmd.Parameters.AddWithValue("@UserIds", IdUser)
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim ErrorAnalysisobj As New ErrorAnalysisInfo
            ErrorAnalysisobj.IdErrorAnalysis = dbReader("IdErrorAnalysis").ToString
            ErrorAnalysisobj.Bug = dbReader("Bug").ToString
            ErrorAnalysisobj.Reference = dbReader("Reference").ToString
            ErrorAnalysisobj.IdQualityAnalysis = dbReader("IdQualityAnalysis").ToString
            ErrorAnalysisobj.IdError = dbReader("IdError").ToString
            ErrorAnalysisobj.IdPhase = dbReader("IdPhase").ToString
            content.Add(ErrorAnalysisobj)
        Loop
        con.Close()
        Return content
    End Function

    Public Function GetCount(IdQualityAnalysis As Integer, search As String, IdUser As String) As Integer
        Dim intCountRecord As Integer
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_GET_COUNT_ERRORANALYSIS @IdQualityAnalysis, @search, @UserId"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Parameters.AddWithValue("@IdQualityAnalysis", IdQualityAnalysis)
        cmd.Parameters.AddWithValue("@search", search)
        cmd.Parameters.AddWithValue("@UserId", IdUser)
        cmd.Connection = con
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        dbReader.Read()
        intCountRecord = dbReader("Count").ToString
        con.Close()
        Return intCountRecord
    End Function
End Class
