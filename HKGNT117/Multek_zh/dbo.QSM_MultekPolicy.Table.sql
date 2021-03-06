USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[QSM_MultekPolicy]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QSM_MultekPolicy](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[FileKey] [varchar](20) NULL,
	[Sort] [int] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [varchar](50) NULL,
 CONSTRAINT [PK_QSM_MultekPolicy] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
