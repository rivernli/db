USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblISTResults]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblISTResults](
	[CouponID] [int] IDENTITY(1,1) NOT NULL,
	[CouponName] [nvarchar](50) NULL,
	[DC] [nvarchar](10) NULL,
	[TN] [int] NULL,
	[ConstName] [int] NULL,
	[Precondition Name] [int] NULL,
	[Cycling Name] [int] NULL,
	[Registration] [tinyint] NULL,
	[P1 ohms prescreen] [smallint] NULL,
	[P2 ohms prescreen] [smallint] NULL,
	[S1 ohms prescreen] [smallint] NULL,
	[S2 ohms prescreen] [smallint] NULL,
	[Selected for IST cycling] [bit] NOT NULL,
	[Prescreening Notes] [nvarchar](max) NULL,
	[Status] [nvarchar](50) NULL,
	[Cyc com] [smallint] NULL,
	[Precodition File name] [nvarchar](50) NULL,
	[Cycling Data File Name] [nvarchar](50) NULL,
	[FA] [bit] NOT NULL,
	[Type of failure] [nvarchar](50) NULL,
	[Returned?] [bit] NOT NULL,
 CONSTRAINT [PK_tblISTResults] PRIMARY KEY CLUSTERED 
(
	[CouponID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
