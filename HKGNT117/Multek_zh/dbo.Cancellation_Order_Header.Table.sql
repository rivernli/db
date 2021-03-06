USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cancellation_Order_Header]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cancellation_Order_Header](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SO] [nvarchar](10) NULL,
	[Plant] [nvarchar](5) NULL,
	[OrderQuantity] [int] NULL,
	[BacklogQuantity] [int] NULL,
	[OEM] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[User] [nvarchar](50) NULL,
	[STATUS] [nvarchar](30) NULL,
 CONSTRAINT [PK_Cancellation_sp_Query_so_header] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
