USE [BOC]
GO
/****** Object:  Table [dbo].[tfsboc109180]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tfsboc109180](
	[T$dats] [nvarchar](50) NOT NULL,
	[T$year] [int] NOT NULL,
	[T$prno] [int] NOT NULL,
	[T$plnt] [nvarchar](10) NOT NULL,
	[T$csgs] [nvarchar](50) NULL,
	[T$ooem] [nvarchar](50) NOT NULL,
	[T$pjno] [nvarchar](50) NOT NULL,
	[T$bitm1] [nvarchar](50) NULL,
	[T$bitm2] [nvarchar](50) NULL,
	[T$bitm3] [nvarchar](50) NULL,
	[T$bitm4] [nvarchar](50) NULL,
	[T$bitm5] [nvarchar](50) NULL,
	[T$bitm6] [nvarchar](50) NULL,
	[T$bitm7] [nvarchar](50) NULL,
	[T$bitm8] [nvarchar](50) NULL,
	[T$bitm9] [nvarchar](50) NULL,
	[T$bitm10] [nvarchar](50) NULL,
	[T$bitm11] [nvarchar](50) NULL,
	[T$bitm12] [nvarchar](50) NULL,
	[T$bitm13] [nvarchar](50) NULL,
	[T$bitm14] [nvarchar](50) NULL,
	[T$bitm15] [nvarchar](50) NULL,
	[T$cons1] [float] NULL,
	[T$cons2] [float] NULL,
	[T$cons3] [float] NULL,
	[T$cons4] [float] NULL,
	[T$cons5] [float] NULL,
	[T$cons6] [float] NULL,
	[T$cons7] [float] NULL,
	[T$cons8] [float] NULL,
	[T$cons9] [float] NULL,
	[T$cons10] [float] NULL,
	[T$cons11] [float] NULL,
	[T$cons12] [float] NULL,
	[T$cons13] [float] NULL,
	[T$cons14] [float] NULL,
	[T$cons15] [float] NULL,
	[T$ouop] [float] NULL,
	[T$amnt] [float] NULL,
	[T$insq] [float] NULL,
	[T$ousq] [float] NULL,
	[T$cost] [float] NULL,
	[T$marg] [float] NULL,
	[T$trdt] [nvarchar](50) NULL,
	[T$trtm] [nvarchar](50) NULL,
	[T$fcns] [nvarchar](50) NULL,
	[T$otyp] [nvarchar](50) NULL,
	[T$damn] [float] NULL,
	[T$dmar] [float] NULL,
	[Column 136] [nvarchar](50) NULL,
	[Column 137] [nvarchar](50) NULL,
 CONSTRAINT [PK_tfsboc109180] PRIMARY KEY CLUSTERED 
(
	[T$dats] ASC,
	[T$year] ASC,
	[T$prno] ASC,
	[T$plnt] ASC,
	[T$ooem] ASC,
	[T$pjno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
