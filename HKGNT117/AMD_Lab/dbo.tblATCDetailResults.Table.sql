USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblATCDetailResults]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblATCDetailResults](
	[failureID] [int] NOT NULL,
	[TN] [int] NULL,
	[BoardID] [nvarchar](50) NULL,
	[TestPattern] [int] NULL,
	[net#] [tinyint] NULL,
	[DC] [nvarchar](10) NULL,
	[TVID] [int] NULL,
	[ATCPreconID] [int] NULL,
	[Status] [nvarchar](50) NULL,
	[CyclestoFail] [smallint] NULL,
	[FA] [bit] NOT NULL,
	[Lot#] [nvarchar](50) NULL,
	[QaunFailNet] [tinyint] NULL
) ON [PRIMARY]

GO
