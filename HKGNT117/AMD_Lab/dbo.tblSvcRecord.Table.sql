USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblSvcRecord]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSvcRecord](
	[svcrcdid] [int] IDENTITY(1,1) NOT NULL,
	[equipID] [int] NULL,
	[SimpleID] [nvarchar](50) NOT NULL,
	[Date] [datetime] NULL,
	[ServiceEng] [nvarchar](50) NULL,
	[Odometer] [nvarchar](50) NULL,
	[Problem] [nvarchar](max) NULL,
	[Action] [nvarchar](max) NULL,
	[SvcType] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[ServiceReport] [bit] NOT NULL,
 CONSTRAINT [PK_tblSvcRecord] PRIMARY KEY CLUSTERED 
(
	[svcrcdid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
