USE [TransDB117]
GO
/****** Object:  Table [dbo].[Transdb_Table]    Script Date: 2014/11/12 17:15:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transdb_Table](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[DB] [nvarchar](50) NULL,
	[LinkServer] [nvarchar](50) NULL,
	[TableName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
