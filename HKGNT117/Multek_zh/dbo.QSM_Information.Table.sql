USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[QSM_Information]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QSM_Information](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeID] [varchar](50) NULL,
	[Title] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [varchar](50) NULL,
	[LaunchTime] [varchar](20) NULL,
 CONSTRAINT [PK_QSM_Information] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
