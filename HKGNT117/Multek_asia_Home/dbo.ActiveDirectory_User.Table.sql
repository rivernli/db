USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[ActiveDirectory_User]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActiveDirectory_User](
	[Id] [uniqueidentifier] NOT NULL,
	[objectSid] [varbinary](100) NOT NULL,
	[Domain] [nvarchar](15) NOT NULL,
	[sAMAccountName] [nvarchar](70) NOT NULL,
	[userPrincipalName] [nvarchar](80) NULL,
	[distinguishedName] [nvarchar](300) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](150) NULL,
	[EmailAddress] [nvarchar](100) NULL,
	[Company] [nvarchar](250) NULL,
	[Department] [nvarchar](100) NULL,
	[JobTitle] [nvarchar](100) NULL,
	[Address] [nvarchar](250) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[PostalCode] [nvarchar](100) NULL,
	[FaxNumber] [nvarchar](100) NULL,
	[Office] [nvarchar](250) NULL,
	[Country] [nvarchar](100) NULL,
	[HomePage] [nvarchar](100) NULL,
	[BusinessPhone] [nvarchar](100) NULL,
	[HomePhone] [nvarchar](100) NULL,
	[MobilePhone] [nvarchar](100) NULL,
	[VoIP] [nvarchar](100) NULL,
	[IM] [nvarchar](100) NULL,
	[EmployeeID] [nvarchar](100) NULL,
	[EmployeeType] [nvarchar](100) NULL,
	[Manager] [nvarchar](300) NULL,
	[Assistant] [nvarchar](100) NULL,
 CONSTRAINT [PK_ActiveDirectory_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Common Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ActiveDirectory_User', @level2type=N'COLUMN',@level2name=N'FullName'
GO
