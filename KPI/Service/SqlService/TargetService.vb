Imports System.Data.SqlClient

Public Class TargetService
    Implements ITagert
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    ''' <summary>
    ''' get namephase bug hour from database 
    ''' </summary>
    ''' <param name="idUser"></param>
    ''' <param name="idProject"></param>
    ''' <param name="Role"></param>
    ''' <returns></returns>
    Public Function GetAnalysisContent(idUser As String, idProject As Integer, Role As String) As List(Of QualityAnalysis) Implements ITagert.GetAnalysisContent
        Dim lstAnalysisContent As New List(Of QualityAnalysis)
        con.Open()
        Try
            Dim cmd = New SqlCommand()
            cmd.CommandText = "SP_GET_ANALYSYSCONTENT @idUser, @idProject, @roleName"
            cmd.CommandType = CommandType.Text
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@idUser", idUser)
            cmd.Parameters.AddWithValue("@idProject", idProject)
            cmd.Parameters.AddWithValue("@roleName", Role)
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
End Class
