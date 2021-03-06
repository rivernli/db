USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblLaminateSpec]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLaminateSpec](
	[LamSpecID] [int] IDENTITY(1,1) NOT NULL,
	[LamName] [nvarchar](50) NOT NULL,
	[LamSupplier] [nvarchar](50) NOT NULL,
	[LamDesc] [ntext] NULL,
	[CTELo] [real] NULL,
	[CTEHi] [real] NULL,
	[DSCTg] [nvarchar](50) NULL,
	[TMATg] [nvarchar](50) NULL,
	[TMATg20nly] [nvarchar](50) NULL,
	[DMATg] [nvarchar](50) NULL,
	[Zexpansion] [real] NULL,
	[Td5] [real] NULL,
	[CAFRes] [smallint] NULL,
	[ResinContent] [smallint] NULL,
	[Dk1] [nvarchar](50) NULL,
	[Dk2] [nvarchar](50) NULL,
	[Df1] [nvarchar](50) NULL,
	[Df2] [nvarchar](50) NULL,
	[SurfRes] [real] NULL,
	[VolRes] [real] NULL,
	[ElectStr] [int] NULL,
	[ArcRes] [int] NULL,
	[T260] [int] NULL,
	[T288] [int] NULL,
	[FTIRSpec] [image] NULL,
	[EDXSpec] [image] NULL,
	[Td05] [real] NULL,
	[FTIR_Spec] [nvarchar](max) NULL,
	[EDX_Spec] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblLaminateSpec] PRIMARY KEY CLUSTERED 
(
	[LamSpecID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
