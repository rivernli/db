USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KOI_Periodly_Productivity_Image_Layer]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KOI_Periodly_Productivity_Image_Layer](
	[Year] [varchar](4) NOT NULL,
	[Period] [smallint] NOT NULL,
	[Plant] [nvarchar](50) NOT NULL,
	[Sale] [nvarchar](50) NOT NULL,
	[WorkingHours] [numeric](18, 2) NULL,
	[Headcount] [numeric](18, 2) NULL,
	[ALC] [numeric](18, 2) NULL,
	[FGOut_sqft] [numeric](18, 2) NULL,
	[Efficiency] [numeric](18, 2) NULL,
 CONSTRAINT [PK_KOI_Periodly_Productivity_Image_Layer] PRIMARY KEY CLUSTERED 
(
	[Year] ASC,
	[Period] ASC,
	[Plant] ASC,
	[Sale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
