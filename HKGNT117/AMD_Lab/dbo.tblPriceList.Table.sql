USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblPriceList]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPriceList](
	[ProductCode] [nvarchar](50) NULL,
	[CategoryID] [nvarchar](50) NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[ProductDescription] [nvarchar](max) NULL,
	[UnitPrice] [money] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
