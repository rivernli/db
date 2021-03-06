USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblQuotes]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblQuotes](
	[Quote#] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[Entity] [nvarchar](50) NULL,
	[Hours] [int] NULL,
	[QuotedDueDate] [datetime] NULL,
	[Notes] [nvarchar](50) NULL,
	[ProductCode] [nvarchar](50) NULL,
	[Approved] [bit] NOT NULL
) ON [PRIMARY]

GO
