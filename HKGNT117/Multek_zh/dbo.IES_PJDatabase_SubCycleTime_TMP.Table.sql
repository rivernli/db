USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_PJDatabase_SubCycleTime_TMP]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_PJDatabase_SubCycleTime_TMP](
	[PJID] [int] NOT NULL,
	[PBPID] [int] NOT NULL,
	[WorkCenter] [varchar](20) NULL,
	[CycleTime] [decimal](18, 4) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
