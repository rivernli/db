USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_Log]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Operator] [varchar](50) NULL,
	[Operation] [varchar](50) NULL,
	[IP] [varchar](50) NULL,
	[Remark] [varchar](500) NULL,
	[Date] [datetime] NULL CONSTRAINT [DF_IES_Log_Date]  DEFAULT (getdate()),
 CONSTRAINT [PK_IES_Log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
