USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_IncomingMaterialCheck_B2F]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SQM_IncomingMaterialCheck_B2F](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Material] [nvarchar](50) NULL,
	[Plant] [nvarchar](50) NULL,
	[Date] [varchar](20) NULL,
	[F_N] [nvarchar](20) NULL,
	[PN] [nvarchar](50) NULL,
	[Vendor] [nvarchar](100) NULL,
	[Location] [nvarchar](50) NULL,
	[Vendor_PN] [nvarchar](50) NULL,
	[Core_thickness] [nvarchar](50) NULL,
	[Construction] [nvarchar](50) NULL,
	[Copper_thickness] [nvarchar](50) NULL,
	[Copper_Treatment] [nvarchar](50) NULL,
	[Size] [nvarchar](50) NULL,
	[HF] [nvarchar](50) NULL,
	[RoHs] [nvarchar](50) NULL,
	[Description] [nvarchar](200) NULL,
	[Receiving_Date] [varchar](20) NULL,
	[Manufacturer] [nvarchar](200) NULL,
	[Manafacture_Date] [varchar](20) NULL,
	[Po_Number] [nvarchar](50) NULL,
	[Qty] [nvarchar](50) NULL,
	[PackageNo] [nvarchar](50) NULL,
	[DeliveryTime] [varchar](20) NULL,
	[Box] [nvarchar](50) NULL,
	[SampleSize] [nvarchar](50) NULL,
	[LotNo] [nvarchar](50) NULL,
	[LotSize] [nvarchar](50) NULL,
	[CartonNo] [nvarchar](50) NULL,
	[Package] [int] NULL,
	[CoA] [bit] NULL,
	[CoAAttachment] [nvarchar](50) NULL,
	[shipment] [bit] NULL,
	[Inspct_Bill] [bit] NULL,
	[Conclusion] [int] NULL,
	[UAI_REJ] [int] NULL,
	[Checked_Userid] [nvarchar](50) NULL,
	[Checked_By] [nvarchar](50) NULL,
	[Checked_Date] [varchar](20) NULL,
	[Approved_Userid] [nvarchar](50) NULL,
	[Approved_By] [nvarchar](50) NULL,
	[Approved_Date] [varchar](20) NULL,
	[IQA_HSF] [bit] NULL,
	[IQA_HS] [bit] NULL,
	[IQA_OtherCk] [bit] NULL,
	[IQA_Other] [nvarchar](50) NULL,
	[IQA_CoA_requirement] [nvarchar](50) NULL,
	[IQA_Conclusion] [int] NULL,
	[IQA_Reject_Remark] [nvarchar](500) NULL,
	[IQA_Checked_Userid] [nvarchar](50) NULL,
	[IQA_Checked_by] [nvarchar](50) NULL,
	[IQA_Checked_Date] [varchar](20) NULL,
	[IQA_Approved_Userid] [nvarchar](50) NULL,
	[IQA_Approved_by] [nvarchar](50) NULL,
	[IQA_Approved_Date] [varchar](20) NULL,
	[Type_Diameter] [nvarchar](50) NULL,
	[Rc_Ply_Up] [nvarchar](50) NULL,
	[Send_State] [int] NULL,
	[TaskId] [nvarchar](50) NOT NULL,
	[Attachment] [nvarchar](50) NULL,
	[RejOther] [nvarchar](200) NULL,
	[UAIOther] [nvarchar](200) NULL,
	[IsSTS] [varchar](50) NULL,
	[CARPM_No] [nvarchar](50) NULL,
	[InvestigationResultandVerification] [nvarchar](max) NULL,
	[Usdisposition] [bit] NULL,
	[UsdispositionValue] [nvarchar](200) NULL,
	[RTV] [bit] NULL,
	[claimonvendor] [bit] NULL,
	[Otherdisposition] [bit] NULL,
	[OtherdispositionValue] [nvarchar](200) NULL,
	[SQMVerifier_Userid] [nvarchar](50) NULL,
	[SQMVerifier] [nvarchar](50) NULL,
	[SQMVerifier_Date] [varchar](25) NULL,
	[PrintState] [int] NULL,
	[SQMAttachment] [nvarchar](25) NULL,
	[IsSentSupplit] [bit] NULL,
	[IsSentPlant] [bit] NULL,
 CONSTRAINT [PK_SQM_IncomingMaterialCheck_B2F] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
