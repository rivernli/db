USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[InviteTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InviteTable](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[awage] [nvarchar](50) NULL,
	[stopdate] [datetime] NULL,
	[schoolage] [nvarchar](50) NULL,
	[language] [nvarchar](50) NULL,
	[speciality] [nvarchar](50) NULL,
	[sex] [nvarchar](50) NULL,
	[worktime] [nvarchar](50) NULL,
	[age] [nvarchar](50) NULL,
	[num] [nvarchar](50) NULL,
	[publictime] [datetime] NULL,
	[explain] [nvarchar](50) NULL,
	[show] [bit] NOT NULL
) ON [PRIMARY]

GO
