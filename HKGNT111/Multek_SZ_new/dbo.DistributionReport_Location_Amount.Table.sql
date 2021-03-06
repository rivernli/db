USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_Location_Amount]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_Location_Amount](
	[ReportCode] [varchar](50) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[Site] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Country] [varchar](3) NOT NULL,
	[Year] [varchar](50) NOT NULL,
	[M1] [bigint] NULL,
	[M2] [bigint] NULL,
	[M3] [bigint] NULL,
	[M4] [bigint] NULL,
	[M5] [bigint] NULL,
	[M6] [bigint] NULL,
	[M7] [bigint] NULL,
	[M8] [bigint] NULL,
	[M9] [bigint] NULL,
	[M10] [bigint] NULL,
	[M11] [bigint] NULL,
	[M12] [bigint] NULL,
	[Amount] [bigint] NULL,
 CONSTRAINT [PK_DistributionReport_Location_Amount] PRIMARY KEY CLUSTERED 
(
	[ReportCode] ASC,
	[Type] ASC,
	[Site] ASC,
	[Plant] ASC,
	[Country] ASC,
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
