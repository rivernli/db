USE [TransDB117]
GO
/****** Object:  Table [dbo].[TransSchedule]    Script Date: 2014/11/12 17:15:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TransSchedule](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleTime] [varchar](8) NOT NULL,
	[HKCE3P1858-CE3P1858] [bit] NULL,
	[FactoryLoading-Factory Loading] [bit] NULL,
	[FactoryLoading-FactoryLoading] [bit] NULL,
 CONSTRAINT [PK_TransSchedule_1] PRIMARY KEY CLUSTERED 
(
	[ScheduleTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_TransSchedule]    Script Date: 2014/11/12 17:15:29 ******/
CREATE NONCLUSTERED INDEX [PK_TransSchedule] ON [dbo].[TransSchedule]
(
	[ScheduleTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TransSchedule] ADD  CONSTRAINT [DF_TransSchedule_hkce3p1858-858]  DEFAULT ((0)) FOR [HKCE3P1858-CE3P1858]
GO
ALTER TABLE [dbo].[TransSchedule] ADD  CONSTRAINT [DF_TransSchedule_FactoryLoading-Factory Loading]  DEFAULT ((0)) FOR [FactoryLoading-Factory Loading]
GO
ALTER TABLE [dbo].[TransSchedule] ADD  CONSTRAINT [DF_TransSchedule_FactoryLoading-FactoryLoading]  DEFAULT ((0)) FOR [FactoryLoading-FactoryLoading]
GO
