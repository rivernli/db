USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_CustomerVisitShedule]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mul_CustomerVisitShedule](
	[Cust_Id] [int] IDENTITY(1,1) NOT NULL,
	[Cust_Company] [nvarchar](50) NOT NULL,
	[Cust_GuestName] [nvarchar](200) NOT NULL,
	[Cust_DateFrom] [datetime] NOT NULL,
	[Cust_DateTo] [datetime] NULL,
	[Cust_Purpose] [nvarchar](200) NOT NULL,
	[Cust_SiteId] [int] NOT NULL,
	[Cust_ResponsiblePerson] [nvarchar](200) NULL,
	[Cust_Remarks] [nvarchar](800) NULL,
	[Cust_UpdateBy] [varchar](50) NULL,
	[Cust_UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Mul_CustomerVisitShedule] PRIMARY KEY CLUSTERED 
(
	[Cust_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
