USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[PT_Order_CheckList_Comment]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PT_Order_CheckList_Comment](
	[AutoID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrderCheckListAutoID] [bigint] NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Comment] [nvarchar](max) NULL,
 CONSTRAINT [PK_PT_Order_CheckList_Comment] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PT_Order_CheckList_Comment]  WITH CHECK ADD  CONSTRAINT [FK_PT_Order_CheckList_Comment_PT_Order_CheckList] FOREIGN KEY([OrderCheckListAutoID])
REFERENCES [dbo].[PT_Order_CheckList] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PT_Order_CheckList_Comment] CHECK CONSTRAINT [FK_PT_Order_CheckList_Comment_PT_Order_CheckList]
GO
ALTER TABLE [dbo].[PT_Order_CheckList_Comment] ADD  CONSTRAINT [DF_PT_Order_CheckList_Comment_DateTime]  DEFAULT (getdate()) FOR [DateTime]
GO
