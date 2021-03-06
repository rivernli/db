USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[B1Parts_Paste_Errors]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B1Parts_Paste_Errors](
	[Field0] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'2052' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Field0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Field0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'Paste Errors' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors', @level2type=N'COLUMN',@level2name=N'Field0'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'9/1/2011 2:53:17 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'9/1/2011 2:53:17 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Paste Errors' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'B1Parts_Paste_Errors'
GO
