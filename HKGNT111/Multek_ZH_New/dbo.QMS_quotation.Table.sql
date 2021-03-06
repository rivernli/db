USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[QMS_quotation]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QMS_quotation](
	[QuoteId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RFQ] [nvarchar](50) NOT NULL,
	[Supporter] [nvarchar](50) NOT NULL,
	[createDate] [date] NOT NULL,
	[outDate] [date] NULL,
	[OEM] [nvarchar](50) NOT NULL,
	[CEM] [nvarchar](50) NULL,
	[contact] [nvarchar](50) NULL,
	[shipmentTerms] [nvarchar](50) NULL,
	[shipmentTermsAdder] [nvarchar](50) NULL,
	[paymentTerms] [nvarchar](50) NULL,
	[leadTime] [nvarchar](50) NULL,
	[currency] [nvarchar](50) NULL,
	[exchangeRate] [nvarchar](50) NULL,
	[setupCharge] [nvarchar](50) NULL,
	[ETestCharge] [nvarchar](50) NULL,
	[toolingCharge] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
 CONSTRAINT [PK_QMS_quotation] PRIMARY KEY CLUSTERED 
(
	[QuoteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QMS_quotation] ADD  CONSTRAINT [DF_QMS_quotation_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
