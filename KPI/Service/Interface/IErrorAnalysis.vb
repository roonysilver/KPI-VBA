Public Interface IErrorAnalysis
    Function GetContentErrorType(ByVal ContentErrorType As KPI_T_ErrorAnalysis) As KPI_T_ErrorAnalysis
    Function GetContentErrorTypeList(IdTask As String, PageNumber As Integer, PageSize As Integer, search As String, sortColumn As String, sortOrder As String, IdUser As String) As List(Of ErrorAnalysisInfo)
    Function DeleteContentErrorType(id As Integer) As Boolean
    Function UpdateContentErrorType(ContentErrorType As ErrorAnalysisInfo, IdUser As KPI_T_ProjectUser) As ErrorAnalysisInfo
    Function CreateContentErrorType(ContentErrorType As ErrorAnalysisInfo) As ErrorAnalysisInfo
End Interface
