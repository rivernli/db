USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_Country]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_Country](
	[Code] [varchar](3) NOT NULL,
	[Name] [varchar](50) NULL,
	[Continent] [varchar](50) NULL,
 CONSTRAINT [PK_DistributionReport_Country] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
