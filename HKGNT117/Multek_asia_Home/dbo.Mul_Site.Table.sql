USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Site]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mul_Site](
	[Site_Id] [int] IDENTITY(1,1) NOT NULL,
	[Site_Code] [nvarchar](20) NOT NULL,
	[Site_Description] [nvarchar](200) NULL,
 CONSTRAINT [PK_Mul_Site] PRIMARY KEY CLUSTERED 
(
	[Site_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
