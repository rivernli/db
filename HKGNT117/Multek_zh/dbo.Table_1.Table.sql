USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Table_1]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_1](
	[item] [nvarchar](50) NULL,
	[man] [nvarchar](50) NULL,
	[fman] [nvarchar](50) NULL,
	[manp] [nvarchar](50) NULL,
	[fmanpn] [nvarchar](50) NULL,
	[flag] [int] NULL,
	[flag2] [int] NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Table_1] ADD  CONSTRAINT [DF_Table_1_flag]  DEFAULT ((1)) FOR [flag]
GO
