USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[EXR2_Plant]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXR2_Plant](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[Plant] [nvarchar](50) NULL,
 CONSTRAINT [PK_EXR2_Plant] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
