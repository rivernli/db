USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[MRBST_User]    Script Date: 11/06/2014 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MRBST_User](
	[Account] [varchar](50) NOT NULL,
	[Domain] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MRBST_User] PRIMARY KEY CLUSTERED 
(
	[Account] ASC,
	[Domain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
