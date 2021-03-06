USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[sa_List_all]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sa_List_all](
	[sCode] [nvarchar](10) NOT NULL,
	[sName] [nvarchar](10) NOT NULL,
	[sType] [nvarchar](10) NULL,
 CONSTRAINT [PK_sa_List_all] PRIMARY KEY CLUSTERED 
(
	[sCode] ASC,
	[sName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
