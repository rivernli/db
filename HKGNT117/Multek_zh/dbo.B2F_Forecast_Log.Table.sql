USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B2F_Forecast_Log]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[B2F_Forecast_Log](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NULL,
	[Operation] [nvarchar](50) NULL,
	[OperationDate] [datetime] NULL CONSTRAINT [DF_B2F_Forecast_Log_OperationDate]  DEFAULT (getdate()),
	[Remark] [nvarchar](50) NULL,
 CONSTRAINT [PK_B2F_Forecast_Log] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
