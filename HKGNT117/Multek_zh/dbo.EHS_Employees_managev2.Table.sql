USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EHS_Employees_managev2]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EHS_Employees_managev2](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[departmentId] [int] NULL,
	[PostId] [int] NULL,
	[Staff_ID] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Arrive_date] [datetime] NULL,
	[ID_card_number] [nvarchar](50) NULL,
	[corporation] [nvarchar](50) NULL,
	[Medical_type] [varchar](50) NULL,
	[dimission_Medical] [varchar](1) NULL CONSTRAINT [DF_EHS_Employees_manage_dimission_Medical]  DEFAULT ((0)),
	[Remark] [nvarchar](max) NULL,
	[OperateUser] [nvarchar](50) NULL,
	[OperateDate] [datetime] NULL,
	[Departure_medical_package] [nvarchar](100) NULL,
	[Post_medical_package_Id] [nvarchar](50) NULL,
	[Departure_Date] [datetime] NULL,
 CONSTRAINT [PK_EHS_Employees_manage_1] PRIMARY KEY CLUSTERED 
(
	[Staff_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
