USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblConsumableStatistics_Total]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblConsumableStatistics_Total](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Supplier] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[Unit] [nvarchar](10) NULL,
	[Usage] [float] NULL,
 CONSTRAINT [PK_tblConsumableStatistics_Total] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
