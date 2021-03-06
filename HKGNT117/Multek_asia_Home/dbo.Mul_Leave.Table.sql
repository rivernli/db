USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Leave]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mul_Leave](
	[Lv_Id] [int] IDENTITY(1,1) NOT NULL,
	[Lv_Name] [nvarchar](20) NOT NULL,
	[Lv_Description] [nvarchar](50) NOT NULL,
	[Lv_Start] [datetime] NOT NULL,
	[Lv_Return] [datetime] NOT NULL,
	[Lv_UpdateBy] [varchar](50) NULL,
	[Lv_UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Mul_Leave] PRIMARY KEY CLUSTERED 
(
	[Lv_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
