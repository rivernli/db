USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Fixed_Period]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXR2_Fixed_Period](
	[ID] [int] NULL,
	[Period_Fiscal] [nvarchar](20) NULL,
	[Period] [nvarchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Period_Desc]    Script Date: 2014/11/12 17:12:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [Period_Desc] ON [dbo].[EXR2_Fixed_Period]
(
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Period_Fiscal]    Script Date: 2014/11/12 17:12:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [Period_Fiscal] ON [dbo].[EXR2_Fixed_Period]
(
	[Period_Fiscal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
