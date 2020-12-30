CREATE PROC SP_GET_USER
@password NVARCHAR(50),
@username NVARCHAR(50)
AS
BEGIN
	DECLARE @passwordMd5 NVARCHAR(50)
	SET @passwordMd5=CONVERT(VARCHAR(32), HashBytes('MD5', @password), 2)
	SELECT * FROM KPI_M_User JOIN KPI_M_Role ON KPI_M_User.IdRole=KPI_M_Role.IdRole WHERE KPI_M_User.Password=@passwordMd5 AND KPI_M_User.Username=@username
END
SP_GET_USER '123456','donle'
-----UPDATE_LOCK_USER----
CREATE PROC SP_UPDATE_LOCK_USER
@CountFail INT,
@Username NVARCHAR(50)
AS
BEGIN
	UPDATE KPI_M_User
	SET LoginFail=@CountFail
	WHERE Username=@Username
END
SP_UPDATE_LOCK_USER 1,'donle'
----GET_LOCK_USER---------
CREATE PROC SP_GET_LOCK_USER
@Username NVARCHAR(50)
AS
BEGIN
	SELECT LoginFail FROM KPI_M_User WHERE Username=@Username
END
SP_GET_LOCK_USER 'donle'
----SP_CHECK_EMAIL------------------
CREATE PROC SP_CHECK_EMAIL
@email NVARCHAR(MAX)
AS
BEGIN
	SELECT * FROM KPI_M_User WHERE Email=@email
END
SP_CHECK_EMAIL 'lq_don@brycen.com.vn'
-------SP_CREATE_CODE-----------
CREATE PROC [dbo].[SP_CREATE_CODE]
@email NVARCHAR(MAX),
@code NVARCHAR(MAX),
@timeForget DATETIME
AS
BEGIN
	UPDATE KPI_M_User
	SET Token=@code, TimeForget=@timeForget
	WHERE Email=@email
END
-----SP_CHECK_FORGET_PASS------------
CREATE PROC SP_CHECK_FORGET_PASS
@email NVARCHAR(MAX),
@code NVARCHAR(MAX)
AS
BEGIN
	SELECT * FROM KPI_M_User WHERE Email=@email AND Token=@code
END
SP_CHECK_FORGET_PASS 'lq_don@brycen.com.vn','6669cc68-d1c4-4d9e-81ce-cd8d5003d79d'
------SP_UPDATE_PASSWORD-----------
CREATE PROC SP_UPDATE_PASSWORD
@username NVARCHAR(50),
@password NVARCHAR(50)
AS
BEGIN
	UPDATE KPI_M_User
	SET Password=CONVERT(VARCHAR(32), HashBytes('MD5', @password), 2)
	WHERE Username=@username
END
-------SP_GET_PROJECT-----------------
DECLARE @IDUser NVARCHAR(50)
SET @IDUser='PR1'
DECLARE @IdRole INT
SET @IdRole=1
SELECT * FROM
(SELECT DISTINCT * 
FROM KPI_T_ProjectUser JOIN KPI_M_Project
	ON KPI_T_ProjectUser.IdProject= KPI_T_ProjectUser.IdProject
WHERE KPI_T_ProjectUser.idUser=@IDUser) AS T JOIN KPI_T_ProjectUser ON T.IdProject=KPI_T_ProjectUser.IdProject
	JOIN KPI_M_User ON T.IdUser=KPI_M_User.IdUser WHERE KPI_M_User.IdRole=@IdRole
------ SP_GET_LIST_PROJECT ------------------
CREATE PROC SP_GET_LIST_PROJECT
@idUser NCHAR(6)
AS
BEGIN
SELECT DISTINCT Pr.NameProject,Dp.NameDepartment,Us.FirstName,Us.LastName,Pr.IdProject FROM KPI_M_Role Rl JOIN KPI_M_User Us ON Rl.IdRole=Us.IdRole JOIN KPI_T_ProjectUser Pu ON Us.IdUser=Pu.idUser
		JOIN KPI_M_Project Pr ON Pr.IdProject=Pu.IdProject JOIN KPI_M_Department Dp ON Dp.IdDerpartment=Pr.IdDepartment WHERE Rl.Name='Leader'
		AND Pr.IdProject IN (SELECT DISTINCT IdProject FROM KPI_T_ProjectUser WHERE KPI_T_ProjectUser.idUser=@idUser)
END
-------GET CONTENT-------------------
SELECT P.NamePhase,COUNT(Hour) Hour,COUNT(Bug) Bug,EC.IdEditContent
FROM	KPI_T_EditContent EC JOIN KPI_T_ErrorAnalysis EA ON EC.IdEditContent=EA.IdEditContent
		JOIN KPI_M_Phase P ON P.IdPhase=EA.idphase 
