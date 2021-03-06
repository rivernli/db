USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[SuggestionTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuggestionTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[SubjectTime] [datetime] NULL,
	[Viewed] [bit] NULL,
	[IP] [nvarchar](50) NULL,
 CONSTRAINT [PK_SuggestionTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
