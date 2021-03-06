USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[sgp_pricing]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sgp_pricing](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[cost_id] [int] NOT NULL,
	[price] [decimal](18, 6) NOT NULL,
	[qty] [int] NOT NULL,
	[yield] [decimal](18, 6) NOT NULL,
	[status] [tinyint] NOT NULL,
	[create_date] [datetime] NOT NULL,
	[payment_terms] [nvarchar](100) NULL,
	[last_update] [datetime] NULL,
 CONSTRAINT [PK_sgp_pricing] PRIMARY KEY CLUSTERED 
(
	[cost_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sgp_pricing] ADD  DEFAULT (getdate()) FOR [last_update]
GO
