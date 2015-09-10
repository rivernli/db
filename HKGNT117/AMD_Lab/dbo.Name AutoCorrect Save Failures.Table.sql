USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[Name AutoCorrect Save Failures]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Name AutoCorrect Save Failures](
	[Object Name] [nvarchar](255) NULL,
	[Object Type] [nvarchar](255) NULL,
	[Failure Reason] [nvarchar](255) NULL,
	[Time] [datetime] NULL
) ON [PRIMARY]

GO
