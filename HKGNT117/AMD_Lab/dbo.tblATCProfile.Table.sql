USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblATCProfile]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblATCProfile](
	[ATCProfileID] [int] NOT NULL,
	[ATCProfileName] [nvarchar](50) NOT NULL,
	[ATCProfileSpec] [nvarchar](50) NULL,
	[Version] [nvarchar](50) NULL,
	[MinTempSP] [real] NULL,
	[MaxTempSP] [real] NULL,
	[LowDwellTimeSP] [nvarchar](50) NULL,
	[HiDwellTimeSP] [nvarchar](50) NULL,
	[MinTempSpec] [real] NULL,
	[MaxTempSpec] [real] NULL,
	[LowDwellTimeSpec] [nvarchar](50) NULL,
	[HiDwellTimeSpec] [nvarchar](50) NULL,
	[cycletime] [nvarchar](50) NULL,
	[ramprate+] [real] NULL,
	[ramprate-] [real] NULL,
	[Notes] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
