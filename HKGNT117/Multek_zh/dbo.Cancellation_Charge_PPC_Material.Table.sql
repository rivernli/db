USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cancellation_Charge_PPC_Material]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cancellation_Charge_PPC_Material](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[T$ORNO] [nvarchar](6) NULL,
	[T$ITEM] [nvarchar](35) NULL,
	[T$PJNO] [nvarchar](35) NULL,
	[T$DESC] [nvarchar](35) NULL,
	[T$aqua] [decimal](18, 0) NULL,
	[T$UNIT] [nvarchar](5) NULL,
	[T$COST] [float] NULL,
 CONSTRAINT [PK_Cancellation_Charge_PPC_Material] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
