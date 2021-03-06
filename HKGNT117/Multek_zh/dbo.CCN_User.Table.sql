USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[CCN_User]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CCN_User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoginName] [varchar](20) NULL,
	[FullName] [varchar](100) NULL,
	[JobTitle] [varchar](200) NULL,
	[EmailAddress] [varchar](200) NULL,
	[Plant] [varchar](50) NULL,
	[Enabled] [int] NULL,
	[IsLocalAdmin] [int] NOT NULL CONSTRAINT [DF_CCN_User_IsLocalAdmin]  DEFAULT ((0)),
	[IsSuperAdmin] [int] NOT NULL CONSTRAINT [DF_CCN_User_IsSuperAdmin]  DEFAULT ((0)),
	[IsQAM] [int] NOT NULL CONSTRAINT [DF_CCN_User_IsQAM]  DEFAULT ((0)),
	[IsPEM] [int] NOT NULL CONSTRAINT [DF_CCN_User_ISPEM]  DEFAULT ((0)),
	[IsQAD] [int] NOT NULL CONSTRAINT [DF_CCN_User_IsQAD]  DEFAULT ((0)),
	[IsGM] [int] NOT NULL CONSTRAINT [DF_CCN_User_IsGM]  DEFAULT ((0)),
	[IsTopM] [int] NOT NULL CONSTRAINT [DF_CCN_User_IsTopM]  DEFAULT ((0)),
 CONSTRAINT [PK_CCN_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
