USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[MRBST_Suggestion]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MRBST_Suggestion](
	[SuggestionType] [varchar](50) NOT NULL,
	[SuggestionString] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
