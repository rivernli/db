USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblISTLog]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblISTLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TN] [int] NULL,
	[DateReceived] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[FinishDate] [datetime] NULL,
	[MaxCycles] [int] NULL,
	[#samples] [int] NULL,
	[ProjectCode] [nvarchar](50) NULL,
	[Status] [int] NULL,
	[TotalLoads] [smallint] NULL,
	[LoadsDone] [smallint] NULL,
	[days] [tinyint] NULL,
	[notes] [nvarchar](max) NULL,
	[Equipment] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblISTLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
