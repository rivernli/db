USE [BOC]
GO
/****** Object:  Table [dbo].[Authority_User]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authority_User](
	[Autoid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [nvarchar](50) NOT NULL,
	[Region] [nvarchar](50) NULL,
	[Account] [nvarchar](50) NULL,
	[username] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[role] [int] NULL,
	[price] [int] NULL,
	[Enable] [bit] NULL,
 CONSTRAINT [PK_Authority User] PRIMARY KEY CLUSTERED 
(
	[Autoid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Authority_User]  WITH CHECK ADD  CONSTRAINT [FK_Authority_User_Authority_Price] FOREIGN KEY([price])
REFERENCES [dbo].[Authority_Price] ([ID])
GO
ALTER TABLE [dbo].[Authority_User] CHECK CONSTRAINT [FK_Authority_User_Authority_Price]
GO
ALTER TABLE [dbo].[Authority_User]  WITH CHECK ADD  CONSTRAINT [FK_Authority_User_Authority_Role] FOREIGN KEY([role])
REFERENCES [dbo].[Authority_Role] ([ID])
GO
ALTER TABLE [dbo].[Authority_User] CHECK CONSTRAINT [FK_Authority_User_Authority_Role]
GO
