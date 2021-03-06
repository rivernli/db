USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B1Parts_Opening_Inventory_SP]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B1Parts_Opening_Inventory_SP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPNO_Opening] [nvarchar](50) NOT NULL,
	[Stocktaking_Qty] [float] NULL CONSTRAINT [DF__B1Parts_O__Stock__214D87B7]  DEFAULT ((0)),
	[Stocktaking_Date] [datetime] NULL,
	[Last_Received_Date] [datetime] NULL,
	[Remark] [ntext] NULL,
 CONSTRAINT [aaaaaOpening Inventory-SP2_PK] PRIMARY KEY NONCLUSTERED 
(
	[SPNO_Opening] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'525' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'鯰ᫍ䶘窄戢啝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Opening Inventory-SP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'뼱簤䱀䂇剖벢' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'SPNO-Opening' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'SPNO-Opening' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Opening Inventory-SP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'SPNO_Opening'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1515' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'턥뛉뫹亢侪遏ቶ댻' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Stocktaking Qty' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Stocktaking Qty' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Opening Inventory-SP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1635' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'䌺Ẁ侀킇आ緫' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Stocktaking Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Stocktaking Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Opening Inventory-SP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Stocktaking_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1890' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'仇䮖品乇狎铮꫋' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Last Received Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Last Received Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Opening Inventory-SP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Last_Received_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1695' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'皩峌舙䭺딇ܝꑀ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Remark' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Remark' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Opening Inventory-SP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/30/2011 10:10:09 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/1/2011 7:45:03 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'期初库存表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'[Opening Inventory-SP].ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Opening Inventory-SP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'3766' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Opening_Inventory_SP'
GO
