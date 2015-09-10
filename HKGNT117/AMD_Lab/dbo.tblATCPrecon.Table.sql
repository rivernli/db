USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblATCPrecon]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblATCPrecon](
	[ATCPreconID] [int] NOT NULL,
	[ReflowProfileName] [nvarchar](8) NOT NULL,
	[ReflowX] [tinyint] NULL,
	[PeakTemp] [smallint] NULL,
	[Notes] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
