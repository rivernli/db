USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[B2 Alcatel 4ht and 5th Query]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B2 Alcatel 4ht and 5th Query](
	[CouponID] [int] NOT NULL,
	[CouponName] [nvarchar](50) NULL,
	[TN] [int] NULL,
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
