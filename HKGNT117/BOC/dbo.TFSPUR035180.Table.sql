USE [BOC]
GO
/****** Object:  Table [dbo].[TFSPUR035180]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFSPUR035180](
	[t$year] [int] NOT NULL,
	[t$prod] [int] NOT NULL,
	[t$item] [nvarchar](32) NOT NULL,
	[t$suno] [nvarchar](6) NOT NULL,
	[t$citg] [nvarchar](6) NULL,
	[t$pric] [float] NULL,
	[t$fqty] [float] NULL,
	[t$plnt] [nvarchar](2) NOT NULL,
 CONSTRAINT [PK_TFSPUR035180] PRIMARY KEY CLUSTERED 
(
	[t$year] ASC,
	[t$prod] ASC,
	[t$item] ASC,
	[t$suno] ASC,
	[t$plnt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
