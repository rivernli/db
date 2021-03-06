USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[CCN_MailLog]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CCN_MailLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MailTo] [varchar](500) NULL,
	[MailCC] [varchar](500) NULL,
	[MailBCC] [varchar](500) NULL,
	[CreateTime] [datetime] NOT NULL,
	[Subject] [nvarchar](200) NULL,
	[Body] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CCN_MailLog] ADD  CONSTRAINT [DF_CCN_MailLog_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
