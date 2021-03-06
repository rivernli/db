USE [Multek_AsiaHome]
GO
/****** Object:  StoredProcedure [dbo].[sp_ActiveDirectory_QueryByAccount]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Abill Cheng
-- Create date: 2010-5-14
-- Description:	Query active directory user by user's account, account format: DOMAIN\LOGON_NAME
-- =============================================
CREATE PROCEDURE [dbo].[sp_ActiveDirectory_QueryByAccount]
	@Account		NVARCHAR(50)='ASIA\LGZACHEN'
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Separator INT
	DECLARE @Domain VARCHAR(20), @LogonName VARCHAR(30)
	DECLARE @Condition NVARCHAR(200)

	SET @Separator=CHARINDEX('\',@Account)
	SET @Domain=SUBSTRING(@Account,1,@Separator-1)
	SET @LogonName=SUBSTRING(@Account,@Separator+1,LEN(@Account))
	SET @Condition='sAMAccountName='''''+@LogonName+''''''

	SELECT
		[Id],
		[objectSid],
		[Domain],
		[sAMAccountName],
		[userPrincipalName],
		[distinguishedName],
		[FirstName],
		[LastName],
		[FullName],
		[DisplayName],
		[EmailAddress],
		[Company],
		[Department],
		[JobTitle],
		[Address],
		[City],
		[State],
		[PostalCode],
		[FaxNumber],
		[Office],
		[Country],
		[HomePage],
		[BusinessPhone],
		[HomePhone],
		[MobilePhone],
		[VoIP],
		[IM],
		[EmployeeID],
		[EmployeeType],
		[Manager],
		[Assistant]
	INTO #TEMP_ADSI
	FROM dbo.ActiveDirectory_User
	WHERE 1=2

	-- Insert data to temp
	INSERT #TEMP_ADSI(
		[Id],
		[objectSid],
		[Domain],
		[sAMAccountName],
		[userPrincipalName],
		[distinguishedName],
		[FirstName],
		[LastName],
		[FullName],
		[DisplayName],
		[EmailAddress],
		[Company],
		[Department],
		[JobTitle],
		[Address],
		[City],
		[State],
		[PostalCode],
		[FaxNumber],
		[Office],
		[Country],
		[HomePage],
		[BusinessPhone],
		[HomePhone],
		[MobilePhone],
		[VoIP],
		[IM],
		[EmployeeID],
		[EmployeeType],
		[Manager],
		[Assistant])
	EXECUTE sp_ActiveDirectory_Query @Domain,0,@Condition

	SELECT * FROM #TEMP_ADSI
	ORDER BY [FullName]

	DROP TABLE #TEMP_ADSI

END















GO
