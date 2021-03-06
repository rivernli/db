USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[sa_History_data]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sa_History_data](
	[sCode] [nvarchar](10) NOT NULL,
	[sDate] [date] NOT NULL,
	[sOpenPrice] [decimal](18, 3) NULL,
	[sHighPrice] [decimal](18, 3) NULL,
	[sClostPrice] [decimal](18, 3) NULL,
	[sLowPrice] [decimal](18, 3) NULL,
	[sQuantity] [decimal](18, 0) NULL,
	[sAmount] [decimal](18, 0) NULL,
 CONSTRAINT [PK_sa_History_data] PRIMARY KEY CLUSTERED 
(
	[sCode] ASC,
	[sDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
