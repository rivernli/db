USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Cancellation_ppc_Email]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cancellation_ppc_Email](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Plant] [nvarchar](5) NOT NULL,
	[Email] [nvarchar](70) NOT NULL,
 CONSTRAINT [PK_Cancellation_ppc_Email] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
