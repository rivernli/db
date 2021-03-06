USE [BOC]
GO
/****** Object:  Table [dbo].[CostPriceTrend_Users]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CostPriceTrend_Users](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NULL,
	[Region] [varchar](50) NULL,
	[Account] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[BDM] [varchar](50) NULL,
	[Administrator] [bit] NULL,
	[Enable] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
