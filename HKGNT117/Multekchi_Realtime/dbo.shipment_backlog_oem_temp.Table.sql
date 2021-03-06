USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[shipment_backlog_oem_temp]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[shipment_backlog_oem_temp](
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
