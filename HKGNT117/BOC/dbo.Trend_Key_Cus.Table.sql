USE [BOC]
GO
/****** Object:  Table [dbo].[Trend_Key_Cus]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trend_Key_Cus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Data_Source] [nvarchar](50) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Fiscal_Year] [int] NOT NULL,
	[Fiscal_Period] [int] NOT NULL,
	[Fiscal_Date] [int] NOT NULL,
	[Plant] [nvarchar](50) NOT NULL,
	[OEM_Code] [nvarchar](50) NULL,
	[Customer] [nvarchar](50) NOT NULL,
	[RType] [nvarchar](50) NOT NULL,
	[TValue] [real] NULL,
 CONSTRAINT [PK_Trend_Key_Cus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Data_Source] ASC,
	[Sequence] ASC,
	[Fiscal_Year] ASC,
	[Fiscal_Period] ASC,
	[Fiscal_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
