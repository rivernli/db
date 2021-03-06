USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblConsumableStatistics]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblConsumableStatistics](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Supplier] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[Type] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[StoreStatus] [nvarchar](50) NULL,
	[Operator] [nvarchar](50) NULL,
	[Quantity] [float] NULL,
	[Unit] [nvarchar](10) NULL,
	[Purpose] [nvarchar](200) NULL,
	[Remark] [nvarchar](500) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_tbConsumableStatistics] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
