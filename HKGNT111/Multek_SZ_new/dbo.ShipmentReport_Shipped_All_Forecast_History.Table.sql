USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Forecast_History]    Script Date: 11/06/2014 15:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Forecast_History](
	[AutoID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserID] [varchar](50) NULL,
	[ChangedDate] [datetime] NULL,
	[Site] [varchar](50) NULL,
	[Plant] [varchar](50) NULL,
	[Year] [varchar](4) NULL,
	[M1] [bigint] NULL,
	[M2] [bigint] NULL,
	[M3] [bigint] NULL,
	[M4] [bigint] NULL,
	[M5] [bigint] NULL,
	[M6] [bigint] NULL,
	[M7] [bigint] NULL,
	[M8] [bigint] NULL,
	[M9] [bigint] NULL,
	[M10] [bigint] NULL,
	[M11] [bigint] NULL,
	[M12] [bigint] NULL,
 CONSTRAINT [PK_ShipmentReport_Shipped_All_Forecast_History] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ShipmentReport_Shipped_All_Forecast_History] ADD  CONSTRAINT [DF_ShipmentReport_Shipped_All_Forecast_History_ChangedDate]  DEFAULT (getdate()) FOR [ChangedDate]
GO
