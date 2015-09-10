USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MRBST_GroupList]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MRBST_GroupList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Plant] [varchar](50) NULL,
	[GroupName] [nvarchar](50) NULL,
	[GroupList] [varchar](500) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
