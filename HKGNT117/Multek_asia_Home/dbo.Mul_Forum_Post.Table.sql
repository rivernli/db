USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Forum_Post]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mul_Forum_Post](
	[PostId] [uniqueidentifier] NOT NULL,
	[FcId] [uniqueidentifier] NOT NULL,
	[ParentPostId] [uniqueidentifier] NULL,
	[Subject] [nvarchar](200) NOT NULL,
	[Message] [nvarchar](4000) NOT NULL,
	[PostedOn] [datetime] NULL,
	[PostedBy] [varchar](50) NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Views] [int] NULL,
 CONSTRAINT [PK_Mul_Forum_Post] PRIMARY KEY NONCLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
