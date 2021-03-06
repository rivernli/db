USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_MCDatabase]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_MCDatabase](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](10) NOT NULL,
	[Process] [varchar](10) NOT NULL,
	[SubProcess] [varchar](50) NOT NULL,
	[HCCalc] [varchar](50) NULL,
	[MonitorByIE] [int] NOT NULL,
	[NOM] [decimal](18, 1) NULL,
	[NOHMS] [decimal](18, 1) NULL,
	[UPH] [decimal](18, 1) NULL,
	[HrsPerDay] [decimal](18, 1) NULL,
	[DaysPerWeek] [decimal](18, 1) NULL,
	[NoPerDay] [decimal](18, 1) NULL,
	[NoPerWeek] [decimal](18, 1) NULL,
	[DMWC] [varchar](50) NULL,
	[RelWCCM] [varchar](500) NULL,
	[RelWCCP] [varchar](500) NULL,
	[AMR] [decimal](18, 4) NULL,
	[MCCUD] [decimal](18, 4) NULL,
	[LCR] [decimal](18, 4) NULL,
	[OnLeaveRate] [decimal](18, 4) NULL,
	[LCOLR] [decimal](18, 4) NULL,
	[Remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_IES_MCDatabase] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
