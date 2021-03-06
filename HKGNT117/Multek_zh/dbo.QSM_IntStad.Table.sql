USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[QSM_IntStad]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QSM_IntStad](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeID] [int] NULL,
	[FileKey] [varchar](20) NULL,
	[Number] [varchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Version] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [varchar](25) NULL,
 CONSTRAINT [PK_QSM_IntStad] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[QSM_IntStad]  WITH CHECK ADD  CONSTRAINT [FK_QSM_IntStad_QSM_IntStadTree] FOREIGN KEY([TypeID])
REFERENCES [dbo].[QSM_IntStadTree] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QSM_IntStad] CHECK CONSTRAINT [FK_QSM_IntStad_QSM_IntStadTree]
GO
