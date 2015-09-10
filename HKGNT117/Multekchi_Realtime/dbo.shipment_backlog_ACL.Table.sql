USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[shipment_backlog_ACL]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shipment_backlog_ACL](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[manager] [nvarchar](50) NULL,
	[muid] [nvarchar](50) NULL,
	[salesman] [nvarchar](50) NULL,
	[suid] [nvarchar](50) NULL
) ON [PRIMARY]

GO
