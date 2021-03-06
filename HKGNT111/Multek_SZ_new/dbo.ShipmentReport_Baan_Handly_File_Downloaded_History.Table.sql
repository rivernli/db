USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Baan_Handly_File_Downloaded_History]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_Baan_Handly_File_Downloaded_History](
	[AutoID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FileAutoID] [int] NOT NULL,
	[DownloadUserID] [varchar](50) NOT NULL,
	[DownloadDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ShipmentReport_ShipmentReport_Baan_Handly_File_Downloaded_History] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ShipmentReport_Baan_Handly_File_Downloaded_History]  WITH CHECK ADD  CONSTRAINT [FK_ShipmentReport_Baan_Handly_File_Downloaded_History_ShipmentReport_Baan_Handly_File] FOREIGN KEY([FileAutoID])
REFERENCES [dbo].[ShipmentReport_Baan_Handly_File] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipmentReport_Baan_Handly_File_Downloaded_History] CHECK CONSTRAINT [FK_ShipmentReport_Baan_Handly_File_Downloaded_History_ShipmentReport_Baan_Handly_File]
GO
ALTER TABLE [dbo].[ShipmentReport_Baan_Handly_File_Downloaded_History] ADD  CONSTRAINT [DF_ShipmentReport_Baan_Handly_File_Downloaded_History_DownloadDate]  DEFAULT (getdate()) FOR [DownloadDate]
GO
