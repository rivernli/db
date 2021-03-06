USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_2D_Report_Upload_Authority]    Script Date: 11/06/2014 15:47:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_2D_Report_Upload_Authority](
	[ReportCode] [varchar](2) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[CanUpload] [bit] NOT NULL,
 CONSTRAINT [PK_ShipmentReport_2D_Report_Upload_Authority] PRIMARY KEY CLUSTERED 
(
	[ReportCode] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ShipmentReport_2D_Report_Upload_Authority] ADD  CONSTRAINT [DF_ShipmentReport_2D_Report_Upload_Authority_CanUpload]  DEFAULT ((0)) FOR [CanUpload]
GO
