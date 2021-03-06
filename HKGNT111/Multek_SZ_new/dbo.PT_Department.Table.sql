USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[PT_Department]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PT_Department](
	[AutoID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LocationAutoID] [int] NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Distribution] [varchar](500) NULL,
	[CreatePT] [bit] NOT NULL,
	[Enable] [bit] NOT NULL,
 CONSTRAINT [PK_PT_Department] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PT_Department]  WITH CHECK ADD  CONSTRAINT [FK_PT_Department_PT_Location] FOREIGN KEY([LocationAutoID])
REFERENCES [dbo].[PT_Location] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PT_Department] CHECK CONSTRAINT [FK_PT_Department_PT_Location]
GO
ALTER TABLE [dbo].[PT_Department] ADD  CONSTRAINT [DF_Department_CreatePT]  DEFAULT ((1)) FOR [CreatePT]
GO
ALTER TABLE [dbo].[PT_Department] ADD  CONSTRAINT [DF_Department_Enable]  DEFAULT ((1)) FOR [Enable]
GO
