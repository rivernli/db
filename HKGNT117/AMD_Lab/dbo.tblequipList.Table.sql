USE [AMD_Lab]
GO
/****** Object:  Table [dbo].[tblequipList]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblequipList](
	[equipID] [int] IDENTITY(1,1) NOT NULL,
	[IDcode] [nvarchar](50) NULL,
	[SimpleID] [nvarchar](50) NOT NULL,
	[Mfg] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[Principle] [nvarchar](50) NULL,
	[S/N] [nvarchar](50) NULL,
	[Mfgdate] [datetime] NULL,
	[Installdate] [datetime] NULL,
	[Status] [nvarchar](50) NULL,
	[Supplier] [nvarchar](50) NULL,
	[SalesEngrName] [nvarchar](50) NULL,
	[SalesEngrM1] [nvarchar](50) NULL,
	[SalesEngrM2] [nvarchar](50) NULL,
	[SalesEngrM3] [nvarchar](50) NULL,
	[SalesEngrEmail] [nvarchar](50) NULL,
	[SvcEngrName] [nvarchar](50) NULL,
	[SvcEngrM1] [nvarchar](50) NULL,
	[SvcEngrM2] [nvarchar](50) NULL,
	[SvcEngrM3] [nvarchar](50) NULL,
	[SvcEngrEmail] [nvarchar](50) NULL,
	[AltSvcEngrName] [nvarchar](50) NULL,
	[AltSvcEngrM1] [nvarchar](50) NULL,
	[AltSvcEngrM2] [nvarchar](50) NULL,
	[AltSvcEngrM3] [nvarchar](50) NULL,
	[AltSvcEngrEmail] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblequipList] PRIMARY KEY CLUSTERED 
(
	[equipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
