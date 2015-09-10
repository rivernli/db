USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[out_in_backlog]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[out_in_backlog](
	[oem] [char](30) NULL,
	[plant] [varchar](2) NULL,
	[oamt] [float] NOT NULL,
	[iamt] [float] NOT NULL,
	[fg_ava] [float] NOT NULL,
	[fg_amt] [float] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
