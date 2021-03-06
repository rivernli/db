USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SuggestionBox_Reply]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SuggestionBox_Reply](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PID] [int] NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Description] [nvarchar](max) NULL,
	[Date] [datetime] NULL CONSTRAINT [DF_SuggestionBox_Reply_Date]  DEFAULT (getdate()),
	[IP] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[SuggestionBox_Reply]  WITH CHECK ADD  CONSTRAINT [FK_SuggestionBox_Reply_SuggestionBox] FOREIGN KEY([PID])
REFERENCES [dbo].[SuggestionBox] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SuggestionBox_Reply] CHECK CONSTRAINT [FK_SuggestionBox_Reply_SuggestionBox]
GO
