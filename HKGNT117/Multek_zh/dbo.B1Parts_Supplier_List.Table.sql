USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B1Parts_Supplier_List]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B1Parts_Supplier_List](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VendorNo] [nvarchar](50) NOT NULL,
	[VendorName] [nvarchar](50) NULL,
 CONSTRAINT [aaaaaSupplier List2_PK] PRIMARY KEY NONCLUSTERED 
(
	[VendorNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'630' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'眾繉᯦䋚澇ᮊꐛ跇' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Supplier List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'검ꔖﳀ䯾醓쪷㻩책' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Vendor No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Vendor No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Supplier List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'5895' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'걓䘼ꚿ痓�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Vendor Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Vendor Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Supplier List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List', @level2type=N'COLUMN',@level2name=N'VendorName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontHeight', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontItalic', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontName', @value=N'宋体' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontUnderline', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontWeight', @value=N'700' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeColor', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/30/2011 2:35:21 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/4/2011 3:06:00 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'[Supplier List].ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Supplier List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'206' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'TabularCharSet', @value=N'134' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'TabularFamily', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Supplier_List'
GO
