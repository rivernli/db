USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[E_quote_SupplierUser]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[E_quote_SupplierUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[RealName] [nvarchar](50) NULL,
	[Mobile] [nvarchar](50) NULL,
	[Tel] [nvarchar](50) NULL,
	[CorporateName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[RegisterDate] [datetime] NULL,
	[Approved] [nvarchar](50) NULL,
	[ApprovedDate] [datetime] NULL,
	[Active] [bit] NULL CONSTRAINT [DF_E_quote_SupplierUser_Account_Enable]  DEFAULT ((0)),
	[State] [int] NULL CONSTRAINT [DF_E_quote_SupplierUser_State]  DEFAULT ((0)),
	[CompanyProfile] [nvarchar](max) NULL,
	[VendorCode] [nvarchar](50) NULL,
	[VendorName] [nvarchar](50) NULL,
	[ApproverEmail] [nvarchar](50) NULL,
 CONSTRAINT [PK_E_quote_SupplierUser] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
