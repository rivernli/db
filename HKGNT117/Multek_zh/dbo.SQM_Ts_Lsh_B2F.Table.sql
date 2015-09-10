USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_Ts_Lsh_B2F]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQM_Ts_Lsh_B2F](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ModuleName] [nvarchar](50) NULL,
	[KeyName] [nvarchar](50) NULL,
	[Lsh] [int] NULL,
	[Parm1] [nvarchar](20) NULL
) ON [PRIMARY]

GO
