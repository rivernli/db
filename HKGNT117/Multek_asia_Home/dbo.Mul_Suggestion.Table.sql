USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Suggestion]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mul_Suggestion](
	[Sug_Id] [int] IDENTITY(1,1) NOT NULL,
	[Sug_CategoryId] [int] NOT NULL,
	[Sug_Subject] [nvarchar](200) NOT NULL,
	[Sug_Description] [nvarchar](4000) NOT NULL,
	[Sug_Ip] [varchar](20) NOT NULL,
	[Sug_UpdateBy] [varchar](50) NULL,
	[Sug_UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Mul_Suggestion] PRIMARY KEY CLUSTERED 
(
	[Sug_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
