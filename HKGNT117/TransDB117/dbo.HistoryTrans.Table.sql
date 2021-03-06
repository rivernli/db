USE [TransDB117]
GO
/****** Object:  Table [dbo].[HistoryTrans]    Script Date: 2014/11/12 17:15:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoryTrans](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[TransDate] [datetime] NULL,
	[ErrorCount] [int] NULL,
	[Time] [int] NULL,
 CONSTRAINT [PK_HistoryTrans] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
