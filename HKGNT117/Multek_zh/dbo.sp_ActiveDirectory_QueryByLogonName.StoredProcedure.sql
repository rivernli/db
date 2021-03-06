USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_ActiveDirectory_QueryByLogonName]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ActiveDirectory_QueryByLogonName]
	@LogonName		NVARCHAR(20)='MCNAFENG'
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Domains VARCHAR(50), @Domain VARCHAR(20), @Temp VARCHAR(50)
	DECLARE @Len INT, @Idx INT
	DECLARE @Condition NVARCHAR(200)

	SET @Condition='sAMAccountName='''''+@LogonName+''''''
	
	SET @Domains = 'ASIA,AMERICAS,EUROPE,ABILL'

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

	SELECT @Len=LEN(@Domains)
	SELECT @Idx=CHARINDEX(',',@Domains)

	WHILE @Idx>0
	BEGIN
		SELECT @Domain=SUBSTRING(@Domains,1,@Idx-1)
		SELECT @Domains=SUBSTRING(@Domains,@Idx+1,@Len-@Idx)
		SELECT @Idx=CHARINDEX(',',@Domains)

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
	END

	

	SELECT * FROM #TEMP_ADSI
	ORDER BY [FullName]

	DROP TABLE #TEMP_ADSI

END


GO
