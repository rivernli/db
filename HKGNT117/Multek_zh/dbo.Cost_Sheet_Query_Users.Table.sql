USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cost_Sheet_Query_Users]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cost_Sheet_Query_Users](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[Region] [varchar](50) NOT NULL,
	[Account] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[BDM] [varchar](50) NOT NULL,
	[department] [nvarchar](50) NULL,
	[jobTitle] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[Mobile] [nvarchar](50) NULL,
	[Administrator] [bit] NOT NULL,
	[Enable] [bit] NOT NULL,
	[hideFrLog] [bit] NOT NULL,
 CONSTRAINT [PK_Cost_Sheet_Query_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Cost_Sheet_Query_Users] UNIQUE NONCLUSTERED 
(
	[Account] ASC,
	[Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
