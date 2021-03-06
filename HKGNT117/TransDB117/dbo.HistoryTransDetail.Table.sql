USE [TransDB117]
GO
/****** Object:  Table [dbo].[HistoryTransDetail]    Script Date: 2014/11/12 17:15:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HistoryTransDetail](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[TransAutoID] [int] NULL,
	[SourceTableName] [varchar](50) NULL,
	[TargetTableName] [varchar](50) NULL,
	[CatchSourceDataOK] [bit] NULL,
	[CatchSourceDataTime] [int] NULL,
	[CatchSourceDataErrorMessage] [varchar](4000) NULL,
	[CreateTargetTableOK] [bit] NULL,
	[CreateTargetTableTime] [int] NULL,
	[CreateTargetTableErrorMessage] [varchar](4000) NULL,
	[InsertDataIntoTargetTableOK] [bit] NULL,
	[InsertDataIntoTargetTableTime] [int] NULL,
	[InsertDataIntoTargetTableErrorMessage] [varchar](4000) NULL,
 CONSTRAINT [PK_HistoryTransDetail] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[HistoryTransDetail]  WITH CHECK ADD  CONSTRAINT [FK_HistoryTransDetail_HistoryTrans] FOREIGN KEY([TransAutoID])
REFERENCES [dbo].[HistoryTrans] ([AutoID])
GO
ALTER TABLE [dbo].[HistoryTransDetail] CHECK CONSTRAINT [FK_HistoryTransDetail_HistoryTrans]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sasasasa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'HistoryTransDetail', @level2type=N'CONSTRAINT',@level2name=N'FK_HistoryTransDetail_HistoryTrans'
GO
