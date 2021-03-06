USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_Quarterly_RMA]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_Quarterly_RMA](
	[Year] [varchar](4) NOT NULL,
	[Quarter] [smallint] NOT NULL,
	[QuarterDesc] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Lot] [int] NULL,
	[Unit] [int] NULL,
	[SQFT] [int] NULL,
	[Cost] [int] NULL,
	[PCB] [int] NULL,
	[PCBA] [int] NULL,
	[PCBRLP] [int] NULL,
 CONSTRAINT [PK_DistributionReport_Quarterly_RMA] PRIMARY KEY CLUSTERED 
(
	[Year] DESC,
	[Quarter] ASC,
	[QuarterDesc] ASC,
	[Plant] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
