USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KPI_Users]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KPI_Users](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[Region] [varchar](50) NOT NULL,
	[Account] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[BDM] [varchar](50) NOT NULL,
	[Administrator] [bit] NOT NULL CONSTRAINT [DF_KPI_Users_Administrator]  DEFAULT ((0)),
	[Enable] [bit] NOT NULL CONSTRAINT [DF_KPI_System_Users_Disable]  DEFAULT ((1)),
	[department] [nvarchar](50) NULL,
	[jobTitle] [nvarchar](50) NULL,
	[fax] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[sitesAccess] [nvarchar](250) NULL,
	[creationDate] [datetime] NULL,
	[createdBy] [nvarchar](50) NULL,
	[lastModifyDate] [datetime] NULL,
	[lastModifiedBy] [nvarchar](50) NULL,
	[hideFrLog] [bit] NULL,
 CONSTRAINT [PK_KPI_System_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PK_KPI_UK_Users] UNIQUE NONCLUSTERED 
(
	[Account] ASC,
	[Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
