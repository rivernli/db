USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblATCResults]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblATCResults](
	[ResultsID] [int] NOT NULL,
	[ATCProfileID] [int] NULL,
	[TN] [int] NULL,
	[TotalCycles] [smallint] NULL,
	[Status] [nvarchar](50) NULL,
	[QuanPass] [smallint] NULL,
	[QuanFail] [smallint] NULL,
	[Notes] [nvarchar](max) NULL,
	[QuanCards] [smallint] NULL,
	[QuanTP] [smallint] NULL,
	[QuanNets] [smallint] NULL,
	[DCs] [nvarchar](50) NULL,
	[Lot#s] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
