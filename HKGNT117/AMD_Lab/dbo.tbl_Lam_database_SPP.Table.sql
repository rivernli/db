USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tbl_Lam_database_SPP]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Lam_database_SPP](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PId] [int] NULL,
	[Df_for_S3] [nvarchar](50) NULL,
	[DataSheet] [nvarchar](50) NULL,
	[AMD] [nvarchar](50) NULL,
	[TN] [nvarchar](50) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Lam_database_SPP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
