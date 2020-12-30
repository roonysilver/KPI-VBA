Public Interface ITagert
    Function GetAnalysisContent(ByVal idUser As String, ByVal idProject As Integer, ByVal roleName As String) As List(Of QualityAnalysis)
End Interface
