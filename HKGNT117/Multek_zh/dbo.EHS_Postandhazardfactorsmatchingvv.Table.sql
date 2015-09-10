USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EHS_Postandhazardfactorsmatchingvv]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EHS_Postandhazardfactorsmatchingvv](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Post_operation_content] [nvarchar](100) NULL,
	[adverse_factor_1] [nvarchar](50) NULL,
	[adverse_factor_2] [nvarchar](50) NULL,
	[adverse_factor_3] [nvarchar](50) NULL,
	[adverse_factor_4] [nvarchar](50) NULL,
	[adverse_factor_5] [nvarchar](50) NULL,
	[adverse_factor_6] [nvarchar](50) NULL,
	[adverse_factor_7] [nvarchar](50) NULL,
	[adverse_factor_8] [nvarchar](50) NULL,
	[adverse_factor_9] [nvarchar](50) NULL,
	[adverse_factor_10] [nvarchar](50) NULL,
	[adverse_factor_11] [nvarchar](50) NULL,
	[adverse_factor_12] [nvarchar](50) NULL,
	[adverse_factor_13] [nvarchar](50) NULL,
	[adverse_factor_14] [nvarchar](50) NULL,
	[Post_medical_package_Id] [nvarchar](50) NULL
) ON [PRIMARY]

GO
