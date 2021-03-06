USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[AccountProfile_Users]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountProfile_Users](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[Region] [varchar](50) NOT NULL,
	[Account] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[BDM] [varchar](50) NOT NULL,
	[Administrator] [bit] NOT NULL CONSTRAINT [DF_AccountProfile_Users_Administrator]  DEFAULT ((0)),
	[Enable] [bit] NOT NULL CONSTRAINT [DF_AccountProfile_Users_Enable]  DEFAULT ((1)),
	[department] [nvarchar](50) NULL,
	[jobTitle] [nvarchar](50) NULL,
	[Mobile] [varchar](50) NULL,
	[fax] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[sitesAccess] [nvarchar](250) NULL,
	[creationDate] [datetime] NULL,
	[createdBy] [nvarchar](50) NULL,
	[lastModifyDate] [datetime] NULL,
	[lastModifiedBy] [nvarchar](50) NULL,
	[hideFrLog] [bit] NULL CONSTRAINT [DF_AccountProfile_Users_hideFrLog]  DEFAULT ((0)),
	[ManagerId] [varchar](50) NULL,
	[Management] [bit] NULL CONSTRAINT [DF_AccountProfile_Users_Management]  DEFAULT ((0)),
	[OnlyAccess] [bit] NULL CONSTRAINT [DF_AccountProfile_Users_OnlyAccess]  DEFAULT ((0)),
 CONSTRAINT [AccountProfile_Userid] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
