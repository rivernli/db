USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cost_Sheet_Query_CS_OEM_Authority]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cost_Sheet_Query_CS_OEM_Authority](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Account] [varchar](50) NULL,
	[OEM] [char](30) NULL,
 CONSTRAINT [PK_Cost_Sheet_Query_CS_OEM_Authority_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
