USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SuggestionBox_Log]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SuggestionBox_Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Account] [varchar](50) NULL,
	[IP] [varchar](50) NULL,
	[Time] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[SuggestionBox_Log] ADD  CONSTRAINT [DF_SuggestionBox_Log_Time]  DEFAULT (getdate()) FOR [Time]
GO
