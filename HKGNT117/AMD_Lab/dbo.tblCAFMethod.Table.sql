USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblCAFMethod]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCAFMethod](
	[CAFMethodID] [int] IDENTITY(1,1) NOT NULL,
	[CAFMethodName] [nvarchar](50) NULL,
	[CAFMethodSpec] [nvarchar](50) NULL,
	[Version] [nvarchar](50) NULL,
	[Test_Temp] [tinyint] NULL,
	[Test_RH] [tinyint] NULL,
	[Test_Bias] [smallint] NULL,
	[Test_Bias_start] [smallint] NULL,
	[CL_resistance] [int] NULL,
	[THB_Precon] [bit] NOT NULL,
	[Precon_Dur] [smallint] NULL,
	[Precon_Temp] [tinyint] NULL,
	[Precon_RH] [tinyint] NULL,
	[Reflow] [bit] NOT NULL,
	[ReflowX] [tinyint] NULL,
	[PeakTemp] [smallint] NULL,
	[ReflowProfileName] [nvarchar](8) NULL,
	[Initial_Meas_Temp] [tinyint] NULL,
	[Initial_Meas_RH] [tinyint] NULL,
	[StabilizationPeriod] [tinyint] NULL,
	[Final_Meas_Temp] [tinyint] NULL,
	[Final_Meas_RH] [tinyint] NULL,
	[Meas_Intvl-1] [smallint] NULL,
	[Meas_Intvl-2] [smallint] NULL,
	[Meas_Intvl-3] [smallint] NULL,
	[Meas_Intvl-4] [smallint] NULL,
	[Meas_Intvl-5] [smallint] NULL,
	[Meas_Intvl-6] [smallint] NULL,
	[Meas_Intvl-7] [smallint] NULL,
	[Meas_Intvl-8] [smallint] NULL,
	[Meas_Intvl-9] [smallint] NULL,
	[Meas_Intvl-10] [smallint] NULL,
	[Meas_Intvl-11] [smallint] NULL,
	[Meas_Intvl-12] [smallint] NULL,
	[Meas_Intvl-13] [smallint] NULL,
	[Meas_Intvl-14] [smallint] NULL,
	[Meas_Intvl-15] [smallint] NULL,
	[Meas_Intvl-16] [smallint] NULL,
	[Meas_Intvl-17] [smallint] NULL,
	[Meas_Intvl-18] [smallint] NULL,
	[Meas_Intvl-19] [smallint] NULL,
	[Meas_Intvl-20] [smallint] NULL,
	[Notes] [ntext] NULL,
 CONSTRAINT [PK_tblCAFMethod] PRIMARY KEY CLUSTERED 
(
	[CAFMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
