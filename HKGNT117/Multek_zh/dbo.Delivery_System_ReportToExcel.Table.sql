USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Delivery_System_ReportToExcel]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Delivery_System_ReportToExcel](
	[Numbers] [int] IDENTITY(1,1) NOT NULL,
	[Xh] [bigint] NULL,
	[TableName] [varchar](50) NULL,
	[FieldID] [nvarchar](300) NULL,
	[FieldName] [varchar](50) NULL,
	[Modoul] [varchar](50) NULL,
 CONSTRAINT [PK_System_ReportToExcel] PRIMARY KEY CLUSTERED 
(
	[Numbers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
