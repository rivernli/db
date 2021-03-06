USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_ProcessByPlant]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_ProcessByPlant](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](10) NOT NULL,
	[Process] [varchar](20) NOT NULL,
	[KeyMachine] [varchar](50) NULL,
	[TotalQty] [decimal](18, 2) NOT NULL,
	[EquivalentModel] [nvarchar](50) NULL,
	[EquivalentQty] [decimal](18, 2) NOT NULL,
	[PlannedDT] [decimal](18, 2) NULL,
	[AveChangeOverDT] [decimal](18, 2) NULL,
	[CapacityHours] [decimal](18, 2) NOT NULL,
	[BaanWorkCenter] [varchar](100) NULL,
	[GroupName] [varchar](50) NULL,
	[Remark] [nvarchar](1000) NULL,
	[SortNum] [int] NULL,
	[SampleTime] [decimal](18, 2) NULL,
	[CapacityTotal] [decimal](18, 2) NOT NULL CONSTRAINT [DF_IES_ProcessByPlant_CapacityTotal]  DEFAULT ((0)),
 CONSTRAINT [PK_IES_ProcessByPlant] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
