USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[OrderAnalysis_Menu]    Script Date: 11/06/2014 15:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderAnalysis_Menu](
	[ID] [varchar](500) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Page] [varchar](max) NULL,
 CONSTRAINT [PK_OrderAnalysis_Menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
