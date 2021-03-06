USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblISTConstruction Query]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblISTConstruction Query](
	[CouponName] [nvarchar](50) NULL,
	[tblISTResults_TN] [int] NULL,
	[ConstName] [int] NULL,
	[Precondition Name] [int] NULL,
	[Cycling Name] [int] NULL,
	[Status] [nvarchar](50) NULL,
	[Cyc com] [smallint] NULL,
	[Precodition File name] [nvarchar](50) NULL,
	[Cycling Data File Name] [nvarchar](50) NULL,
	[Construction ID] [int] NOT NULL,
	[# Layers] [tinyint] NULL,
	[Coupon thickness] [decimal](5, 4) NULL,
	[MaterialL] [int] NULL,
	[P1 drill size] [decimal](6, 5) NULL,
	[S1 drill size] [decimal](6, 5) NULL,
	[P2 drill size] [decimal](6, 5) NULL,
	[S2 pad size] [decimal](5, 4) NULL,
	[tblAMDSamples_TN] [int] NULL,
	[Customer] [nvarchar](50) NULL,
	[ProjectName] [nvarchar](50) NULL,
	[location] [int] NULL
) ON [PRIMARY]

GO
