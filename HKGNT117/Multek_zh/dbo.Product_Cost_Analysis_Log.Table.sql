USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[Product_Cost_Analysis_Log]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product_Cost_Analysis_Log](
	[AutoID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[Operation] [varchar](50) NOT NULL,
	[OperatedDate] [datetime] NOT NULL CONSTRAINT [DF_Product_Cost_Analysis_Log_OperatedDate]  DEFAULT (getdate()),
	[Remark] [varchar](500) NULL,
 CONSTRAINT [PK_Product_Cost_Analysis_Log] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
