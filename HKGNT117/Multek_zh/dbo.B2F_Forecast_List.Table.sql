USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B2F_Forecast_List]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[B2F_Forecast_List](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Initiator] [varchar](50) NULL,
	[InitiatorDate] [datetime] NULL,
	[Modif] [varchar](50) NULL,
	[ModifDate] [datetime] NULL,
 CONSTRAINT [PK_B2F_Forecast_List] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
