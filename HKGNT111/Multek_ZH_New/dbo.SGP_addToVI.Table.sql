USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[SGP_addToVI]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SGP_addToVI](
	[id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[gpid] [nvarchar](50) NULL,
	[programme] [nvarchar](50) NULL
) ON [PRIMARY]
GO
