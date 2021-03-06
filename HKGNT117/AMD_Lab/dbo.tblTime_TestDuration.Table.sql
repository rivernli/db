USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblTime_TestDuration]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTime_TestDuration](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TN] [int] NULL,
	[Date] [datetime] NULL,
	[StartHors] [varchar](2) NULL,
	[StartMinute] [varchar](2) NULL,
	[EndHors] [varchar](2) NULL,
	[EndMinute] [varchar](2) NULL,
	[Calculations] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_tblTime_TestDuration] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
