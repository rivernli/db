USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SendEmail_Invoice_Sale_Users]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SendEmail_Invoice_Sale_Users](
	[Account] [nvarchar](30) NOT NULL,
	[BOM] [nvarchar](30) NULL,
	[EmailType] [nvarchar](30) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[Enable] [bit] NULL,
 CONSTRAINT [PK_SendEmail_Invoice_Sale_Users] PRIMARY KEY CLUSTERED 
(
	[Account] ASC,
	[EmailType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
