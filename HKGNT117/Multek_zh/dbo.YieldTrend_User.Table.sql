USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[YieldTrend_User]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[YieldTrend_User](
	[UserId] [uniqueidentifier] NOT NULL,
	[Domain] [nvarchar](15) NOT NULL,
	[sAMAccountName] [nvarchar](70) NOT NULL,
	[FullName] [nvarchar](80) NOT NULL,
	[EmailAddress] [nvarchar](100) NULL,
	[JobTitle] [nvarchar](100) NULL,
	[Fax] [nvarchar](100) NULL,
	[Telephone] [nvarchar](100) NULL,
	[objectSid] [varbinary](100) NOT NULL,
	[Active] [bit] NOT NULL,
	[IsAdmin] [bit] NULL,
	[Site] [varchar](200) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ProductWarranty_User] PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
