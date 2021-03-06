USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_PhotoNews_Photo]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mul_PhotoNews_Photo](
	[Ph_Id] [int] IDENTITY(1,1) NOT NULL,
	[Ph_Name] [nvarchar](100) NOT NULL,
	[Ph_ReferId] [uniqueidentifier] NOT NULL,
	[Ph_OnHome] [bit] NOT NULL,
	[Ph_Description] [nvarchar](200) NULL,
	[Ph_Path] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Mul_PhotoNews_Photo] PRIMARY KEY NONCLUSTERED 
(
	[Ph_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_Mul_PhotoNews_Photo]    Script Date: 2014/11/12 17:07:58 ******/
CREATE CLUSTERED INDEX [IX_Mul_PhotoNews_Photo] ON [dbo].[Mul_PhotoNews_Photo]
(
	[Ph_ReferId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
