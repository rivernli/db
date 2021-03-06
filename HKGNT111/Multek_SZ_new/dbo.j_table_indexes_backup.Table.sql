USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[j_table_indexes_backup]    Script Date: 11/06/2014 15:47:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[j_table_indexes_backup](
	[index_name] [nvarchar](255) NULL,
	[index_description] [nvarchar](max) NULL,
	[index_keys] [nvarchar](255) NULL,
	[query] [nvarchar](max) NULL,
	[key_type] [nvarchar](50) NULL,
	[table_name] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
