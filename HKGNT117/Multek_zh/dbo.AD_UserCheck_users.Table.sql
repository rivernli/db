USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[AD_UserCheck_users]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AD_UserCheck_users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WrokDay_ID] [nvarchar](50) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[Windows_ID] [nvarchar](50) NULL,
	[CN_Name] [nvarchar](50) NULL
) ON [PRIMARY]

GO
