USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Delivery_TS_ZD_Info]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delivery_TS_ZD_Info](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[P_ID] [int] NULL CONSTRAINT [DF_TS_ZD_Info_P_ID]  DEFAULT ((0)),
	[Data_name] [nvarchar](50) NULL,
	[Remark] [nvarchar](200) NULL,
 CONSTRAINT [PK_TS_ZD_Info] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