WHERE	IdProject=1	  AND IdUser='BRY003' GROUP BY EC.IdEditContent, P.NamePhase ORDER BY EC.IdEditContent
-------SP_GET_ANALYSYSCONTENT-----------
CREATE PROC [dbo].[SP_GET_ANALYSYSCONTENT]
@idUser nchar(6),
@idProject int,
@role NVARCHAR(50)
AS
BEGIN
if @role='Admin'
BEGIN
SELECT P.NamePhase, QA.Hour,SUM(EA.Bug) Bug, T.IdTask FROM KPI_T_QualityAnalysis QA JOIN KPI_T_ErrorAnalysis EA ON QA.IdQualityAnalysis=EA.IdQualityAnalysis
				JOIN KPI_M_Phase P ON P.IdPhase=QA.IdPhase
				JOIN KPI_T_Task T ON T.IdTask=QA.IdTask  
				JOIN KPI_T_ProjectUser PU ON PU.IdProject=T.IdProject
				WHERE T.Deleted=0  AND EA.Deleted=0  AND T.IdProject=@idProject
				GROUP BY P.NamePhase, QA.Hour, T.IdTask ORDER BY T.IdTask
END
ELSE
BEGIN
SELECT P.NamePhase, QA.Hour,SUM(EA.Bug) Bug, T.IdTask FROM KPI_T_QualityAnalysis QA JOIN KPI_T_ErrorAnalysis EA ON QA.IdQualityAnalysis=EA.IdQualityAnalysis
				JOIN KPI_M_Phase P ON P.IdPhase=QA.IdPhase
				JOIN KPI_T_Task T ON T.IdTask=QA.IdTask  
				JOIN KPI_T_ProjectUser PU ON PU.IdProject=T.IdProject
				WHERE T.Deleted=0  AND EA.Deleted=0 AND PU.IdUser=@idUser AND T.IdProject=@idProject
				GROUP BY P.NamePhase, QA.Hour, T.IdTask ORDER BY T.IdTask
END
END
-------GET_PHASE-----------------
CREATE PROC SP_GET_LIST_PHASE
AS
BEGIN
SELECT * FROM KPI_M_Phase Order by IdPhase
END
----------[SP_GET_ANALYSYSCONTENT_WHIT_IDEDITCONTENT]--------
ALTER PROC [dbo].[SP_GET_ANALYSYSCONTENT_WITH_IDEDITCONTENT]
@idUser nchar(6),
@role NVARCHAR(50),
@idProject int,
@idEditContent int
AS
BEGIN
SELECT P.NamePhase, QA.Hour,SUM(EA.Bug) Bug, T.IdTask FROM KPI_T_ProjectUser PU JOIN KPI_T_Task T ON PU.IdProject=T.IdProject
									JOIN KPI_T_QualityAnalysis QA ON QA.IdTask=T.IdTask
									JOIN KPI_M_Phase P ON P.IdPhase=QA.IdPhase
									LEFT JOIN KPI_T_ErrorAnalysis EA ON EA.IdQualityAnalysis=QA.IdQualityAnalysis
				WHERE T.Deleted=0 AND 
										    ((@role = 'Manager' AND pu.idUser=@idUser)
							OR
							(@role = 'Leader' AND pu.IdUser=@idUser)
							OR
							(@role = 'User' AND T.idUser=@idUser)
							OR
							(@role = 'Admin'))AND T.IdProject=@idProject AND T.IdTask=@idEditContent
				GROUP BY P.NamePhase,QA.Hour, T.IdTask ORDER BY NamePhase
END
----------
LTER PROC [dbo].[SP_GET_EDIT_CONTENT]
@page INT,
@pageSize INT,
@sortColumn NVARCHAR(50),
@sortOrder NVARCHAR(4),
@search NVARCHAR(MAX),
@role NVARCHAR(10),
@idUser NCHAR(6),
@idProject INT
AS
BEGIN
DECLARE @orderBy NVARCHAR(50)=@sortColumn+@sortOrder
DECLARE @serchConvert NVARCHAR(MAX) ='%'+@search+'%' 
SELECT * FROM
(SELECT ROW_NUMBER()OVER(ORDER BY 
					case when @orderBy='RowNumDESC' then RowNumber end DESC,
					case when @orderBy='RowNumASC' then RowNumber end ASC,
					case when @orderBy='Content' then (Select(0)) end,
					case when @orderBy='ContentASC' then Content end ASC,
					case when @orderBy='ContentDESC' then Content end DESC
					) AS RowNum,* FROM(
					select ROW_NUMBER()OVER(Order by (Select(0))
						) as RowNumber,Content,T.IdTask,Reason,U.IdUser,Username,U.FirstName,U.LastName,L.* FROM KPI_T_Task T
						JOIN KPI_M_Level L ON T.IdLevel=L.IdLevel
						JOIN KPI_M_User U ON U.IdUser=T.IdUser
						JOIN KPI_T_ProjectUser PU ON pu.IdProject=T.IdProject
						WHERE	T.IdProject=@idProject AND
						    (@role = 'Manager' AND pu.idUser=@idUser)
							OR
							(@role = 'Leader' AND pu.IdUser=@idUser)
							OR
							(@role = 'User' AND U.idUser=@idUser)
							OR
							(@role = 'Admin')
						 AND T.Deleted=0 AND (@serchConvert=N'' OR Content LIKE @serchConvert)
						) As t) AS y Where y.RowNum between (@page-1)*@pageSize + 1 and @page*@pageSize
