USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_Email_Settings_Info]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQM_Email_Settings_Info](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Lsh] [nvarchar](50) NOT NULL,
	[PLsh] [nvarchar](50) NULL,
	[Plant] [nvarchar](20) NULL,
	[Account] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Manager_Email] [nvarchar](100) NULL,
	[Remark] [nvarchar](max) NULL,
	[UserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SQM_Email_Settings_Info] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
