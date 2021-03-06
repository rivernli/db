USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cost_sheet_Report_for_MKT_autocomplete_Project]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cost_sheet_Report_for_MKT_autocomplete_Project](
	[t$pjno] [char](10) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Index]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [Index] ON [dbo].[Cost_sheet_Report_for_MKT_autocomplete_Project]
(
	[t$pjno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
