USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblISTCycling]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblISTCycling](
	[ISTCyclingID] [int] IDENTITY(1,1) NOT NULL,
	[IST Cycling Name] [nvarchar](50) NULL,
	[Max # cycles] [int] NULL,
	[Test temperature] [int] NULL,
	[% Reject Sense] [int] NULL,
	[% Reject Power] [int] NULL,
	[Compensation] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblISTCycling] PRIMARY KEY CLUSTERED 
(
	[ISTCyclingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
