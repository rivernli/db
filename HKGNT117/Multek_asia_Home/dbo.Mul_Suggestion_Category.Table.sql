USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Suggestion_Category]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mul_Suggestion_Category](
	[Sgc_Id] [int] IDENTITY(1,1) NOT NULL,
	[Sgc_Category] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Mul_Suggestion_Category] PRIMARY KEY CLUSTERED 
(
	[Sgc_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
