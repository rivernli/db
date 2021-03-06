USE [TransDB117]
GO
/****** Object:  Table [dbo].[ErrorMessage]    Script Date: 2014/11/12 17:15:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ErrorMessage](
	[ErrKey] [varchar](50) NOT NULL,
	[ErrMessage] [varchar](500) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_ErrorMessage]    Script Date: 2014/11/12 17:15:29 ******/
CREATE UNIQUE CLUSTERED INDEX [PK_ErrorMessage] ON [dbo].[ErrorMessage]
(
	[ErrKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
