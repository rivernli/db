USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_Assign_Task]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SQM_Assign_Task](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[AssignTo] [nvarchar](50) NULL,
	[AssignEmail] [nvarchar](50) NULL,
	[AssignUntilDate] [varchar](20) NULL,
 CONSTRAINT [PK_SQM_Assign_Task] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
