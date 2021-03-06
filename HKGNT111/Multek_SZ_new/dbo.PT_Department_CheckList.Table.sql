USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[PT_Department_CheckList]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PT_Department_CheckList](
	[DepartmentAutoID] [int] NOT NULL,
	[CheckListAutoID] [tinyint] NOT NULL,
	[Enable] [bit] NOT NULL,
 CONSTRAINT [PK_PT_Department_CheckList] PRIMARY KEY CLUSTERED 
(
	[DepartmentAutoID] ASC,
	[CheckListAutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PT_Department_CheckList]  WITH CHECK ADD  CONSTRAINT [FK_PT_Department_CheckList_PT_CheckList] FOREIGN KEY([CheckListAutoID])
REFERENCES [dbo].[PT_CheckList] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PT_Department_CheckList] CHECK CONSTRAINT [FK_PT_Department_CheckList_PT_CheckList]
GO
ALTER TABLE [dbo].[PT_Department_CheckList]  WITH CHECK ADD  CONSTRAINT [FK_PT_Department_CheckList_PT_Department] FOREIGN KEY([DepartmentAutoID])
REFERENCES [dbo].[PT_Department] ([AutoID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PT_Department_CheckList] CHECK CONSTRAINT [FK_PT_Department_CheckList_PT_Department]
GO
ALTER TABLE [dbo].[PT_Department_CheckList] ADD  CONSTRAINT [DF_PT_Department_CheckList_Enable]  DEFAULT ((1)) FOR [Enable]
GO
