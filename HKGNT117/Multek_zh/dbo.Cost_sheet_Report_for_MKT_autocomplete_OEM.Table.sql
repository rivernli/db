USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cost_sheet_Report_for_MKT_autocomplete_OEM]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cost_sheet_Report_for_MKT_autocomplete_OEM](
	[OEM] [char](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Index1]    Script Date: 2014/11/12 17:12:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [Index1] ON [dbo].[Cost_sheet_Report_for_MKT_autocomplete_OEM]
(
	[OEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
