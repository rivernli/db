USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[vote_Answer]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vote_Answer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[vote_ID] [int] NULL,
	[Num] [nvarchar](50) NULL,
	[Idate] [datetime] NULL,
	[HostName] [nvarchar](50) NULL,
	[LogonName] [nvarchar](50) NULL,
	[voteNumber] [int] NULL,
	[vote_detailID] [char](10) NULL,
	[comment] [nvarchar](200) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[vote_Answer]  WITH CHECK ADD  CONSTRAINT [FK_vote_Answer_vote_General] FOREIGN KEY([vote_ID])
REFERENCES [dbo].[vote_General] ([vote_ID])
GO
ALTER TABLE [dbo].[vote_Answer] CHECK CONSTRAINT [FK_vote_Answer_vote_General]
GO
