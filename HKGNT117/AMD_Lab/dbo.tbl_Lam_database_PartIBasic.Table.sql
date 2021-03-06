USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tbl_Lam_database_PartIBasic]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Lam_database_PartIBasic](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UpdateDate] [datetime] NULL,
	[NextUpdateDate] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[Supplier] [nvarchar](50) NULL,
	[DataSheet] [varchar](2) NULL,
	[EDX] [varchar](2) NULL,
	[ProductName] [nvarchar](50) NULL,
	[Tg] [varchar](50) NULL,
	[FTIR] [varchar](2) NULL,
	[Manufactory] [nvarchar](50) NULL,
	[Loss] [varchar](50) NULL,
	[FTIR_TGA] [varchar](2) NULL,
	[Status] [varchar](50) NULL,
	[HF] [varchar](2) NULL,
	[SPP] [varchar](2) NULL,
 CONSTRAINT [PK_tbl_Lam_database_PartIBasic] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
