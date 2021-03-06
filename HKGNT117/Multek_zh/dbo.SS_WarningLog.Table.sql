USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SS_WarningLog]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_WarningLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [varchar](50) NULL,
	[Warning] [nvarchar](1000) NULL,
	[WarningTime] [datetime] NULL CONSTRAINT [DF_SS_WarningLog_WarningTime]  DEFAULT (getdate()),
	[Active] [bit] NULL,
 CONSTRAINT [PK_SS_WarningLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
