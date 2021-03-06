USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[IST Coupon Construction Query]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IST Coupon Construction Query](
	[Construction ID] [int] NOT NULL,
	[Construction Name] [nvarchar](50) NULL,
	[# Layers] [tinyint] NULL,
	[Coupon thickness] [decimal](5, 4) NULL,
	[MaterialL] [int] NULL,
	[Surface Finish] [nvarchar](50) NULL,
	[P1 drill size] [decimal](6, 5) NULL,
	[S1 drill size] [decimal](6, 5) NULL,
	[P2 drill size] [decimal](6, 5) NULL,
	[S2 drill size] [decimal](6, 5) NULL,
	[CouponID] [int] NOT NULL,
	[CouponName] [nvarchar](50) NULL,
	[ConstName] [int] NULL,
	[Precondition Name] [int] NULL,
	[Cycling Name] [int] NULL,
	[P1 ohms prescreen] [smallint] NULL,
	[P2 ohms prescreen] [smallint] NULL,
	[S1 ohms prescreen] [smallint] NULL,
	[S2 ohms prescreen] [smallint] NULL,
	[Status] [nvarchar](50) NULL,
	[Cyc com] [smallint] NULL,
	[Type of failure] [nvarchar](50) NULL
) ON [PRIMARY]

GO
