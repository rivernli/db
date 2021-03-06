USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[vote_Inviate_Users]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vote_Inviate_Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[voteID] [int] NULL,
	[Domain] [nvarchar](50) NULL,
	[Account] [nvarchar](50) NULL,
	[FullName] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Telephone] [nvarchar](50) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[Status] [bit] NULL CONSTRAINT [DF_vote_Inviate_Users_Status]  DEFAULT ((0)),
 CONSTRAINT [PK_vote_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
