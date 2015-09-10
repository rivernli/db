USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[PT_Location]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PT_Location](
	[AutoID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Alias] [varchar](3) NOT NULL,
	[Enable] [bit] NOT NULL,
 CONSTRAINT [PK_PT_Location] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PT_Location] ADD  CONSTRAINT [DF_PT_Location_Enable]  DEFAULT ((1)) FOR [Enable]
GO
