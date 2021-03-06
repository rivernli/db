USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cancellation_Charge_PPC_WIP]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cancellation_Charge_PPC_WIP](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SO] [int] NOT NULL,
	[Item] [nvarchar](35) NOT NULL,
	[Work_center] [nvarchar](30) NOT NULL,
	[quantity] [decimal](18, 4) NULL,
	[Rate] [decimal](18, 4) NULL,
 CONSTRAINT [PK_Cancellation_Charge_PPC_WIP] PRIMARY KEY CLUSTERED 
(
	[SO] ASC,
	[Item] ASC,
	[Work_center] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
