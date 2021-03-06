USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B2F_Forecast_Users]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[B2F_Forecast_Users](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NULL,
	[Region] [varchar](50) NULL,
	[Account] [varchar](50) NULL,
	[Admin] [bigint] NULL CONSTRAINT [DF_B2F_Forecast_Users_Admin]  DEFAULT ((0)),
 CONSTRAINT [PK_B2F_Forecast_Users] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
