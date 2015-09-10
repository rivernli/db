USE [ContractTracker]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 11/06/2014 15:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[Billing Address] [varchar](255) NULL,
	[Billing Cust Name] [varchar](255) NULL,
	[MEP] [varchar](255) NULL,
	[MEP DESC] [varchar](255) NULL,
	[Site] [varchar](255) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
