USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_OEEAnalysis]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_OEEAnalysis](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](50) NOT NULL,
	[PBPID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[WorkingDays] [int] NOT NULL,
	[D01] [decimal](18, 2) NULL,
	[D02] [decimal](18, 2) NULL,
	[D03] [decimal](18, 2) NULL,
	[D04] [decimal](18, 2) NULL,
	[D05] [decimal](18, 2) NULL,
	[D06] [decimal](18, 2) NULL,
	[YieldRate] [decimal](18, 4) NULL,
	[Remark] [varchar](4000) NULL,
 CONSTRAINT [PK_IES_OEEAnalysis] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[IES_OEEAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_IES_OEEAnalysis_IES_ProcessByPlant] FOREIGN KEY([PBPID])
REFERENCES [dbo].[IES_ProcessByPlant] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IES_OEEAnalysis] CHECK CONSTRAINT [FK_IES_OEEAnalysis_IES_ProcessByPlant]
GO
