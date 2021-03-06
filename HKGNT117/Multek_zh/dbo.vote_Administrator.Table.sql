USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[vote_Administrator]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vote_Administrator](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[vote_ID] [int] NULL,
	[Domain] [nvarchar](50) NULL,
	[Account] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_vote_Administrator] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[vote_Administrator]  WITH CHECK ADD  CONSTRAINT [FK_vote_Administrator_vote_General] FOREIGN KEY([vote_ID])
REFERENCES [dbo].[vote_General] ([vote_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[vote_Administrator] CHECK CONSTRAINT [FK_vote_Administrator_vote_General]
GO
