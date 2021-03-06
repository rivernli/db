USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[KOI_Quarterly_AccidentIncident_Report]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KOI_Quarterly_AccidentIncident_Report](
	[Year] [varchar](4) NOT NULL,
	[Quarter] [int] NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[WorkingHours] [float] NULL,
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
 CONSTRAINT [PK_KOI_Quarterly_AccidentIncident_Report] PRIMARY KEY CLUSTERED 
(
	[Year] ASC,
	[Quarter] ASC,
	[Plant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
