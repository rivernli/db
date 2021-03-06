USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[QMS_quotation_items]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QMS_quotation_items](
	[itemId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[quotationId] [int] NOT NULL,
	[customerPart] [nvarchar](50) NOT NULL,
	[rev] [nvarchar](50) NULL,
	[remarks] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[volumePerMonth] [nchar](10) NULL,
	[expectedLifeTime] [nvarchar](50) NULL,
 CONSTRAINT [PK_QMS_quotation_items] PRIMARY KEY CLUSTERED 
(
	[itemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QMS_quotation_items]  WITH CHECK ADD  CONSTRAINT [FK_QMS_quotation_items_QMS_quotation] FOREIGN KEY([quotationId])
REFERENCES [dbo].[QMS_quotation] ([QuoteId])
GO
ALTER TABLE [dbo].[QMS_quotation_items] CHECK CONSTRAINT [FK_QMS_quotation_items_QMS_quotation]
GO
