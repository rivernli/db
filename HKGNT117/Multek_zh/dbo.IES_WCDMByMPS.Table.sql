USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_WCDMByMPS]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_WCDMByMPS](
	[MPSID] [int] NOT NULL,
	[WorkCenter] [varchar](50) NOT NULL,
	[SqFt] [decimal](18, 2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
