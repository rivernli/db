USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Menu]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mul_Menu](
	[Mn_Id] [int] IDENTITY(1,1) NOT NULL,
	[Mn_Title] [nvarchar](50) NOT NULL,
	[Mn_Description] [nvarchar](500) NULL,
	[Mn_CreateBy] [varchar](50) NOT NULL,
	[Mn_CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Mul_Menu] PRIMARY KEY CLUSTERED 
(
	[Mn_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
