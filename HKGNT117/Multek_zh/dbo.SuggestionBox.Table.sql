USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SuggestionBox]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SuggestionBox](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](1000) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Email] [varchar](500) NULL,
	[Description] [nvarchar](max) NULL,
	[Date] [datetime] NULL CONSTRAINT [DF_SuggestionBox_Date]  DEFAULT (getdate()),
	[IP] [varchar](50) NULL CONSTRAINT [DF_SuggestionBox_IP]  DEFAULT (getdate()),
	[Views] [int] NULL CONSTRAINT [DF_SuggestionBox_Views]  DEFAULT ((0)),
 CONSTRAINT [PK_SuggestionBox] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
