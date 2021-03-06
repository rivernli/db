USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[shipment_backlog_oem]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[shipment_backlog_oem](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[manager] [nvarchar](50) NULL,
	[muid] [nvarchar](50) NULL,
	[salesman] [nvarchar](50) NULL,
	[suid] [nvarchar](50) NULL,
	[oem] [nvarchar](200) NULL,
	[flag] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [oem]    Script Date: 2014/11/12 17:13:32 ******/
CREATE NONCLUSTERED INDEX [oem] ON [dbo].[shipment_backlog_oem]
(
	[oem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
