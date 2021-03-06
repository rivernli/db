USE [BOC]
GO
/****** Object:  Table [dbo].[TPURCHARSETREND]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPURCHARSETREND](
	[FYear] [int] NOT NULL,
	[FPeriod] [int] NOT NULL,
	[Plant] [nvarchar](10) NOT NULL,
	[TransType] [nvarchar](10) NOT NULL,
	[Item] [nvarchar](40) NOT NULL,
	[SupplyCode] [nvarchar](10) NOT NULL,
	[SupplyName] [nvarchar](50) NULL,
	[ItemGroupCode] [nvarchar](10) NOT NULL,
	[ItemGroupName] [nvarchar](10) NULL,
	[Currency] [nvarchar](10) NULL,
	[CurrencyUSD] [nvarchar](10) NULL,
	[PriceOriginal] [float] NULL,
	[PriceUSD] [float] NULL,
	[QtyActual] [float] NULL,
	[PriceForecast] [float] NULL,
	[QtyForecast] [float] NULL,
 CONSTRAINT [PK_TPURCHARSETREND] PRIMARY KEY CLUSTERED 
(
	[FYear] ASC,
	[FPeriod] ASC,
	[Plant] ASC,
	[TransType] ASC,
	[Item] ASC,
	[SupplyCode] ASC,
	[ItemGroupCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
