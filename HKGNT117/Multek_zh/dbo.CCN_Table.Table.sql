USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[CCN_Table]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CCN_Table](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CCNNo] [varchar](50) NOT NULL,
	[Plant] [varchar](10) NULL,
	[RFVNo] [varchar](50) NULL,
	[RMANo] [varchar](50) NULL,
	[CriticalIssue] [varchar](10) NULL,
	[CARPMNo] [varchar](50) NULL,
	[CCNReceived] [datetime] NULL,
	[NeedSample] [varchar](10) NULL,
	[SampleReceived] [datetime] NULL,
	[FACompletionDate] [datetime] NULL,
	[HandlingQA] [varchar](50) NULL,
	[HandlingEngineering] [varchar](50) NULL,
	[CEM] [nvarchar](100) NULL,
	[OEM] [nvarchar](100) NULL,
	[CustomerPN] [varchar](50) NULL,
	[MultekPN] [varchar](50) NULL,
	[DateCode] [varchar](50) NULL,
	[DetailedType] [varchar](50) NULL,
	[AffectedPCBQty] [varchar](50) NULL,
	[AffectedPCBAQty] [varchar](50) NULL,
	[DefectDesc] [nvarchar](4000) NULL,
	[DefectivePic] [nvarchar](4000) NULL,
	[DefectiveRate] [varchar](50) NULL,
	[PotentialUP] [varchar](50) NULL,
	[TotalClaim] [varchar](50) NULL,
	[OpenOrClosed] [varchar](50) NULL,
	[DetailedStatusAndDate] [nvarchar](4000) NULL,
	[HDIH] [nvarchar](4000) NULL,
	[HDIE] [nvarchar](4000) NULL,
	[CA_FHC] [nvarchar](4000) NULL,
	[CA_FEC] [nvarchar](4000) NULL,
	[PA_FHC] [nvarchar](4000) NULL,
	[PA_FEC] [nvarchar](4000) NULL,
	[StatusOfCAPAs] [varchar](50) NULL,
	[ProcessOfCorrector] [varchar](50) NULL,
	[NameOfCorrector] [varchar](50) NULL,
	[UpdateDate] [datetime] NULL,
	[ECDate] [datetime] NULL,
	[TCDate] [datetime] NULL,
	[Remark] [nvarchar](4000) NULL,
	[EDDate] [datetime] NULL,
	[Creator] [varchar](50) NULL,
	[Del] [int] NULL,
	[DelReason] [nvarchar](4000) NULL,
	[DelUser] [varchar](50) NULL,
	[DelDate] [datetime] NULL,
	[APPClose] [int] NULL,
	[APPTime] [datetime] NULL,
	[APPName] [nvarchar](50) NULL,
	[MidAlert] [datetime] NULL,
	[LastAlert] [datetime] NULL,
 CONSTRAINT [PK_CCN_Table] PRIMARY KEY CLUSTERED 
(
	[CCNNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CCN_Table] ADD  CONSTRAINT [DF_CCN_Table_Del]  DEFAULT ((0)) FOR [Del]
GO
ALTER TABLE [dbo].[CCN_Table] ADD  CONSTRAINT [DF_CCN_Table_APPClose]  DEFAULT ((0)) FOR [APPClose]
GO
