USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[PT_Order_CheckList_Detail_DownLoad]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PT_Order_CheckList_Detail_DownLoad](
	[AutoID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrderCheckListDetailAutoID] [int] NOT NULL,
	[ReceivingDownloadUserID] [varchar](50) NOT NULL,
	[ReceivingDownloadDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PT_Order_CheckList_Detail_DownLoad] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PT_Order_CheckList_Detail_DownLoad]  WITH CHECK ADD  CONSTRAINT [FK_PT_Order_CheckList_Detail_DownLoad_PT_Order_CheckList_Detail] FOREIGN KEY([OrderCheckListDetailAutoID])
REFERENCES [dbo].[PT_Order_CheckList_Detail] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PT_Order_CheckList_Detail_DownLoad] CHECK CONSTRAINT [FK_PT_Order_CheckList_Detail_DownLoad_PT_Order_CheckList_Detail]
GO
ALTER TABLE [dbo].[PT_Order_CheckList_Detail_DownLoad] ADD  CONSTRAINT [DF_PT_Order_CheckList_Detail_DownLoad_ReceivingDownloadDate]  DEFAULT (getdate()) FOR [ReceivingDownloadDate]
GO
