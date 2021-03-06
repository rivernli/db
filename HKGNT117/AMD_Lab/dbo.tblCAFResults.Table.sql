USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblCAFResults]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCAFResults](
	[CouponID] [int] IDENTITY(1,1) NOT NULL,
	[CoupName] [nvarchar](50) NOT NULL,
	[PTH_GND] [nvarchar](50) NULL,
	[TN] [int] NULL,
	[ConstName] [int] NULL,
	[Init_Res] [real] NULL,
	[StabilizedRes] [real] NULL,
	[Status] [nvarchar](50) NULL,
	[TotHrs] [smallint] NULL,
	[HrsToFail_1Dec] [smallint] NULL,
	[HrsToFail_MinRes] [smallint] NULL,
	[NumberofFail] [tinyint] NULL,
	[LowestObsRes] [real] NULL,
	[FA] [bit] NULL,
	[FAResults] [nvarchar](max) NULL,
	[FAAnalyst] [nvarchar](50) NULL,
	[FALocation] [nvarchar](50) NULL,
	[FAPPorCORE] [nvarchar](50) NULL,
	[FADate] [datetime] NULL,
 CONSTRAINT [PK_tblCAFResults] PRIMARY KEY CLUSTERED 
(
	[CouponID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
