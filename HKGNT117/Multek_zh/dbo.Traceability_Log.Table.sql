USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Traceability_Log]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Traceability_Log](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[domain] [nvarchar](50) NULL,
	[uid] [nvarchar](50) NOT NULL,
	[actionTime] [datetime] NOT NULL,
	[action] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NULL,
	[url] [nvarchar](250) NULL,
	[session_id] [nvarchar](100) NULL,
 CONSTRAINT [PK_Traceability_log] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
