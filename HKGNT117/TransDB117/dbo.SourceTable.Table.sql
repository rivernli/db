USE [TransDB117]
GO
/****** Object:  Table [dbo].[SourceTable]    Script Date: 2014/11/12 17:15:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SourceTable](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[SourceServerID] [int] NOT NULL,
	[TableName] [varchar](128) NOT NULL,
	[FactoryLoading-FactoryLoading] [bit] NULL,
 CONSTRAINT [PK_SourceTable] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CK_SourceTable_SourceServerID_TableName]    Script Date: 2014/11/12 17:15:29 ******/
CREATE UNIQUE NONCLUSTERED INDEX [CK_SourceTable_SourceServerID_TableName] ON [dbo].[SourceTable]
(
	[SourceServerID] ASC,
	[TableName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SourceTable] ADD  CONSTRAINT [DF_SourceTable_FactoryLoading-FactoryLoading]  DEFAULT ((0)) FOR [FactoryLoading-FactoryLoading]
GO
ALTER TABLE [dbo].[SourceTable]  WITH CHECK ADD  CONSTRAINT [FK_SourceTable_SourceServer] FOREIGN KEY([SourceServerID])
REFERENCES [dbo].[SourceServer] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SourceTable] CHECK CONSTRAINT [FK_SourceTable_SourceServer]
GO
