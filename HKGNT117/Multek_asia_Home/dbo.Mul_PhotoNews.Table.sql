USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_PhotoNews]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mul_PhotoNews](
	[Pn_Id] [uniqueidentifier] NOT NULL,
	[Pn_Subject] [nvarchar](100) NOT NULL,
	[Pn_Detail] [nvarchar](4000) NOT NULL,
	[Pn_Draft] [bit] NOT NULL,
	[Pn_UpdateBy] [varchar](50) NULL,
	[Pn_UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Mul_PhotoNews] PRIMARY KEY CLUSTERED 
(
	[Pn_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
