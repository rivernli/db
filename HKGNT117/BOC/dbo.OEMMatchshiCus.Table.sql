USE [BOC]
GO
/****** Object:  Table [dbo].[OEMMatchshiCus]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OEMMatchshiCus](
	[Loc] [varchar](3) NOT NULL,
	[OEM] [char](6) NULL,
	[OEM Name] [varchar](500) NULL,
	[Customer Name] [varchar](500) NULL,
	[shCustName] [varchar](500) NULL,
	[InvCustName] [char](155) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
