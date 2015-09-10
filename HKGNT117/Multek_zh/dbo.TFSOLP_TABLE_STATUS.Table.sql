USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP_TABLE_STATUS]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TFSOLP_TABLE_STATUS](
	[Table_Qualifier] [varchar](100) NULL,
	[Table_Owner] [varchar](100) NULL,
	[Table_Name] [varchar](100) NULL,
	[Table_Type] [varchar](100) NULL,
	[Remarks] [varchar](100) NULL,
	[SQL_COUNT] [int] NULL,
	[BAAN_COUNT] [int] NULL,
	[DIFF] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
