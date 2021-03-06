USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[sgp_acl]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sgp_acl](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[uid] [nvarchar](50) NULL,
	[name] [nvarchar](50) NULL,
	[manager] [nvarchar](50) NULL,
	[company] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[fax] [nvarchar](50) NULL,
	[cellphone] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[dom] [nvarchar](50) NULL,
	[status] [char](10) NULL,
	[memail] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
