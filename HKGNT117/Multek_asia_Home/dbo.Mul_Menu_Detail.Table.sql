USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Menu_Detail]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mul_Menu_Detail](
	[Mnd_Id] [int] IDENTITY(1,1) NOT NULL,
	[Mnd_MnId] [int] NULL,
	[Mnd_ParentId] [int] NULL,
	[Mnd_LevelId] [int] NULL,
	[Mnd_SortId] [int] NULL,
	[Mnd_Title] [nvarchar](50) NULL,
	[Mnd_Url] [nvarchar](500) NULL,
	[Mnd_Target] [varchar](20) NULL,
	[Mnd_Active] [bit] NULL,
	[Mnd_CreateBy] [varchar](50) NULL,
	[Mnd_CreateDate] [datetime] NULL,
 CONSTRAINT [PK_Mul_Menu_Detail] PRIMARY KEY NONCLUSTERED 
(
	[Mnd_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IX_Mul_Menu_Detail_MnId]    Script Date: 2014/11/12 17:07:58 ******/
CREATE CLUSTERED INDEX [IX_Mul_Menu_Detail_MnId] ON [dbo].[Mul_Menu_Detail]
(
	[Mnd_MnId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Mul_Menu_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Mul_Menu_MnId] FOREIGN KEY([Mnd_MnId])
REFERENCES [dbo].[Mul_Menu] ([Mn_Id])
GO
ALTER TABLE [dbo].[Mul_Menu_Detail] CHECK CONSTRAINT [FK_Mul_Menu_MnId]
GO
