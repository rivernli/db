USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Get_117_ZhuHai_Sales_Account_Data]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Get_117_ZhuHai_Sales_Account_Data]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE name='sale_Account' AND XTYPE='U')
		BEGIN
			DROP TABLE sale_Account 
		END
	SELECT CONVERT(VARCHAR(50),account) AS Account ,Company 
	INTO sale_Account 
	FROM  HKGNT117.FactoryLoading.dbo.sale_Account 
	CREATE NONCLUSTERED INDEX [sale_Accountleac] ON [sale_Account ] 
	(
		[account] ASC
	)
		CREATE NONCLUSTERED INDEX [sale_AccountCompany] ON [sale_Account ] 
	(
		[Company] ASC
	)
	
	--DBCC SHRINKFILE (N'TestDB_Data' , 0)
	--DBCC SHRINKFILE (N'TestDB_Log' , 0)

END
GO
