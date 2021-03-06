USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cancellation_Charge_PPC_FG]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cancellation_Charge_PPC_FG](
	[T$ORNO] [nvarchar](6) NOT NULL,
	[T$PONO] [float] NOT NULL,
	[T$ITEM] [nvarchar](30) NULL,
	[T$QUAN] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Cancellation_Charge_PPC_Inventory] PRIMARY KEY CLUSTERED 
(
	[T$ORNO] ASC,
	[T$PONO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
