USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Gadget]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mul_Gadget](
	[Gg_Id] [int] IDENTITY(1,1) NOT NULL,
	[Gg_Title] [nvarchar](50) NOT NULL,
	[Gg_Description] [nvarchar](500) NULL,
	[Gg_Url] [nvarchar](100) NOT NULL,
	[Gg_Col] [int] NOT NULL,
	[Gg_SortId] [int] NOT NULL,
	[Gg_Category] [int] NOT NULL,
 CONSTRAINT [PK_Mul_Gadget] PRIMARY KEY CLUSTERED 
(
	[Gg_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Mul_Gadget_Title] UNIQUE NONCLUSTERED 
(
	[Gg_Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
