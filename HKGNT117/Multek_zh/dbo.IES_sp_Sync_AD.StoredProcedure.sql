USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Sync_AD]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[IES_sp_Sync_AD]
AS
	DECLARE @ID INT
	DECLARE @Domain VARCHAR(50)
	DECLARE @LoginName VARCHAR(50)
	DECLARE @LdapString NVARCHAR(MAX)

	TRUNCATE TABLE IES_User_Temp

	DECLARE user_cursor CURSOR FOR
		SELECT ID, Domain, LoginName FROM IES_User
	OPEN user_cursor
	FETCH NEXT FROM user_cursor INTO @ID, @Domain, @LoginName
	WHILE @@FETCH_STATUS = 0
		BEGIN

		SET @LdapString = 
		'INSERT INTO IES_User_Temp SELECT

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
		FROM    OPENQUERY(ADSI,''SELECT
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
		 WHERE    objectClass = ''''User'''' AND objectClass<>''''Computer'''' AND sAMAccountName='''''+@LoginName+''''''')'

		 EXEC(@LdapString)

			FETCH NEXT FROM user_cursor INTO @ID, @Domain, @LoginName
		END
	CLOSE user_cursor
	DEALLOCATE user_cursor
	UPDATE IES_User SET Enabled = 0 WHERE Enabled = 1 AND LoginName NOT IN(SELECT sAMAccountName FROM IES_User_Temp)
	UPDATE t1 SET t1.FirstName = t2.givenName, t1.LastName = t2.sn, t1.Department = t2.department, t1.title = t2.title, t1.Email = t2.mail
	FROM IES_User t1 INNER JOIN IES_User_Temp t2 ON t1.LoginName = t2.sAMAccountName
	TRUNCATE TABLE IES_User_Temp

GO
