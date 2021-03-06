USE [BOC]
GO
/****** Object:  Table [dbo].[CostCatorgoryPriceTrend]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CostCatorgoryPriceTrend](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Vender] [nvarchar](50) NULL,
	[Issued_Amt] [float] NULL,
	[Amt_avgPrice_P07] [float] NULL,
	[Amt_actPrice_P07] [float] NULL,
	[Better_P07] [float] NULL,
	[Worse_P07] [float] NULL,
	[Amt_avgPrice_P08] [float] NULL,
	[Amt_actPrice_P08] [float] NULL,
	[Better_P08] [float] NULL,
	[Worse_P08] [float] NULL,
	[Amt_avgPrice_P09] [float] NULL,
	[Amt_actPrice_P09] [float] NULL,
	[Better_P09] [float] NULL,
	[Worse_P09] [float] NULL,
 CONSTRAINT [PK_CostCatorgoryPriceTrend] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
