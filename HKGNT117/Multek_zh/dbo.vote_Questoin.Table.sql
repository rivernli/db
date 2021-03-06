USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[vote_Questoin]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vote_Questoin](
	[vote_ID] [int] NULL,
	[voteNumber] [int] NULL,
	[voteTitle] [nvarchar](100) NULL,
	[voteSum] [int] NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[vote_Questoin]  WITH CHECK ADD  CONSTRAINT [FK_vote_Questoin_vote_General] FOREIGN KEY([vote_ID])
REFERENCES [dbo].[vote_General] ([vote_ID])
GO
ALTER TABLE [dbo].[vote_Questoin] CHECK CONSTRAINT [FK_vote_Questoin_vote_General]
GO
