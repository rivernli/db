USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[QSM_Users]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QSM_Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Account] [varchar](20) NULL,
	[Domain] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
