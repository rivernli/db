USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B1Parts_Local_and_Oversea_List]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B1Parts_Local_and_Oversea_List](
	[Code] [nvarchar](50) NOT NULL,
	[Local_Oversea_PR_en] [nvarchar](50) NULL,
	[Local_Oversea_PR_ch] [nvarchar](50) NULL
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'555' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'ቹ栢㩘䖣钃愯畋끧' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Local and Oversea List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1965' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'皨껇췧䂊嚇譸穡ෂ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Local/Oversea PR(en)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Local/Oversea PR(en)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Local and Oversea List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_en'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1965' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'䥾물㿵䋃媕♲∺㲃' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Local/Oversea PR(ch)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Local/Oversea PR(ch)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Local and Oversea List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List', @level2type=N'COLUMN',@level2name=N'Local_Oversea_PR_ch'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'7/1/2011 8:09:39 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'7/1/2011 8:15:37 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'国内或国外PR单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Local and Oversea List' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Local_and_Oversea_List'
GO
