USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[HUBINV_nUser]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HUBINV_nUser](
	[uid] [nvarchar](25) NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT ((1)),
	[isAdmin] [bit] NOT NULL DEFAULT ((0)),
	[lastLoginTime] [datetime] NULL,
	[domain] [nvarchar](50) NULL,
	[emailAddress] [nvarchar](50) NULL,
	[department] [nvarchar](50) NULL,
	[jobTitle] [nvarchar](50) NULL,
	[fax] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[sitesAccess] [nvarchar](250) NULL,
	[creationDate] [datetime] NOT NULL,
	[createdBy] [nvarchar](50) NOT NULL,
	[lastModifyDate] [datetime] NULL,
	[lastModifiedBy] [nvarchar](50) NULL,
	[hideFrLog] [bit] NULL CONSTRAINT [DF_HUBINV_nUser_hideFrLog]  DEFAULT ((0)),
 CONSTRAINT [PK_hubinv_nUser] PRIMARY KEY CLUSTERED 
(
	[uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
