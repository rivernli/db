USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[Monthly_P_content_Data]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Monthly_P_content_Data](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Year] [varchar](5) NULL,
	[Plant] [varchar](10) NULL,
	[Site] [nvarchar](50) NULL,
	[Jan] [char](10) NULL,
	[Feb] [char](5) NULL,
	[Mar] [char](5) NULL,
	[Apr] [char](5) NULL,
	[May] [char](5) NULL,
	[Jun] [char](5) NULL,
	[Jul] [char](5) NULL,
	[Aug] [char](5) NULL,
	[Sep] [char](5) NULL,
	[Oct] [char](5) NULL,
	[Nov] [char](5) NULL,
	[Dec] [char](5) NULL,
 CONSTRAINT [PK_Monthly_P_content_Data] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
