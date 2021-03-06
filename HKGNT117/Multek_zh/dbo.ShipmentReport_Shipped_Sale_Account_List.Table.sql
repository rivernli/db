USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_Sale_Account_List]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_Sale_Account_List](
	[Account] [nvarchar](12) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Company] [nvarchar](50) NULL,
	[Include] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Main_Index]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Main_Index] ON [dbo].[ShipmentReport_Shipped_Sale_Account_List]
(
	[Account] ASC,
	[Company] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
