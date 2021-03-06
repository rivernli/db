USE [BOC]
GO
/****** Object:  Table [dbo].[TFSPUR033180]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFSPUR033180](
	[t$sern] [nvarchar](10) NOT NULL,
	[t$user] [nvarchar](15) NULL,
	[t$date] [nvarchar](15) NULL,
	[t$time] [nvarchar](15) NULL,
	[t$flag] [nvarchar](10) NULL,
	[t$prod] [int] NULL,
	[t$year] [int] NULL,
	[t$citf] [nvarchar](15) NULL,
	[t$citt] [nvarchar](15) NULL,
	[t$sunf] [nvarchar](15) NULL,
	[t$sunt] [nvarchar](15) NULL,
	[t$yeaf] [int] NULL,
	[t$yeat] [int] NULL,
	[t$prot] [int] NULL,
	[t$prof] [int] NULL,
	[t$plnf] [nvarchar](15) NULL,
	[t$plnt] [nvarchar](15) NULL,
	[t$trtp] [nvarchar](15) NULL,
 CONSTRAINT [PK_TFSPUR033180] PRIMARY KEY CLUSTERED 
(
	[t$sern] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
