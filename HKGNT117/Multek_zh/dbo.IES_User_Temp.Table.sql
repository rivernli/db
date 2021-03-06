USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_User_Temp]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_User_Temp](
	[Domain] [varchar](40) NOT NULL,
	[sAMAccountName] [nvarchar](256) NULL,
	[userPrincipalName] [nvarchar](256) NULL,
	[distinguishedName] [nvarchar](256) NULL,
	[givenName] [nvarchar](256) NULL,
	[sn] [nvarchar](256) NULL,
	[cn] [nvarchar](256) NULL,
	[displayName] [nvarchar](256) NULL,
	[mail] [nvarchar](256) NULL,
	[company] [nvarchar](256) NULL,
	[department] [nvarchar](256) NULL,
	[title] [nvarchar](256) NULL,
	[streetAddress] [nvarchar](256) NULL,
	[l] [nvarchar](256) NULL,
	[st] [nvarchar](256) NULL,
	[postalCode] [nvarchar](256) NULL,
	[facsimileTelephoneNumber] [nvarchar](256) NULL,
	[physicalDeliveryOfficeName] [nvarchar](256) NULL,
	[co] [nvarchar](256) NULL,
	[wWWHomePage] [nvarchar](256) NULL,
	[telephoneNumber] [nvarchar](256) NULL,
	[homePhone] [nvarchar](256) NULL,
	[mobile] [nvarchar](256) NULL,
	[extensionAttribute1] [nvarchar](256) NULL,
	[msExchHouseIdentifier] [nvarchar](256) NULL,
	[employeeID] [nvarchar](256) NULL,
	[employeeType] [nvarchar](256) NULL,
	[manager] [nvarchar](256) NULL,
	[msExchAssistantName] [nvarchar](256) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
