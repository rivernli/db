USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_ProcessLT]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_ProcessLT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](50) NULL,
	[SubWorkCenter] [varchar](20) NOT NULL,
	[EnglishName] [varchar](50) NULL,
	[ChineseName] [nvarchar](50) NULL,
	[LT] [decimal](18, 2) NULL,
	[QTALT] [decimal](18, 2) NULL,
	[Core2] [decimal](18, 2) NULL,
	[Core3] [decimal](18, 2) NULL,
	[Core4] [decimal](18, 2) NULL,
	[Core5] [decimal](18, 2) NULL,
	[Core6] [decimal](18, 2) NULL,
	[Core7] [decimal](18, 2) NULL,
	[Core8] [decimal](18, 2) NULL,
	[Core9] [decimal](18, 2) NULL,
	[Core10] [decimal](18, 2) NULL,
	[Core11] [decimal](18, 2) NULL,
	[Core12] [decimal](18, 2) NULL,
	[UCT] [int] NOT NULL CONSTRAINT [DF_IES_ProcessLT_UCT]  DEFAULT ((0)),
	[LOTSize] [int] NOT NULL CONSTRAINT [DF_IES_ProcessLT_LOTSize]  DEFAULT ((0)),
	[WaittingTime] [decimal](18, 2) NOT NULL CONSTRAINT [DF_IES_ProcessLT_WaittingTime]  DEFAULT ((0)),
 CONSTRAINT [PK_IES_ProcessLT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
