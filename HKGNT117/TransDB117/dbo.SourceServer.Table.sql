USE [TransDB117]
GO
/****** Object:  Table [dbo].[SourceServer]    Script Date: 2014/11/12 17:15:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SourceServer](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[TNSName] [varchar](50) NOT NULL,
	[Schem] [varchar](50) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[UserPassword] [varchar](50) NOT NULL,
	[LinkServer] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SourceServer] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CK_SourceServer_LinkServer]    Script Date: 2014/11/12 17:15:29 ******/
CREATE UNIQUE NONCLUSTERED INDEX [CK_SourceServer_LinkServer] ON [dbo].[SourceServer]
(
	[LinkServer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CK_SourceServer_TNSName_Schema_UserID]    Script Date: 2014/11/12 17:15:29 ******/
CREATE UNIQUE NONCLUSTERED INDEX [CK_SourceServer_TNSName_Schema_UserID] ON [dbo].[SourceServer]
(
	[TNSName] ASC,
	[Schem] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
