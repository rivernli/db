USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[tMKRPT_ACL]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tMKRPT_ACL](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[GC] [nvarchar](50) NULL,
	[cat] [char](10) NULL,
	[dom] [varchar](50) NULL,
	[uid] [nvarchar](50) NULL,
	[flag] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
