USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KOI_InputByEHS]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KOI_InputByEHS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Plant] [varchar](2) NULL,
	[Date] [datetime] NULL,
	[Incident] [float] NULL,
	[First_aid] [float] NULL,
	[Total_Accidents] [float] NULL,
	[Recordable_Accidents] [float] NULL,
	[LWD_Accidents] [float] NULL,
	[Disabled] [float] NULL,
	[Fatal] [float] NULL,
	[Recordable_Accident_Rate] [float] NULL,
	[LWD_Accident_Rate] [float] NULL,
	[Lost_Working_Days] [float] NULL,
	[Medical_Expense] [float] NULL,
	[Manpower_Loss] [float] NULL,
	[Total_Loss] [float] NULL,
	[Total_Loss_per_Case] [float] NULL,
	[Severity_Rate] [float] NULL,
	[Injury_Rate_per_200k_WH] [float] NULL,
 CONSTRAINT [PK_KOI_InputByEHS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IX_KOI_InputByEHS]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_KOI_InputByEHS] ON [dbo].[KOI_InputByEHS]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PlantDate]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [PlantDate] ON [dbo].[KOI_InputByEHS]
(
	[Plant] ASC,
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
