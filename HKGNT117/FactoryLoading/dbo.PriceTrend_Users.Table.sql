USE [FactoryLoading]
GO
/****** Object:  Table [dbo].[PriceTrend_Users]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PriceTrend_Users](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[Region] [varchar](50) NOT NULL,
	[Account] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[BDM] [varchar](50) NOT NULL,
	[Administrator] [bit] NOT NULL,
	[Enable] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Users] UNIQUE NONCLUSTERED 
(
	[Account] ASC,
	[Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PriceTrend_Users] ADD  CONSTRAINT [DF_Users_Administrator]  DEFAULT ((0)) FOR [Administrator]
GO
ALTER TABLE [dbo].[PriceTrend_Users] ADD  CONSTRAINT [DF_Users_Disable]  DEFAULT ((1)) FOR [Enable]
GO
