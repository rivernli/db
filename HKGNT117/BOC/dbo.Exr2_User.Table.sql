USE [BOC]
GO
/****** Object:  Table [dbo].[Exr2_User]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exr2_User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[uid] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
	[domain] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[department] [nvarchar](50) NULL,
	[title] [nvarchar](50) NULL,
	[createdBy] [nvarchar](50) NULL,
	[creationDate] [datetime] NULL,
	[lastLoginTime] [datetime] NULL
) ON [PRIMARY]

GO
