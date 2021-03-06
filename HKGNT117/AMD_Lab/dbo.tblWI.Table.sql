USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblWI]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblWI](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WI number] [nvarchar](255) NULL,
	[Originator] [nvarchar](255) NULL,
	[Title] [nvarchar](255) NULL,
	[ReleaseDate] [datetime] NULL,
	[Version] [nvarchar](255) NULL,
	[EffectiveDate] [datetime] NULL,
	[ExpireDate] [datetime] NULL,
	[User1] [nvarchar](50) NULL,
	[User2] [nvarchar](50) NULL,
	[User3] [nvarchar](50) NULL,
	[User4] [nvarchar](50) NULL,
	[User5] [nvarchar](50) NULL,
	[User6] [nvarchar](50) NULL,
	[User7] [nvarchar](50) NULL,
	[User8] [nvarchar](50) NULL,
	[User9] [nvarchar](50) NULL,
	[User10] [nvarchar](50) NULL,
	[Status] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
