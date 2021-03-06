USE [Multek_AsiaHome]
GO
/****** Object:  StoredProcedure [dbo].[sp_ActiveDirectory_Query]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Abill Cheng
-- Create date: 2010-4-23
-- Description:	Open Query
-- @QueryType: 0 User, 1 Group
-- =============================================
CREATE PROCEDURE [dbo].[sp_ActiveDirectory_Query]
	@Domain		VARCHAR(20)='ASIA',
	@QueryType	INT=0,
	@Condition	NVARCHAR(200)='CN=''''Abill Cheng'''''
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @SQL VARCHAR(4000)

	SELECT @SQL='
		SELECT
			NEWID() AS Id,
			objectSid,
			'''+@Domain+''' AS Domain,
			sAMAccountName,
			userPrincipalName,
			distinguishedName,
			givenName,
			sn,
			cn,
			displayName,
			mail,
			company,
			department,
			title,
			streetAddress,
			l,
			st,
			postalCode,
			facsimileTelephoneNumber,
			physicalDeliveryOfficeName,
			co,
			wWWHomePage,
			telephoneNumber,
			homePhone,
			mobile,
			extensionAttribute1,
			msExchHouseIdentifier,
			employeeID,
			employeeType,
			manager,
			msExchAssistantName
		FROM    OPENQUERY(ADSI,
		''SELECT
			objectSid,
			sAMAccountName,
			userPrincipalName,
			distinguishedName,
			givenName,
			sn,
			cn,
			displayName,
			mail,
			company,
			department,
			title,
			streetAddress,
			l,
			st,
			postalCode,
			facsimileTelephoneNumber,
			physicalDeliveryOfficeName,
			co,
			wWWHomePage,
			telephoneNumber,
			homePhone,
			mobile,
			extensionAttribute1,
			msExchHouseIdentifier,
			employeeID,
			employeeType,
			manager,
			msExchAssistantName
		 FROM    ''''LDAP://'+@Domain+'.ad.flextronics.com''''
		 WHERE   '
	IF @QueryType=0
		SET @SQL=@SQL+' objectClass = ''''User'''' AND objectClass<>''''Computer'''''
	ELSE
		SET @SQL=@SQL+' objectClass = ''''Group'''''

	SET @SQL=@SQL+' AND '+@Condition+''')'

	EXECUTE(@SQL)

END























GO
