USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B2F_Forecast_detail_New]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[B2F_Forecast_detail_New](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Month] [varchar](50) NULL,
	[Qtr] [varchar](50) NULL,
	[OEM] [nvarchar](50) NULL,
	[PartNumber] [nvarchar](50) NULL,
	[Internalprojectno] [varchar](50) NULL,
	[ForecastQty] [varchar](20) NULL,
	[Array] [varchar](20) NULL,
	[SQFT_PNL] [varchar](20) NULL,
	[FPCUnitPrice] [varchar](20) NULL,
	[BOMPrice] [varchar](20) NULL,
	[SMTPrice] [varchar](20) NULL,
	[Lsh] [varchar](20) NULL,
	[UserName] [nvarchar](50) NULL,
	[InitiatorAccount] [varchar](50) NULL,
	[InitiatorDate] [datetime] NULL,
 CONSTRAINT [PK_B2F_Forecast_New] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
