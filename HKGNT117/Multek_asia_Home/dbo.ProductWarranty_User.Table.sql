USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[ProductWarranty_User]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductWarranty_User](
	[UserId] [uniqueidentifier] NOT NULL,
	[Domain] [nvarchar](15) NOT NULL,
	[sAMAccountName] [nvarchar](70) NOT NULL,
	[FullName] [nvarchar](80) NOT NULL,
	[EmailAddress] [nvarchar](100) NULL,
	[objectSid] [varbinary](100) NOT NULL,
	[EnableRead] [bit] NOT NULL,
	[EnableCreate] [bit] NOT NULL,
	[EnableUpdate] [bit] NOT NULL,
	[EnableDelete] [bit] NOT NULL,
	[IsAdministrator] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
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
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ProductWarranty_User]    Script Date: 2014/11/12 17:07:58 ******/
CREATE CLUSTERED INDEX [IX_ProductWarranty_User] ON [dbo].[ProductWarranty_User]
(
	[FullName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_ProductWarranty_User_2]    Script Date: 2014/11/12 17:07:58 ******/
CREATE UNIQUE NONCLUSTERED INDEX [PK_ProductWarranty_User_2] ON [dbo].[ProductWarranty_User]
(
	[objectSid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
