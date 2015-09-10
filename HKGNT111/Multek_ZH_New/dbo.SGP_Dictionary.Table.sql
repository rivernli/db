USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[SGP_Dictionary]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SGP_Dictionary](
	[DID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DictTypeId] [int] NOT NULL,
	[DefineID] [int] NOT NULL,
	[DictValue] [nvarchar](200) NOT NULL
) ON [PRIMARY]
GO
