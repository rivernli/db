USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KOI_Weekly_DPPM_by_unit]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KOI_Weekly_DPPM_by_unit](
	[ReportCode] [varchar](3) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[Week] [smallint] NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Unit] [int] NULL,
 CONSTRAINT [PK_KOI_Weekly_DPPM_by_unit] PRIMARY KEY CLUSTERED 
(
	[ReportCode] ASC,
	[Year] ASC,
	[Week] ASC,
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
