USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[OnHoldOrders_Log]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OnHoldOrders_Log](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](50) NULL,
	[IP] [varchar](50) NULL,
	[Action] [varchar](50) NULL,
	[ActionDate] [datetime] NULL,
	[ActionUrl] [varchar](500) NULL,
	[ActionDetail] [varchar](2000) NULL,
 CONSTRAINT [PK_OnHoldOrders_Log] PRIMARY KEY NONCLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IX_OnHoldOrders_Log]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_OnHoldOrders_Log] ON [dbo].[OnHoldOrders_Log]
(
	[ActionDate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
