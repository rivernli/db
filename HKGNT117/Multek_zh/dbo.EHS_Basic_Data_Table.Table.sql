USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EHS_Basic_Data_Table]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EHS_Basic_Data_Table](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Medical_type] [nvarchar](50) NULL,
	[Post_Begin] [int] NULL CONSTRAINT [DF_EHS_Basic_Data_Table_Post_Begin]  DEFAULT ((0)),
	[Posting] [int] NULL,
	[Post_End] [int] NULL,
	[Medical_cycle] [int] NULL,
 CONSTRAINT [PK_EHS_aa] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
