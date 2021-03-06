USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[AccountProfile_Customer_Authority]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountProfile_Customer_Authority](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Customer] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[User_Right] [bit] NULL CONSTRAINT [DF_AccountProfile_Customer_Authority_User_Right]  DEFAULT ((0)),
 CONSTRAINT [PK_AccountProfile_Customer_Control] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
