USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Scrap_Sales_ItemsGroup]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Scrap_Sales_ItemsGroup](
	[No] [nchar](6) NOT NULL,
	[Group1] [nvarchar](50) NOT NULL,
	[Group2] [nvarchar](50) NOT NULL,
	[chiName] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[remark] [nvarchar](255) NULL,
 CONSTRAINT [PK_Scrap_Sales_ItemsGroup] PRIMARY KEY CLUSTERED 
(
	[No] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
