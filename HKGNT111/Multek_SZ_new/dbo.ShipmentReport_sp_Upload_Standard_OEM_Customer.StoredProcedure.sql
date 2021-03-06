USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Upload_Standard_OEM_Customer]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Upload_Standard_OEM_Customer]
	@Operator VARCHAR(50),
	@UploadedFile VARCHAR(100)=NULL
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	/*
	DECLARE @Baan_OEM VARCHAR(MAX),@Baan_Customer  VARCHAR(MAX),@Baan_Loc  VARCHAR(3),@Standard_OEM  VARCHAR(MAX),@Standard_Customer VARCHAR(MAX)
	DECLARE StandardOEMCustomer CURSOR FOR 
	SELECT [Baan OEM],[Baan Customer],[Baan Loc],[Standard OEM],[Standard Customer]
	FROM OpenDataSource( 'Microsoft.Jet.OLEDB.4.0', 'Data Source="D:\wwwroot\ShipmentReport\Document\OEM Customer.xls";User ID=Admin;Password=;Extended properties=Excel 5.0')...Sheet1$ 

	OPEN StandardOEMCustomer
	FETCH NEXT FROM StandardOEMCustomer INTO @Baan_OEM,@Baan_Customer,@Baan_Loc,@Standard_OEM,@Standard_Customer

	WHILE @@FETCH_STATUS=0
		BEGIN
			EXECUTE ShipmentReport_sp_Update_Standard_OEM_Customer @Baan_OEM=@Baan_OEM,@Baan_Customer=@Baan_Customer,@Baan_Loc=@Baan_Loc,@Standard_OEM=@Standard_OEM,@Standard_Customer=@Standard_Customer,@Operator=@operator,@Remark='Upload'
			FETCH NEXT FROM StandardOEMCustomer INTO @Baan_OEM,@Baan_Customer,@Baan_Loc,@Standard_OEM,@Standard_Customer
		END
	
	CLOSE StandardOEMCustomer
	DEALLOCATE StandardOEMCustomer
	*/

--SELECT * FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0','Excel 8.0;Database=D:\wwwroot\ShipmentReport\Document\4bb025b6-61f8-48d3-a8b1-a152ead3fe40.xls', 'SELECT * FROM [OEM Customer Mapping List$]')

	DECLARE @SQLString VARCHAR(MAX)
	CREATE TABLE #StandardOEMCustomer (Baan_OEM VARCHAR(MAX),Baan_Customer VARCHAR(MAX),Baan_Loc VARCHAR(3),STD_OEM VARCHAR(MAX),STD_Customer VARCHAR(MAX))
	SET @SQLString='INSERT INTO #StandardOEMCustomer '
	SET @SQLString=@SQLString+'SELECT RTRIM(LTRIM([Baan OEM])),RTRIM(LTRIM([Baan Customer])),RTRIM(LTRIM([Baan Location])),RTRIM(LTRIM([Standard OEM])),RTRIM(LTRIM([Standard Customer]))'
	SET @SQLString=@SQLString+' FROM OPENROWSET('+''''+'Microsoft.Jet.OLEDB.4.0'+''''+','+''''+'Excel 8.0;Database=D:\wwwroot\ShipmentReport\Document\'+@UploadedFile+''''+','+''''+ 'SELECT * FROM ['+'MappingList'+'$]'+''''+')'
	EXECUTE (@SQLString)

	DELETE #StandardOEMCustomer WHERE LTRIM(RTRIM(ISNULL(Std_Customer,'')))='' AND LTRIM(RTRIM(ISNULL(Std_OEM,'')))=''

	UPDATE ShipmentReport_OEM_Customer
	SET Std_OEM=ISNULL(b.Std_OEM,''),Std_Customer=ISNULL(b.Std_Customer,''),Updater=@Operator+' (Upload)',Updated_Time=GETDATE(),Remark='Upload'
	FROM ShipmentReport_OEM_Customer a,#StandardOEMCustomer b
	WHERE LTRIM(RTRIM(a.Baan_OEM))=LTRIM(RTRIM(b.Baan_OEM))
		AND LTRIM(RTRIM(a.Baan_Customer))=LTRIM(RTRIM(b.Baan_Customer))
		AND LTRIM(RTRIM(a.Baan_Loc))=LTRIM(RTRIM(b.Baan_Loc))
END
GO
