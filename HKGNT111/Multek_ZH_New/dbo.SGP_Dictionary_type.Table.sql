USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[SGP_Dictionary_type]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SGP_Dictionary_type](
	[DTID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DictionaryType] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
