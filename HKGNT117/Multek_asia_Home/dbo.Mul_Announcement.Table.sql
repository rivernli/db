USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Announcement]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mul_Announcement](
	[Ann_Id] [uniqueidentifier] NOT NULL,
	[Ann_Subject] [nvarchar](100) NOT NULL,
	[Ann_Detail] [nvarchar](2000) NOT NULL,
	[Ann_OnTop] [bit] NOT NULL CONSTRAINT [DF_Mul_Announcement_Ann_OnTop]  DEFAULT ((0)),
	[Ann_Click] [int] NULL,
	[Ann_UpdateBy] [varchar](50) NULL,
	[Ann_UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Mul_Announcement] PRIMARY KEY CLUSTERED 
(
	[Ann_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
