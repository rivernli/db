USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[QSM_DCC]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QSM_DCC](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeID] [int] NULL,
	[FileKey] [varchar](20) NULL,
	[TitleInEnglish] [varchar](50) NULL,
	[TitleInChinese] [nvarchar](50) NULL,
	[StandardNo] [nvarchar](50) NULL,
	[Version] [varchar](20) NULL,
	[AddDate] [varchar](20) NULL,
	[ByWho] [nvarchar](50) NULL,
 CONSTRAINT [PK_QSM_DCC] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
