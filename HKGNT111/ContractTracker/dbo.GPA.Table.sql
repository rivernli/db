USE [ContractTracker]
GO
/****** Object:  Table [dbo].[GPA]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPA](
	[GPANo] [varchar](10) NOT NULL,
	[OwnerID] [varchar](50) NOT NULL,
	[LegalID] [int] NULL,
	[SiteID] [int] NULL,
	[CustomerName] [varchar](1000) NULL,
	[Products] [varchar](1000) NULL,
	[KeyProductLine] [int] NULL,
	[AgreementID] [int] NULL,
	[ContractInDate] [datetime] NULL,
	[ExpectEDClosingDate] [datetime] NULL,
	[ActualClosingDate] [datetime] NULL,
	[StatusID] [int] NULL,
	[Attachment] [varchar](50) NULL,
	[PhysicalAttachment] [varchar](50) NULL,
	[Closed] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ClosedDate] [datetime] NULL,
	[ClosedOperator] [varchar](50) NULL,
	[Deleted] [bit] NULL,
	[Remark] [varchar](8000) NULL,
	[Deleter] [varchar](50) NULL,
	[DeletedDate] [datetime] NULL,
 CONSTRAINT [PK_GPA] PRIMARY KEY CLUSTERED 
(
	[GPANo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[GPA]  WITH CHECK ADD  CONSTRAINT [FK_GPA_Agree] FOREIGN KEY([AgreementID])
REFERENCES [dbo].[Agree] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GPA] CHECK CONSTRAINT [FK_GPA_Agree]
GO
ALTER TABLE [dbo].[GPA]  WITH CHECK ADD  CONSTRAINT [FK_GPA_Legal] FOREIGN KEY([LegalID])
REFERENCES [dbo].[Legal] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GPA] CHECK CONSTRAINT [FK_GPA_Legal]
GO
ALTER TABLE [dbo].[GPA]  WITH CHECK ADD  CONSTRAINT [FK_GPA_Product] FOREIGN KEY([KeyProductLine])
REFERENCES [dbo].[Product] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GPA] CHECK CONSTRAINT [FK_GPA_Product]
GO
ALTER TABLE [dbo].[GPA]  WITH CHECK ADD  CONSTRAINT [FK_GPA_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[Site] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GPA] CHECK CONSTRAINT [FK_GPA_Site]
GO
ALTER TABLE [dbo].[GPA]  WITH CHECK ADD  CONSTRAINT [FK_GPA_Status] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GPA] CHECK CONSTRAINT [FK_GPA_Status]
GO
ALTER TABLE [dbo].[GPA]  WITH CHECK ADD  CONSTRAINT [FK_GPA_Users] FOREIGN KEY([OwnerID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GPA] CHECK CONSTRAINT [FK_GPA_Users]
GO
ALTER TABLE [dbo].[GPA] ADD  CONSTRAINT [DF_GPA_Closed]  DEFAULT ((0)) FOR [Closed]
GO
ALTER TABLE [dbo].[GPA] ADD  CONSTRAINT [DF_GPA_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[GPA] ADD  CONSTRAINT [DF_GPA_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
