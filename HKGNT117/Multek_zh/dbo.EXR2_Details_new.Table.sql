USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Details_new]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EXR2_Details_new](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[T$CATE] [nvarchar](20) NOT NULL,
	[T$FYER] [nvarchar](10) NULL,
	[T$FPRD] [nvarchar](5) NULL,
	[T$PLNT] [nvarchar](5) NULL,
	[T$ITEM] [nvarchar](32) NULL,
	[T$DSCA] [nvarchar](50) NULL,
	[T$TYPE] [nvarchar](30) NULL,
	[T$CODE] [nvarchar](30) NULL,
	[T$TQUA] [float] NULL,
	[T$PRIC] [float] NULL,
	[T$AMNT] [decimal](18, 4) NULL,
	[T$SQFT] [decimal](18, 4) NULL,
	[T$CESU] [float] NULL,
	[T$CISU] [float] NULL,
	[T$TCIU] [float] NULL,
	[T$TCUU] [float] NULL,
	[T$COPR] [decimal](18, 4) NULL,
	[T$CUPN] [char](30) NULL,
	[T$BUSP] [decimal](18, 4) NULL,
	[T$SERN] [float] NULL,
 CONSTRAINT [PK_EXR2_Details_new] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
