USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[OnHoldOrders_User]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OnHoldOrders_User](
	[UserId] [uniqueidentifier] NOT NULL,
	[Domain] [nvarchar](15) NOT NULL,
	[sAMAccountName] [nvarchar](70) NOT NULL,
	[FullName] [nvarchar](80) NOT NULL,
	[JobTitle] [nvarchar](100) NULL,
	[EmailAddress] [nvarchar](100) NULL,
	[Company] [varchar](100) NULL,
	[Department] [nvarchar](100) NULL,
	[objectSid] [varbinary](100) NOT NULL,
	[IsAdministrator] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
 CONSTRAINT [PK_OnHoldOrdres_User] PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_OnHoldOrders_User] UNIQUE NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
