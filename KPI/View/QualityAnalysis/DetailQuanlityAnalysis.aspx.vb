Public Class DetailQuanlityAnalysis
    Inherits Filter.Class.BasePage
    Dim targetService As New TargetService()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idProject") = 0 Then
            Response.Redirect("~/Project")
        End If
    End Sub
    Public Function SetData() As TargetInfo
        Dim lstAnalysis = targetService.GetAnalysisContent(UserCookieData.GetUserData.IdUser, Session("idProject"), UserCookieData.GetUserData.RoleName)
        Dim objTarget As New TargetInfo
        Dim intHour As Double = 0
        Dim strCheckIdEditcontent = 0
        Dim countTask = 0
        For Each item As QualityAnalysis In lstAnalysis
            If strCheckIdEditcontent <> item.IdEditContent Then
                countTask = countTask + 1
                intHour = 0
                strCheckIdEditcontent = item.IdEditContent
                For Each i As QualityAnalysis In lstAnalysis
                    If i.IdEditContent = item.IdEditContent Then
                        intHour = intHour + i.Hour
                    End If
                Next
            End If
            If item.NamePhase = "設計" Then
                Try
                    If item.Hour <> 0 Then
                        objTarget.DesignTarget = item.Bug / item.Hour + objTarget.DesignTarget
                    End If
                Catch ex As Exception
                End Try
            End If
            If item.NamePhase = "製造" Then
                Try
                    If item.Hour <> 0 Then
                        objTarget.CodeTarget = item.Bug / item.Hour + objTarget.CodeTarget
                    End If
                Catch ex As Exception

                End Try
            End If
            If item.NamePhase = "テスト" Then
                Try
                    If item.Hour <> 0 Then
                        objTarget.TestTarget = item.Bug / item.Hour + objTarget.TestTarget
                    End If

                Catch ex As Exception

                End Try
            End If
            If item.NamePhase = "BRC内部受入" Then
                Try
                    If intHour <> 0 Then
                        objTarget.AcceptBRCTarget = item.Bug / intHour + objTarget.AcceptBRCTarget
                    End If

                Catch ex As Exception

                End Try
            End If
            If item.NamePhase = "OSC様受入" Then
                Try
                    If intHour <> 0 Then
                        objTarget.AcceptOSCTarget = item.Bug / intHour + objTarget.AcceptOSCTarget
                    End If

                Catch ex As Exception

                End Try
            End If
            If item.NamePhase = "業務側受入(リリース後含む" Then
                Try
                    If intHour <> 0 Then
                        objTarget.AcceptProfessionTarget = item.Bug / intHour + objTarget.AcceptProfessionTarget
                    End If
                Catch ex As Exception

                End Try
            End If
        Next
        objTarget.AcceptBRCTarget = objTarget.AcceptBRCTarget / countTask
        objTarget.AcceptOSCTarget = objTarget.AcceptOSCTarget / countTask
        objTarget.AcceptProfessionTarget = objTarget.AcceptProfessionTarget / countTask
        objTarget.CodeTarget = objTarget.CodeTarget / countTask
        objTarget.DesignTarget = objTarget.DesignTarget / countTask
        objTarget.TestTarget = objTarget.TestTarget / countTask
        Return objTarget
    End Function
End Class