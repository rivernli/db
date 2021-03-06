USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EHS_physical_examination_Total_table_bk]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EHS_physical_examination_Total_table_bk](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Employees_Id] [int] NULL,
	[mLsh] [nvarchar](50) NULL,
	[department] [nvarchar](100) NULL,
	[Post] [nvarchar](100) NULL,
	[Staff_ID] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[Arrive_date] [datetime] NULL,
	[ID_card_number] [nvarchar](50) NULL,
	[Post_medical_package] [nvarchar](50) NULL,
	[Post_medical_package_Id] [nvarchar](50) NULL,
	[corporation] [nvarchar](50) NULL,
	[User_Sex] [varchar](10) NULL,
	[Date_of_birth] [datetime] NULL,
	[User_age] [varchar](50) NULL,
	[Working_years] [varchar](50) NULL,
	[Physical_No] [nvarchar](50) NULL,
	[Physical_Date] [datetime] NULL,
	[result] [nvarchar](500) NULL,
	[conclusion] [nvarchar](500) NULL,
	[Disposal_conclusion] [nvarchar](500) NULL,
	[Physical_money] [numeric](18, 1) NULL,
	[medical_state] [int] NULL,
	[Medical_type] [varchar](50) NULL,
	[ImportUser] [nvarchar](50) NULL,
	[ImportDate] [datetime] NULL,
	[IsRemind] [bigint] NULL,
	[PassRemark] [nvarchar](500) NULL,
	[PassUser] [nvarchar](25) NULL,
	[PassDate] [datetime] NULL,
	[Departure_Date] [datetime] NULL,
	[ImportState] [bigint] NULL,
	[RecheckRemark] [nvarchar](500) NULL,
	[LastPhysicalDate] [datetime] NULL,
	[Medical_institutions] [nvarchar](50) NULL,
	[ImportStateUser] [nvarchar](25) NULL,
	[ImportStateDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
