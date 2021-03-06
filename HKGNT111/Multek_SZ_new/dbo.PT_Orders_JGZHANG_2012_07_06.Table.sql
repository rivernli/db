USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[PT_Orders_JGZHANG_2012_07_06]    Script Date: 11/06/2014 15:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PT_Orders_JGZHANG_2012_07_06](
	[OrderNo] [varchar](50) NOT NULL,
	[TransferingDepartmentAutoID] [int] NULL,
	[TransferingSiteOwnerUserID] [varchar](50) NULL,
	[ReceivingDepartmentAutoID] [int] NULL,
	[ReceivingSiteOwnerUserID] [varchar](50) NULL,
	[PartNumber] [varchar](100) NULL,
	[RevisionNumber] [varchar](100) NULL,
	[ToolNumber] [varchar](100) NULL,
	[CustomerCEM] [varchar](100) NULL,
	[CustomerOEM] [varchar](100) NULL,
	[DeliveryDate] [datetime] NULL,
	[CustomerApprove] [bit] NULL,
	[SalesOrderOption] [tinyint] NULL,
	[SalesOrderAttachment] [varchar](500) NULL,
	[SalesOrderPhysicalAttachment] [varchar](50) NULL,
	[SalesOrderComment] [varchar](500) NULL,
	[PurchaseOrderOption] [tinyint] NULL,
	[PurchaseOrderAttachment] [varchar](500) NULL,
	[PurchaseOrderPhysicalAttachment] [varchar](50) NULL,
	[PurchaseOrderComment] [varchar](500) NULL,
	[TransferingInvolvedDepartmentAutoID] [varchar](500) NULL,
	[GoldenBoardShipment] [tinyint] NULL,
	[GoldenBoardQuantity] [int] NULL,
	[GoldenBoardWhen] [datetime] NULL,
	[GoldenBoardAWB] [varchar](50) NULL,
	[GoldenBoardByWhom] [varchar](50) NULL,
	[GoldenBoardComment] [varchar](500) NULL,
	[RejectedBoardShipment] [tinyint] NULL,
	[RejectedBoardQuantity] [int] NULL,
	[RejectedBoardWhen] [datetime] NULL,
	[RejectedBoardAWB] [varchar](50) NULL,
	[RejectedBoardByWhom] [varchar](50) NULL,
	[RejectedBoardComment] [varchar](500) NULL,
	[Closed] [bit] NULL,
	[ClosedUserID] [varchar](50) NULL,
	[ClosedDate] [datetime] NULL,
	[CreatedUserID] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[Deleted] [bit] NULL,
	[DeletedUserID] [varchar](50) NULL,
	[DeletedDate] [datetime] NULL,
	[LastUpdatedUserID] [varchar](50) NULL,
	[LastUpdatedDate] [datetime] NULL,
	[ReceivingSiteOwnerApprove] [bit] NULL,
	[ReceivingSiteOwnerApproveDate] [datetime] NULL,
	[TransferringSiteOwnerApprove] [bit] NULL,
	[TransferringSiteOwnerApproveDate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
