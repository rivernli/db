USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[tmp]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp](
	[oem] [char](30) NOT NULL,
	[plant] [varchar](2) NOT NULL,
	[amount] [float] NOT NULL,
	[days] [int] NULL,
	[transit] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
