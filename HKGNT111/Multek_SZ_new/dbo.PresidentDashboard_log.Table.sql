USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[PresidentDashboard_log]    Script Date: 11/06/2014 15:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PresidentDashboard_log](
	[log_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[uid] [nvarchar](20) NOT NULL,
	[actionTime] [datetime] NOT NULL,
	[action] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NULL,
	[url] [nvarchar](250) NULL,
	[session_id] [nvarchar](100) NULL,
 CONSTRAINT [PK_PresidentDashboard_log] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PresidentDashboard_log] ADD  DEFAULT (getdate()) FOR [actionTime]
GO
