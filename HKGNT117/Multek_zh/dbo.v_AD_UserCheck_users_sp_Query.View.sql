USE [Multek_ZH]
GO
/****** Object:  View [dbo].[v_AD_UserCheck_users_sp_Query]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_AD_UserCheck_users_sp_Query]
AS
SELECT 
objectSid,	sAMAccountName,
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
			msExchAssistantName,
			employeenumber,
			description
FROM    OPENQUERY(ADSI,
		'SELECT
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
			msExchAssistantName,
			employeenumber,
			description
		 FROM    ''LDAP://asia.ad.flextronics.com''
		 WHERE   sAMAccountName=''mcn*'''
)
GO
