USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[sgp_item]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sgp_item](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[itype] [nvarchar](50) NULL,
	[item] [nvarchar](150) NULL,
	[flag] [nvarchar](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sgp_item] ADD  DEFAULT ((0)) FOR [flag]
GO
