USE [BOC]
GO
/****** Object:  Table [dbo].[TTDPUROTHERS]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TTDPUROTHERS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemGroup] [nvarchar](50) NULL,
	[FYear] [int] NULL,
	[FPeriod] [int] NULL,
	[Type] [nvarchar](50) NULL,
	[Plant] [nvarchar](50) NULL,
	[AMNT_Base_On_avg] [float] NULL,
	[AMNT_Base_On_Forecast] [float] NULL,
 CONSTRAINT [PK_TTDPUROTHERS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
