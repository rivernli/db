USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Customer_Loc_Mapping]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_Customer_Loc_Mapping](
	[Customer] [varchar](500) NOT NULL,
 CONSTRAINT [PK_ShipmentReport_ShipmentReport_Customer_Loc_Mapping] PRIMARY KEY CLUSTERED 
(
	[Customer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
