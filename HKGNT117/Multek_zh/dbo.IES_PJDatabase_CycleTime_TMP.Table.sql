USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_PJDatabase_CycleTime_TMP]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IES_PJDatabase_CycleTime_TMP](
	[PJID] [int] NOT NULL,
	[PBPID] [int] NOT NULL,
	[CycleTime] [decimal](18, 4) NULL
) ON [PRIMARY]

GO
