USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[hubInventoryCEMLocation]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hubInventoryCEMLocation](
	[customer_code] [nvarchar](50) NOT NULL,
	[location] [nvarchar](100) NOT NULL CONSTRAINT [DF_hubInventoryCEMLocation_CM_location]  DEFAULT ('')
) ON [PRIMARY]

GO
