USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_Email_Settings]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQM_Email_Settings](
	[Lsh] [nvarchar](50) NOT NULL,
	[PLsh] [nvarchar](50) NULL,
	[NodeName] [nvarchar](50) NULL,
	[OrderName] [int] NULL CONSTRAINT [DF_SQM_Email_Settings_OrderName]  DEFAULT ((0)),
 CONSTRAINT [PK_SQM_Email_Settings] PRIMARY KEY CLUSTERED 
(
	[Lsh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
