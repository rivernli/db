USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KOI_Yearly_Attrition_rate_vs_MRB_rate]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[KOI_Yearly_Attrition_rate_vs_MRB_rate](
	[ReportCode] [varchar](3) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[Plant] [nvarchar](50) NOT NULL,
	[Attrition_rate] [numeric](18, 2) NULL,
	[MRB_rate] [numeric](18, 2) NULL,
 CONSTRAINT [PK_KOI_Yearly_Attrition_rate_vs_MRB_rate] PRIMARY KEY CLUSTERED 
(
	[ReportCode] ASC,
	[Year] ASC,
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
