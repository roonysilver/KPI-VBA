Public Interface IPhaseAnalysis
    Function GetPhaseAnalysis(ByVal Project As KPI_M_Project) As KPI_M_Project
    Function GetProjectList() As List(Of KPI_M_Project)
    Function DeleteProject(id As Integer) As Boolean
    Function UpdateProject(Project As KPI_M_Project) As KPI_M_Project
    Function CreateProject(Project As KPI_M_Project) As KPI_M_Project
End Interface
