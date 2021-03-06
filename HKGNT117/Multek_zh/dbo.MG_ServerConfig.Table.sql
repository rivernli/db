USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MG_ServerConfig]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MG_ServerConfig](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](50) NULL,
	[Address] [varchar](200) NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](100) NULL,
	[Enabled] [bit] NULL CONSTRAINT [DF_ServerConfig_Enabled]  DEFAULT ((0)),
 CONSTRAINT [PK_ServerConfig] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
