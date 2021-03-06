USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[Mul_Forum_Category]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mul_Forum_Category](
	[Fc_Id] [uniqueidentifier] NOT NULL,
	[Fc_Name] [nvarchar](50) NOT NULL,
	[Fc_Enabled] [bit] NOT NULL,
	[Fc_CreatedBy] [varchar](50) NULL,
	[Fc_CreatedOn] [datetime] NULL,
	[Fc_ModifiedBy] [varchar](50) NULL,
	[Fc_ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_Mul_Forum_Category] PRIMARY KEY CLUSTERED 
(
	[Fc_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
