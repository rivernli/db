USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[TFSOLP122180_records]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFSOLP122180_records](
	[Records] [int] NULL,
	[RecordTime] [datetime] NULL CONSTRAINT [DF_TFSOLP122180_records_RecordTime]  DEFAULT (getdate())
) ON [PRIMARY]

GO
