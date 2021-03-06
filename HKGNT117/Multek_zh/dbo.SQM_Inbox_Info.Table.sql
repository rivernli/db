USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_Inbox_Info]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQM_Inbox_Info](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SendId] [nvarchar](50) NULL,
	[SendTitle] [nvarchar](200) NULL,
	[Reportno] [nvarchar](50) NULL,
	[PN] [nvarchar](50) NULL,
	[SendUrl] [nvarchar](200) NULL,
	[SendTime] [datetime] NULL CONSTRAINT [DF_SQM_Inbox_Info_SendTime]  DEFAULT (getdate()),
	[Sender] [nvarchar](50) NULL,
	[Accepter] [nvarchar](max) NULL,
	[State] [int] NULL CONSTRAINT [DF_SQM_Inbox_Info_State]  DEFAULT ((0)),
	[Del] [bit] NULL CONSTRAINT [DF_SQM_Inbox_Info_Del]  DEFAULT ((0)),
	[EmailId] [nvarchar](500) NULL,
	[Remark] [nvarchar](max) NULL,
	[TimeOutDays] [int] NULL,
	[Material] [nvarchar](50) NULL,
	[TimeOutDate] [datetime] NULL,
 CONSTRAINT [PK_SQM_Inbox_Info] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
