USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_User]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Account] [varchar](50) NOT NULL,
	[Domain] [varchar](50) NOT NULL,
	[LoginName] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](500) NULL,
	[Department] [varchar](50) NULL,
	[Title] [varchar](50) NULL,
	[Enabled] [bit] NOT NULL CONSTRAINT [DF_IES_User_Enabled]  DEFAULT ((1)),
	[CanEdit] [bit] NOT NULL CONSTRAINT [DF_IES_User_CanEdit]  DEFAULT ((0)),
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
