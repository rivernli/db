USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[testTable]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[testTable](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[item] [nvarchar](50) NULL,
	[cust] [nvarchar](50) NULL,
	[plnt] [nchar](10) NULL
) ON [PRIMARY]

GO
