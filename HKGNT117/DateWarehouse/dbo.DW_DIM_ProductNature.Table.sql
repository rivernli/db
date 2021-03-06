USE [DataWarehouse]
GO
/****** Object:  Table [dbo].[DW_DIM_ProductNature]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DW_DIM_ProductNature](
	[Code] [nvarchar](5) NOT NULL,
	[Attribute] [nvarchar](50) NULL,
 CONSTRAINT [PK_DW_DIM_ProductNature] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
