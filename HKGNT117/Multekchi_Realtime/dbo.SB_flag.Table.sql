USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[SB_flag]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_flag](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[flag] [nchar](1) NULL CONSTRAINT [DF_SB_flag_flag]  DEFAULT ((1))
) ON [PRIMARY]

GO
