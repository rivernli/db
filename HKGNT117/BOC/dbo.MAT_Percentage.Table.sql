USE [BOC]
GO
/****** Object:  Table [dbo].[MAT_Percentage]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAT_Percentage](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Operators] [nvarchar](50) NULL,
	[Value] [decimal](18, 2) NULL,
	[Text] [nvarchar](50) NULL,
	[ForeColor] [nvarchar](50) NULL,
	[Show] [bit] NULL,
	[Plant] [nvarchar](50) NULL,
	[Report] [nvarchar](50) NULL,
 CONSTRAINT [PK_MAT_Percentage] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
