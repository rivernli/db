USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[sync_Baan_data_Table_List]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sync_Baan_data_Table_List](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [nvarchar](50) NULL,
	[TableCount] [int] NULL,
	[LastUpdateTime] [datetime] NULL,
	[Message] [nvarchar](max) NULL,
	[BeginTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
 CONSTRAINT [PK_sync_Baan_data] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
