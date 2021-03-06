USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[VI_Report_Shipped_All_Daily]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VI_Report_Shipped_All_Daily](
	[Site] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Day] [datetime] NOT NULL,
	[Amount] [decimal](18, 3) NOT NULL,
 CONSTRAINT [PK_VIReport_Shipped_All_Daily] PRIMARY KEY CLUSTERED 
(
	[Site] ASC,
	[Plant] ASC,
	[Day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
