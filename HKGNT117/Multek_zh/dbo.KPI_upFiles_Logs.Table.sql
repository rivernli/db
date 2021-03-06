USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KPI_upFiles_Logs]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KPI_upFiles_Logs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FileID] [varchar](50) NULL,
	[Downloaded] [nvarchar](max) NULL,
	[Downloaded_Date] [datetime] NULL,
 CONSTRAINT [PK_KPI_upFiles_Logs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[KPI_upFiles_Logs] ADD  CONSTRAINT [DF_KPI_upFiles_Logs_Downloaded_Date]  DEFAULT (getdate()) FOR [Downloaded_Date]
GO
