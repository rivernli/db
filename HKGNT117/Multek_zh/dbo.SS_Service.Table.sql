USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SS_Service]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_Service](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [int] NOT NULL,
	[ServiceName] [varchar](50) NOT NULL,
	[Enabled] [bit] NULL CONSTRAINT [DF_SS_Service_Enabled]  DEFAULT ((0)),
	[Status] [nvarchar](100) NULL,
	[AutoStart] [bit] NULL CONSTRAINT [DF_SS_Service_AutoStart]  DEFAULT ((0)),
	[UpdateTime] [varchar](20) NULL,
 CONSTRAINT [PK_SS_Service] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
