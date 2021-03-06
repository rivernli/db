USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Engineering_Evaluation_File]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_Engineering_Evaluation_File](
	[PhysicalFileName] [varchar](50) NOT NULL,
	[FileName] [varchar](255) NULL,
	[FileDescription] [varchar](500) NULL,
	[Size] [int] NULL,
	[Type] [varchar](10) NULL,
	[Uploader] [varchar](50) NULL,
	[UploadedTime] [datetime] NOT NULL,
	[AutoID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
 CONSTRAINT [PK_ShipmentReport_ShipmentReport_Engineering_Evaluation_File_1] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ShipmentReport_Engineering_Evaluation_File] ADD  CONSTRAINT [DF_ShipmentReport_Engineering_Evaluation_File_UploadedTime]  DEFAULT (getdate()) FOR [UploadedTime]
GO
