USE [BOC]
GO
/****** Object:  Table [dbo].[RightUserTable]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RightUserTable](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[manager] [nvarchar](50) NULL,
	[muid] [nvarchar](50) NULL,
	[salesman] [nvarchar](50) NULL,
	[suid] [nvarchar](50) NULL,
 CONSTRAINT [PK_RightUserTable] PRIMARY KEY CLUSTERED 
(
	[id] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
