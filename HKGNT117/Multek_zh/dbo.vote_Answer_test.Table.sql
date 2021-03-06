USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[vote_Answer_test]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vote_Answer_test](
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
