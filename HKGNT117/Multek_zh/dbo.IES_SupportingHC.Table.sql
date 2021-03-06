USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_SupportingHC]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_SupportingHC](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](10) NOT NULL,
	[Process] [varchar](50) NOT NULL,
	[HCCalc] [varchar](50) NULL,
	[GroupLeader] [decimal](18, 1) NULL,
	[Clerk] [decimal](18, 1) NULL,
	[TotalFixedLabors] [decimal](18, 1) NULL,
	[InChargePanel] [decimal](18, 1) NULL,
	[PanelTally] [decimal](18, 1) NULL,
	[InChargeQuality] [decimal](18, 1) NULL,
	[ProcessLeader] [decimal](18, 1) NULL,
	[Other] [decimal](18, 1) NULL,
	[TotalNonFixedPerson] [decimal](18, 1) NULL,
	[TotalNonFixedLabors] [decimal](18, 1) NULL,
	[Total] [decimal](18, 1) NULL,
	[Remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_IES_SupportingHC] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
