USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[PT_Order_CheckList_Detail]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PT_Order_CheckList_Detail](
	[AutoID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrderCheckListAutoID] [bigint] NULL,
	[TransferUserID] [varchar](50) NULL,
	[TransferDate] [datetime] NULL,
	[Attachment] [varchar](500) NULL,
	[PhysicalAttachment] [varchar](50) NULL,
	[TransferComment] [nvarchar](max) NULL,
	[ReceivingDownload] [bit] NULL,
 CONSTRAINT [PK_PT_Order_CheckList_Detail] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [OrderCheckDetailList] ON [dbo].[PT_Order_CheckList_Detail] 
(
	[OrderCheckListAutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [RecevingDownload] ON [dbo].[PT_Order_CheckList_Detail] 
(
	[ReceivingDownload] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PT_Order_CheckList_Detail]  WITH CHECK ADD  CONSTRAINT [FK_PT_Order_CheckList_Detail_PT_Order_CheckList] FOREIGN KEY([OrderCheckListAutoID])
REFERENCES [dbo].[PT_Order_CheckList] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PT_Order_CheckList_Detail] CHECK CONSTRAINT [FK_PT_Order_CheckList_Detail_PT_Order_CheckList]
GO
ALTER TABLE [dbo].[PT_Order_CheckList_Detail] ADD  CONSTRAINT [DF_PT_Order_CheckList_Detail_TransferDate]  DEFAULT (getdate()) FOR [TransferDate]
GO
ALTER TABLE [dbo].[PT_Order_CheckList_Detail] ADD  CONSTRAINT [DF_PT_Order_CheckList_Detail_ReceivingDownload]  DEFAULT ((0)) FOR [ReceivingDownload]
GO
