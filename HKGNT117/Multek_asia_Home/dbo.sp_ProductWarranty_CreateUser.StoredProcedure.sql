USE [Multek_AsiaHome]
GO
/****** Object:  StoredProcedure [dbo].[sp_ProductWarranty_CreateUser]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Abill Cheng
-- Create date: Aug 26, 2010
-- Description:	Create user
-- =============================================
CREATE PROCEDURE [dbo].[sp_ProductWarranty_CreateUser] 
	@sAMAccountName 	NVARCHAR(70),
	@Active				BIT,
	@EnableRead			BIT,
	@EnableCreate		BIT,
	@EnableUpdate		BIT,
	@EnableDelete		BIT,
	@IsAdministrator	BIT,
	@CreatedBy			UNIQUEIDENTIFIER=NULL
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @UserId UNIQUEIDENTIFIER
	DECLARE @FullName NVARCHAR(80)
	DECLARE @EmailAddress NVARCHAR(100)
	DECLARE @objectSid VARBINARY(100)

	DECLARE @Domains NVARCHAR(50), @Domain NVARCHAR(20), @Temp NVARCHAR(50)
	DECLARE @Condition NVARCHAR(200)
	
	DECLARE @Len INT, @Idx INT
	
	SET @Domains = 'ASIA,AMERICAS,EUROPE,ABILL'
	SET @Condition = 'sAMAccountName='''''+@sAMAccountName+''''''

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

	DECLARE @Sid VARBINARY(100)
	DECLARE Query_Cur CURSOR FOR
	SELECT [objectSid]
	FROM #TEMP_ADSI

	OPEN Query_Cur
	FETCH NEXT FROM Query_Cur INTO @objectSid
	WHILE @@FETCH_STATUS=0
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM ProductWarranty_User WHERE [objectSid]=@objectSid)
		BEGIN
			INSERT INTO ProductWarranty_User
			SELECT
				NEWID(),
				Domain,
				sAMAccountName,
				FullName,
				EmailAddress,
				objectSid,
				@EnableRead,
				@EnableCreate,
				@EnableUpdate,
				@EnableDelete,
				@IsAdministrator,
				@Active,
				GETDATE(),
				@CreatedBy,
				GETDATE(),
				@CreatedBy
			FROM #TEMP_ADSI
			WHERE [objectSid]=@objectSid
		END
		FETCH NEXT FROM Query_Cur INTO @objectSid
	END

	CLOSE Query_Cur
	DEALLOCATE Query_Cur

	DROP TABLE #TEMP_ADSI
END


GO
