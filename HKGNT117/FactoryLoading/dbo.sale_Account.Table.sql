USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[sale_Account]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sale_Account](
	[Account] [int] NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Company] [nvarchar](50) NULL
) ON [PRIMARY]

GO
