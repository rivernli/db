USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SendEmail_Invoice_Sale_History]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SendEmail_Invoice_Sale_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Today] [datetime] NULL,
	[FYear] [nvarchar](10) NULL,
	[FPeriod] [nvarchar](5) NULL,
	[Amount] [money] NULL,
 CONSTRAINT [PK_SendEmail_Invoice_Sale_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
