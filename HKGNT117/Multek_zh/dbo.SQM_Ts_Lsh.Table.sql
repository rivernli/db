USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[SQM_Ts_Lsh]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQM_Ts_Lsh](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ModuleName] [nvarchar](50) NULL,
	[KeyName] [nvarchar](50) NULL,
	[Lsh] [int] NULL,
	[Parm1] [nvarchar](20) NULL,
 CONSTRAINT [PK_SQM_Ts_Lsh] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号前缀' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SQM_Ts_Lsh', @level2type=N'COLUMN',@level2name=N'KeyName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附加参数1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SQM_Ts_Lsh', @level2type=N'COLUMN',@level2name=N'Parm1'
GO
