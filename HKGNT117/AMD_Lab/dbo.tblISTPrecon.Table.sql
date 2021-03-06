USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblISTPrecon]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblISTPrecon](
	[PreconditioningID] [int] IDENTITY(1,1) NOT NULL,
	[Preconditioning Name] [nvarchar](50) NULL,
	[Preconditioning Temp] [smallint] NULL,
	[Reflow Temp] [smallint] NULL,
	[Reflow Profile Name] [nvarchar](50) NULL,
	[# of cycles] [tinyint] NULL,
 CONSTRAINT [PK_tblISTPrecon] PRIMARY KEY CLUSTERED 
(
	[PreconditioningID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
