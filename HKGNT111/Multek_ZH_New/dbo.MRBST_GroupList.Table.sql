USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[MRBST_GroupList]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MRBST_GroupList](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Plant] [varchar](50) NULL,
	[GroupName] [nvarchar](50) NULL,
	[GroupList] [varchar](500) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
