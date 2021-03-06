USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[MI_DaisyChain_Result]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MI_DaisyChain_Result](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[RepNo] [nvarchar](50) NOT NULL,
	[SampleNo] [int] NULL,
	[Side] [nvarchar](50) NULL,
	[Before_1st] [decimal](18, 0) NULL,
	[After_1st] [decimal](18, 0) NULL,
	[Change_1st] [decimal](18, 0) NULL,
	[Before_2nd] [decimal](18, 0) NULL,
	[After_2nd] [decimal](18, 0) NULL,
	[Change_2nd] [decimal](18, 0) NULL
) ON [PRIMARY]

GO
