USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_Periodly_RMA]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_Periodly_RMA](
	[Year] [varchar](4) NOT NULL,
	[Period] [smallint] NOT NULL,
	[PeriodDesc] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Lot] [int] NULL,
	[Unit] [int] NULL,
	[SQFT] [int] NULL,
	[Cost] [int] NULL,
	[PCB] [int] NULL,
	[PCBA] [int] NULL,
	[PCBRLP] [int] NULL,
 CONSTRAINT [PK_DistributionReport_Periodly_RMA] PRIMARY KEY CLUSTERED 
(
	[Year] DESC,
	[Period] ASC,
	[PeriodDesc] ASC,
	[Plant] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
