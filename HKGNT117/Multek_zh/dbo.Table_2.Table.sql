USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Table_2]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_2](
	[item] [nvarchar](50) NULL,
	[man] [nvarchar](50) NULL,
	[manp] [nvarchar](50) NULL,
	[flag] [int] NULL CONSTRAINT [DF_Table_2_flag]  DEFAULT ((2))
) ON [PRIMARY]

GO
