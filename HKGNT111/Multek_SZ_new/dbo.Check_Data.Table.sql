USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[Check_Data]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Check_Data](
	[Table_Qualifier] [varchar](100) NULL,
	[Table_Owner] [varchar](100) NULL,
	[Table_Name] [varchar](100) NULL,
	[Table_Type] [varchar](100) NULL,
	[Remarks] [varchar](100) NULL,
	[LinkedServer] [varchar](100) NULL,
	[YesterdayCount] [bigint] NOT NULL,
	[NowCount] [bigint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Check_Data] ADD  CONSTRAINT [DF_Check_Data_BeforeYesterdayCount]  DEFAULT ((0)) FOR [YesterdayCount]
GO
ALTER TABLE [dbo].[Check_Data] ADD  CONSTRAINT [DF_Check_Data_YesterdayCount]  DEFAULT ((0)) FOR [NowCount]
GO
