USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblATCTP]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblATCTP](
	[TPID] [int] NOT NULL,
	[TVConstName] [nvarchar](50) NULL,
	[TPName] [nvarchar](50) NULL,
	[GridSize] [decimal](5, 4) NULL,
	[ViaType] [nvarchar](50) NULL,
	[#nets] [smallint] NULL,
	[drilldia] [decimal](6, 5) NULL,
	[padsize] [decimal](5, 4) NULL,
	[NFPpads] [bit] NOT NULL,
	[NFPPaddia] [decimal](5, 4) NULL,
	[DIR] [real] NULL,
	[DRR] [real] NULL,
	[SpinSpeed] [int] NULL,
	[StkHeight] [smallint] NULL,
	[drillbit] [nvarchar](50) NULL,
	[peck] [tinyint] NULL,
	[maxhit] [smallint] NULL,
	[Notes] [nvarchar](max) NULL,
	[rough] [smallint] NULL,
	[thk] [smallint] NULL,
	[crazing] [smallint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
