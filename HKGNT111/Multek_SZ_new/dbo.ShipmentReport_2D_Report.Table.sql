USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_2D_Report]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_2D_Report](
	[Code] [varchar](2) NOT NULL,
	[Description] [varchar](200) NOT NULL,
	[SendMail] [bit] NULL,
	[Message] [varchar](max) NULL,
 CONSTRAINT [PK_ShipmentReport_2D_Report] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ShipmentReport_2D_Report] ADD  CONSTRAINT [DF_ShipmentReport_2D_Report_SendMail]  DEFAULT ((0)) FOR [SendMail]
GO
