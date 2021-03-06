USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cost_Sheet_Query_Material_Type]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cost_Sheet_Query_Material_Type](
	[MaterialCode] [float] NOT NULL,
	[Material] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](10) NULL,
	[SN] [int] NULL,
 CONSTRAINT [PK_Cost_Sheet_Query_Material_Type] PRIMARY KEY CLUSTERED 
(
	[Material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
