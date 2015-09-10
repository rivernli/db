USE [BOC]
GO
/****** Object:  Table [dbo].[TTDPURItemGroup]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TTDPURItemGroup](
	[ID] [int] NOT NULL,
	[ItemGroup] [nvarchar](50) NULL,
 CONSTRAINT [PK_TTDPURItemGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
