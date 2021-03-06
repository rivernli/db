USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistribitionReport_Amount_Calendar]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistribitionReport_Amount_Calendar](
	[ReportCode] [varchar](3) NOT NULL,
	[Type] [varchar](10) NOT NULL,
	[Site] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[M1] [numeric](18, 2) NULL,
	[M2] [numeric](18, 2) NULL,
	[M3] [numeric](18, 2) NULL,
	[M4] [numeric](18, 2) NULL,
	[M5] [numeric](18, 2) NULL,
	[M6] [numeric](18, 2) NULL,
	[M7] [numeric](18, 2) NULL,
	[M8] [numeric](18, 2) NULL,
	[M9] [numeric](18, 2) NULL,
	[M10] [numeric](18, 2) NULL,
	[M11] [numeric](18, 2) NULL,
	[M12] [numeric](18, 2) NULL,
 CONSTRAINT [PK_DistribitionReport_Amount_Calendar] PRIMARY KEY CLUSTERED 
(
	[ReportCode] ASC,
	[Type] ASC,
	[Site] ASC,
	[Plant] ASC,
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
