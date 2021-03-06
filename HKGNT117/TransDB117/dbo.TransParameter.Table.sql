USE [TransDB117]
GO
/****** Object:  Table [dbo].[TransParameter]    Script Date: 2014/11/12 17:15:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TransParameter](
	[VariableName] [varchar](50) NOT NULL,
	[VariableValue] [varchar](100) NULL,
 CONSTRAINT [PK_TransParameter] PRIMARY KEY CLUSTERED 
(
	[VariableName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
