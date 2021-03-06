USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_TimeOutSetting]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQM_TimeOutSetting](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InfoId] [int] NULL,
	[TimeOutDate] [datetime] NULL,
	[Remark] [nvarchar](max) NULL,
	[Operator] [nvarchar](50) NULL,
	[Date] [datetime] NULL CONSTRAINT [DF_SQM_TimeOutSetting_Date]  DEFAULT (getdate()),
 CONSTRAINT [PK_SQM_TimeOutSetting] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
