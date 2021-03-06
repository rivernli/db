USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[OrderAnalysis_Users]    Script Date: 11/06/2014 15:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderAnalysis_Users](
	[AutoID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserID] [varchar](100) NOT NULL,
	[Region] [varchar](50) NOT NULL,
	[Account] [varchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[Administrator] [bit] NOT NULL,
	[Enable] [bit] NOT NULL,
 CONSTRAINT [PK_OrderAnalysis_Users_1] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
