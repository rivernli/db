USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B1Parts_ReportToExcel]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[B1Parts_ReportToExcel](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Xh] [bigint] NULL,
	[TableName] [varchar](50) NULL,
	[FieldID] [nvarchar](max) NULL,
	[FieldName] [varchar](300) NULL,
	[Modoul] [varchar](50) NULL,
 CONSTRAINT [PK_B1Parts_ReportToExcel] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
