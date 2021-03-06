USE [TransDB117]
GO
/****** Object:  Table [dbo].[TestProcessTime]    Script Date: 2014/11/12 17:15:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TestProcessTime](
	[TargetLinkServer] [varchar](50) NULL,
	[TargetDBName] [varchar](50) NULL,
	[TargetTableName] [varchar](50) NULL,
	[Process] [varchar](500) NULL,
	[DTime] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[TestProcessTime] ADD  CONSTRAINT [DF_TestProcessTime_DTime]  DEFAULT ((0)) FOR [DTime]
GO
