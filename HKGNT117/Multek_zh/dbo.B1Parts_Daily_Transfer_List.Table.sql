USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B1Parts_Daily_Transfer_List]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B1Parts_Daily_Transfer_List](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL CONSTRAINT [DF__B1Parts_Da__Date__0C526AD1]  DEFAULT (CONVERT([datetime],CONVERT([varchar],getdate(),(1)),(1))),
	[PartNO] [nvarchar](50) NOT NULL,
	[Item] [int] NULL CONSTRAINT [DF__B1Parts_Da__Item__0D468F0A]  DEFAULT ((0)),
	[TransferQty] [float] NULL CONSTRAINT [DF__B1Parts_D__Trans__0E3AB343]  DEFAULT ((0)),
	[TransferTo] [nvarchar](50) NULL,
	[Price] [float] NULL CONSTRAINT [DF__B1Parts_D__Price__0F2ED77C]  DEFAULT ((0)),
	[Remark] [ntext] NULL,
 CONSTRAINT [PK_B1Parts_Daily_Transfer_List] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[B1Parts_Daily_Transfer_List]  WITH CHECK ADD  CONSTRAINT [CK Daily Transfer List Item] CHECK  (([Item]<=(10)))
GO
ALTER TABLE [dbo].[B1Parts_Daily_Transfer_List] CHECK CONSTRAINT [CK Daily Transfer List Item]
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'810' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'옘鱸ﺶ䥟쪊奋梏�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Daily Transfer List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1365' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'Date()' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'匕芕심䠋㲓뽈ꤿₕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'mm\/dd\/yyyy' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Daily Transfer List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'<=Date()' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationText', @value=N'您发出配件日期不可能大于当日!' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1845' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'輒㣿⚨䖆岬縊' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Part NO' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Part NO' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Daily Transfer List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'PartNO'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'495' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'㓸鑘䕀풃Ąꎼ娲' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Item' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Item' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Daily Transfer List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'<=10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationText', @value=N'您输入的SPR单记录数不能超过10条!' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Item'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1485' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'�닥㙛䦼隙ᕅ㊚꘶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Transfer Qty' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Transfer Qty' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Daily Transfer List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationRule', @value=N'Is Not Null' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'ValidationText', @value=N'您不能输入空值!' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferQty'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1410' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'咦絗䡹媩쯿莶怖' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Transfer To' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Transfer To' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Daily Transfer List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'TransferTo'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'〷䝕ᶂ⾹맥⦙' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'Fixed' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Price' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Price' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Daily Transfer List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1995' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'킄鍴潢䘫庭槴롈च' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Remark' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Remark' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Daily Transfer List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetBackColor', @value=N'12632256' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetCellsEffect', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontHeight', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontItalic', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontName', @value=N'宋体' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontUnderline', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetFontWeight', @value=N'700' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeColor', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesColor', @value=N'16777215' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'8/19/2011 9:22:19 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'FrozenColumns', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'8/22/2011 10:19:46 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'每日转出表
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'[Daily Transfer List].ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Daily Transfer List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'RowHeight', @value=N'435' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'TabularCharSet', @value=N'134' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'TabularFamily', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ConstraintText', @value=N'您输入的SPR单记录数不能超过10条!' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Daily_Transfer_List', @level2type=N'CONSTRAINT',@level2name=N'CK Daily Transfer List Item'
GO
