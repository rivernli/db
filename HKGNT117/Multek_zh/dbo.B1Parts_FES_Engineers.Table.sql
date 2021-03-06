USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B1Parts_FES_Engineers]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B1Parts_FES_Engineers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Group] [nvarchar](50) NULL CONSTRAINT [DF__FES Engin__Group__239E4DCF]  DEFAULT (N'电子组'),
	[ESUserNo] [nvarchar](3) NULL,
	[ESUserName] [nvarchar](50) NULL,
	[PhoneNo] [nvarchar](50) NULL,
 CONSTRAINT [PK_B1Parts_FES_Engineers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'810' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'"电子组"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'뀶嫝꒖䷫碧앞䋚�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Group' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Group' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'FES Engineers' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1125' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'如닯䝋��텸紌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ES User No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ES User No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'FES Engineers' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'Len([ES User No])=3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserNo'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'810' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'ᢵ⾸䰒꾅꭛〉㿞' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ES User Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ES User Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'FES Engineers' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers', @level2type=N'COLUMN',@level2name=N'ESUserName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/30/2011 10:06:53 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/30/2011 10:43:49 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'配件领用人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'FES Engineers' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'45' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_FES_Engineers'
GO
