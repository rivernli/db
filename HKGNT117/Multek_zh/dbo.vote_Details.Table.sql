USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[vote_Details]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vote_Details](
	[ID] [int] NOT NULL,
	[vote_ID] [int] NOT NULL,
	[voteNumber] [int] NULL,
	[vote_detailID] [char](10) NULL,
	[voteItem] [nvarchar](20) NULL,
	[voteNum] [int] NULL,
 CONSTRAINT [PK_vote_Details] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[vote_Details]  WITH CHECK ADD  CONSTRAINT [FK_vote_Details_vote_General] FOREIGN KEY([vote_ID])
REFERENCES [dbo].[vote_General] ([vote_ID])
GO
ALTER TABLE [dbo].[vote_Details] CHECK CONSTRAINT [FK_vote_Details_vote_General]
GO
