USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EHS_Physical_package_type]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EHS_Physical_package_type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[package_type] [nvarchar](50) NULL,
 CONSTRAINT [PK_EHS_Physical_package_type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
