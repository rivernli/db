USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[qryB5IST_Results]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qryB5IST_Results](
	[Construction ID] [int] NOT NULL,
	[Construction Name] [nvarchar](50) NULL,
	[location] [int] NULL,
	[# Layers] [tinyint] NULL,
	[MaterialL] [int] NULL,
	[Coupon thickness] [decimal](5, 4) NULL,
	[P1 Via type] [nvarchar](50) NULL,
	[P1 drill size] [decimal](6, 5) NULL,
	[S1 Via type] [nvarchar](50) NULL,
	[S1 drill size] [decimal](6, 5) NULL,
	[P2 Via type] [nvarchar](50) NULL,
	[P2 drill size] [decimal](6, 5) NULL,
	[S2 Via type] [nvarchar](50) NULL,
	[S2 drill size] [decimal](6, 5) NULL,
	[CouponID] [int] NOT NULL,
	[CouponName] [nvarchar](50) NULL,
	[TN] [int] NULL,
	[ConstName] [int] NULL,
	[Precondition Name] [int] NULL,
	[Cycling Name] [int] NULL,
	[Cyc com] [smallint] NULL,
	[Status] [nvarchar](50) NULL
) ON [PRIMARY]

GO
