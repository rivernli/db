USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[vote_General]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vote_General](
	[vote_ID] [int] IDENTITY(1,1) NOT NULL,
	[vote_Name] [nvarchar](500) NULL,
	[endDate] [datetime] NULL,
	[Remark] [nvarchar](400) NULL,
	[AddDate] [datetime] NULL,
 CONSTRAINT [PK_vote_Total] PRIMARY KEY CLUSTERED 
(
	[vote_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
