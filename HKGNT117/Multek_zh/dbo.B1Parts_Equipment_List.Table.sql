USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B1Parts_Equipment_List]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B1Parts_Equipment_List](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EqAr] [nvarchar](50) NULL,
	[EqNo] [nvarchar](50) NOT NULL,
	[EqDe] [nvarchar](50) NULL,
	[Remarks] [nvarchar](max) NULL,
 CONSTRAINT [PK_B1Parts_Equipment_List] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1245' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'㣡⦹�䢘悮ᔈ岒뻶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Equipment area' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'EqAr' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'EqAr' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Equipment List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'Is Not Null' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationText', @value=N'不可能输入空值！！！' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqAr'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2160' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'溊散棩䭍蒕뱽𳄳' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Equipment No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'EqNo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'EqNo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Equipment List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqNo'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'6000' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'㴷­ᅒ䶌獵㙅醷⭥' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Equipment description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'EqDe' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'EqDe' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Equipment List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'EqDe'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'啍୞龰䅪檨燯㆓乮' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Remarks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'"255"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Remarks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Remarks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Equipment List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetBackColor', @value=N'16777164' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontHeight', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontItalic', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontName', @value=N'新宋体' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontUnderline', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontWeight', @value=N'700' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeColor', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/30/2011 10:05:10 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/30/2011 10:16:47 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备编号表
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Equipment List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'606' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'TabularCharSet', @value=N'134' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'TabularFamily', @value=N'49' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Equipment_List'
GO
