USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[Monthly_Cu_Tensile_Strength_Authority]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Monthly_Cu_Tensile_Strength_Authority](
	[UserID] [varchar](50) NOT NULL,
	[MenuID] [varchar](50) NOT NULL,
	[CanSee] [bit] NOT NULL,
	[CanAdd] [bit] NOT NULL,
	[CanModify] [bit] NOT NULL,
	[CanDelete] [bit] NOT NULL,
	[User_Right] [bit] NULL,
 CONSTRAINT [PK_Monthly_Cu_Tensile_Strength_Authority] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Monthly_Cu_Tensile_Strength_Authority]  WITH CHECK ADD  CONSTRAINT [Monthly_Cu_Tensile_Strength_Authority_Menu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[Monthly_Cu_Tensile_Strength_Menu] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Monthly_Cu_Tensile_Strength_Authority] CHECK CONSTRAINT [Monthly_Cu_Tensile_Strength_Authority_Menu]
GO
ALTER TABLE [dbo].[Monthly_Cu_Tensile_Strength_Authority]  WITH CHECK ADD  CONSTRAINT [Monthly_Cu_Tensile_Strength_Authority_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Monthly_Cu_Tensile_Strength_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Monthly_Cu_Tensile_Strength_Authority] CHECK CONSTRAINT [Monthly_Cu_Tensile_Strength_Authority_Users]
GO