END
-----------SP_COUNT_EDIT_CONTENT-----------
ALTER PROC [dbo].[SP_COUNT_EDIT_CONTENT]
@search NVARCHAR(MAX),
@role NVARCHAR(10),
@idUser NCHAR(6),
@idProject INT
AS
BEGIN
DECLARE @serchConvert NVARCHAR(MAX) ='%'+@search+'%' 
SELECT 
		COUNT(T.IdTask) Count FROM KPI_T_Task T
		JOIN KPI_M_Level L ON T.IdLevel=L.IdLevel
		JOIN KPI_M_User U ON U.IdUser=T.IdUser
		JOIN KPI_T_ProjectUser PU ON PU.IdProject=T.IdProject
		WHERE	T.IdProject=@idProject AND ((@role = 'Manager' AND pu.idUser=@idUser)
							OR
							(@role = 'Leader' AND pu.IdUser=@idUser)
							OR
							(@role = 'User' AND T.idUser=@idUser)
							OR
							(@role = 'Admin')) AND T.Deleted=0 AND (@serchConvert=N'' OR Content LIKE @serchConvert)
END
------SP_INSERT_ERRORANALYSIS------
USE KPI
GO

CREATE PROC SP_INSERT_ERRORANALYSIS
@Bug AS INT,
@Reference AS NVARCHAR,
@IdError AS INT, 
@idPhase INT,
@idTask INT
AS
DECLARE @IdQualityAnalysis INT
SELECT @IdQualityAnalysis=IdQualityAnalysis FROM KPI_T_QualityAnalysis WHERE IdTask=@idTask AND IdPhase=@idPhase
INSERT INTO [KPI_T_ErrorAnalysis] (Bug,Reference,IdError,IdQualityAnalysis,CreateAt) 
	VALUES (@Bug,@Reference,@IdError,@IdQualityAnalysis,GETDATE())
------------UPDATE_REASON_AND_HOUR------------------------
CREATE PROC UPDATE_REASON_AND_HOUR
@idUser nchar(6),
@role NVARCHAR(50),
@idProject INT,
@idTask INT,
@hourDesign FLOAT,
@hourCode FLOAT,
@hourTest FLOAT,
@Reason	NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRAN
		IF @role='Leader'
		BEGIN
		DECLARE @checkUserLeader NVARCHAR(50)=NULL
		SELECT @checkUserLeader = PU.idUser FROM KPI_T_Task T JOIN KPI_T_ProjectUser PU ON T.IdProject=PU.IdProject WHERE PU.IdUser=@idUser AND IdTask=@idTask AND T.IdProject=@idProject
		IF @checkUserLeader IS NOT NULL
		BEGIN
			UPDATE KPI_T_QualityAnalysis SET Hour=@hourDesign WHERE IdTask=@idTask AND IdPhase=1
			UPDATE KPI_T_QualityAnalysis SET Hour=@hourCode WHERE IdTask=@idTask AND IdPhase=2
			UPDATE KPI_T_QualityAnalysis SET Hour=@hourTest WHERE IdTask=@idTask AND IdPhase=2
			UPDATE KPI_T_Task SET Reason=@Reason WHERE IdTask=@idTask AND IdProject=@idProject
		END
		END
		IF @role='User'
		BEGIN
		DECLARE @checkUser NVARCHAR(50)=NULL
		SELECT @checkUser = idUser FROM KPI_T_Task WHERE IdUser=@idUser AND IdTask=@idTask AND IdProject=@idProject
		IF @checkUser IS NOT NULL
		BEGIN
			UPDATE KPI_T_QualityAnalysis SET Hour=@hourDesign WHERE IdTask=@idTask AND IdPhase=1
			UPDATE KPI_T_QualityAnalysis SET Hour=@hourCode WHERE IdTask=@idTask AND IdPhase=2
			UPDATE KPI_T_QualityAnalysis SET Hour=@hourTest WHERE IdTask=@idTask AND IdPhase=2
			UPDATE KPI_T_Task SET Reason=@Reason WHERE IdTask=@idTask AND IdProject=@idProject
		END
		END
	COMMIT
END