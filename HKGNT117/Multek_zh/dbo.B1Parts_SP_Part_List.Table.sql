USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B1Parts_SP_Part_List]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B1Parts_SP_Part_List](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OldPN] [nvarchar](255) NULL,
	[NewPN] [nvarchar](50) NULL,
	[NewDescription] [nvarchar](100) NULL,
	[Type] [nvarchar](500) NULL,
	[Unit] [nvarchar](50) NULL CONSTRAINT [DF__SP Part Li__Unit__014935CB]  DEFAULT ('PCS'),
	[Baanrice] [numeric](18, 2) NULL CONSTRAINT [DF__SP Part L__Baan __023D5A04]  DEFAULT ((0)),
	[ABC] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[Max] [int] NULL CONSTRAINT [DF__SP Part Lis__Max__03317E3D]  DEFAULT ((0)),
	[Min] [int] NULL CONSTRAINT [DF__SP Part Lis__Min__0425A276]  DEFAULT ((0)),
	[Belongto] [nvarchar](50) NULL,
	[PhotoType] [nvarchar](50) NULL,
	[Remark] [nvarchar](max) NULL,
 CONSTRAINT [PK_B1Parts_SP_Part_List] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'555' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'Ⲝ怦䡴ꪁ覉ᗡ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1575' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'뷂糮怜䲍馪왏ṻ髗' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Original Part No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Old PN' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Old PN' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'OldPN'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1830' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'쑈ᝐ✶䬌嚒䅸' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Standard Part No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'New PN' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'New PN' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewPN'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'4620' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'窾蝼�仛掦錁ⱴ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'New Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'New Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'New Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'Is Not Null' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationText', @value=N'您输入的物料名称不可能为空值!!!' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'NewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'525' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'"PCS"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'뒋椄⪑䗐�鉆쓈䗩' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Material Unit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Unit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Unit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'Is Not Null' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationText', @value=N'您输入的值不可能为空值!' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1320' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'눩㒄珢䞚閤ᳰ惎' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'$#,##0.00;($#,##0.00)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Baan Price' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Baan Price' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'Is Not Null' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationText', @value=N'不能输入空值!' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Baanrice'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'510' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'浨폻ꚓ䞷⾻䂩ﶟ볌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'按A，B，C分类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ABC' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ABC' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'="A" Or "B" Or "C" Or "D" Or Like "A*" Or Like "B*" Or Like "C*"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationText', @value=N'你输入的类别没有定义，请确定后重新输入！！！' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'ABC'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1035' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'卸덂携䃸솭汪嬐鐵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Location' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Location' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Location' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'450' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'吻躪䐊톒ᝎ⋁羆' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大存量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Max' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Max' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'Is Not Null' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationText', @value=N'不能为空值!' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Max'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'450' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'ẅ⵷䗁ꪖ뙳�语' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最小存量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Min' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Min' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'Is Not Null' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationText', @value=N'不能为空值!' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Min'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2400' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'㹢戾薬䆵⦞蛃阒悘' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属设备' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Belong to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'11' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Belong to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List', @level2type=N'COLUMN',@level2name=N'Belongto'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetBackColor', @value=N'16777215' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetCellsEffect', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontHeight', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontItalic', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontName', @value=N'新宋体' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontUnderline', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontWeight', @value=N'700' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeColor', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesBehavior', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesColor', @value=N'16777215' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/29/2011 4:25:05 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'9/4/2011 9:06:28 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'配件编号表
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=N'(([SP Part List].[New PN]="SP-0021-000076"))' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'[SP Part List].ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SubdatasheetName', @value=N'[Auto]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'SP Part List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'4091' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'RowHeight', @value=N'285' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'TabularCharSet', @value=N'134' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'TabularFamily', @value=N'49' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_SP_Part_List'
GO
