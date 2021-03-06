USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MI_Report]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MI_Report](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[RepNo] [nvarchar](50) NULL,
	[PN] [nvarchar](50) NULL,
	[CustormerPN] [nvarchar](50) NULL,
	[CustormerName] [nvarchar](50) NULL,
	[LotNo] [nvarchar](50) NULL,
	[LotQty] [int] NULL,
	[DateCode] [nvarchar](50) NULL,
	[Sepcimen] [nvarchar](50) NULL,
	[TIme] [datetime] NULL,
	[Rev] [nvarchar](50) NULL,
	[Remarks] [nchar](10) NULL,
	[Conclusion] [nvarchar](50) NULL,
	[Inspected] [nvarchar](50) NULL,
	[Inspected_Date] [datetime] NULL,
	[Approved] [nvarchar](50) NULL,
	[Approved_Date] [datetime] NULL,
	[Condition] [nvarchar](50) NULL,
	[Parameter] [nvarchar](50) NULL
) ON [PRIMARY]

GO
