USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_Automatically_Update_User_Information]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Automatically_Update_User_Information] 
	-- Add the parameters for the stored procedure here
	@OldAccount VARCHAR(100),
	@NewAccount VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--ShipmentReport
	UPDATE dbo.ShipmentReport_Users
	SET USERID=@NewAccount,
		Region=LEFT(@NewAccount,CHARINDEX('\',@NewAccount)-1),
		Account=RIGHT(@NewAccount,LEN(@NewAccount)-CHARINDEX('\',@NewAccount))
	WHERE USERID=@OldAccount
	
	UPDATE dbo.ShipmentReport_2D_Report_Upload_Authority
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount

	UPDATE dbo.ShipmentReport_Baan_Handly_File
	SET uploader=REPLACE(uploader,@OldAccount,@NewAccount)
	UPDATE dbo.ShipmentReport_Baan_Handly_File_Downloaded_History
	SET downloaduserid=REPLACE(downloaduserid,@OldAccount,@NewAccount)

	UPDATE dbo.ShipmentReport_Engineering_Evaluation_File
	SET uploader=REPLACE(uploader,@OldAccount,@NewAccount)
	UPDATE dbo.ShipmentReport_Engineering_Evaluation_File_Downloaded_History
	SET downloaduserid=REPLACE(downloaduserid,@OldAccount,@NewAccount)

	UPDATE dbo.ShipmentReport_Weekly_Operation_Report
	SET uploader=REPLACE(uploader,@OldAccount,@NewAccount)
	UPDATE dbo.ShipmentReport_Weekly_Operation_Report_Downloaded_History
	SET downloaduserid=REPLACE(downloaduserid,@OldAccount,@NewAccount)

	UPDATE dbo.ShipmentReport_Log
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount

	UPDATE dbo.ShipmentReport_Shipped_All_Forecast_History
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount
	
	--DistributionReport
	UPDATE dbo.DistributionReport_Users
	SET USERID=@NewAccount,
		Region=LEFT(@NewAccount,CHARINDEX('\',@NewAccount)-1),
		Account=RIGHT(@NewAccount,LEN(@NewAccount)-CHARINDEX('\',@NewAccount))
	WHERE USERID=@OldAccount
	
	UPDATE dbo.DistributionReport_Authority
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount
	
	UPDATE dbo.DistributionReport_Forecast_History
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount

	UPDATE dbo.DistributionReport_Forecast_Authority
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount

	UPDATE dbo.DistributionReport_Log
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount

	--QualityReport
	UPDATE dbo.QualityReport_Users
	SET USERID=@NewAccount,
		Region=LEFT(@NewAccount,CHARINDEX('\',@NewAccount)-1),
		Account=RIGHT(@NewAccount,LEN(@NewAccount)-CHARINDEX('\',@NewAccount))
	WHERE USERID=@OldAccount

	UPDATE dbo.QualityReport_Authority
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount
	
	UPDATE dbo.QualityReport_Log
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount

	--SalesAnalysis
	UPDATE SalesAnalysis_Users
	SET USERID=@NewAccount,
		Region=LEFT(@NewAccount,CHARINDEX('\',@NewAccount)-1),
		Account=RIGHT(@NewAccount,LEN(@NewAccount)-CHARINDEX('\',@NewAccount))
	WHERE USERID=@OldAccount

	UPDATE SalesAnalysis_Authority
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount
	
	--PT
	UPDATE dbo.PT_Users
	SET USERID=@NewAccount,
		Region=LEFT(@NewAccount,CHARINDEX('\',@NewAccount)-1),
		Account=RIGHT(@NewAccount,LEN(@NewAccount)-CHARINDEX('\',@NewAccount))
	WHERE USERID=@OldAccount
	
	UPDATE dbo.PT_Authority
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount

	UPDATE dbo.PT_Order
	SET TransferingSiteOwnerUserID=REPLACE(TransferingSiteOwnerUserID,@OldAccount,@NewAccount),
		ReceivingSiteOwnerUserID=REPLACE(ReceivingSiteOwnerUserID,@OldAccount,@NewAccount),
		ClosedUserID=REPLACE(ClosedUserID,@OldAccount,@NewAccount),
		CreatedUserID=REPLACE(CreatedUserID,@OldAccount,@NewAccount),
		DeletedUserID=REPLACE(DeletedUserID,@OldAccount,@NewAccount),
		LastUpdatedUserID=REPLACE(LastUpdatedUserID,@OldAccount,@NewAccount)

	UPDATE dbo.PT_Order_CheckList_Comment
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount
	
	UPDATE dbo.PT_Order_CheckList_Detail
	SET TransferUserID=REPLACE(TransferUserID,@OldAccount,@NewAccount)
	
	UPDATE dbo.PT_Order_CheckList_Detail_DownLoad
	SET ReceivingDownloadUserID=REPLACE(ReceivingDownloadUserID,@OldAccount,@NewAccount)
	
	--ContractTracker
	UPDATE ContractTracker.dbo.Users
	SET USERID=@NewAccount,
		Region=LEFT(@NewAccount,CHARINDEX('\',@NewAccount)-1),
		Account=RIGHT(@NewAccount,LEN(@NewAccount)-CHARINDEX('\',@NewAccount))
	WHERE USERID=@OldAccount

	UPDATE ContractTracker.dbo.Authority
	SET USERID=@NewAccount
	WHERE USERID=@OldAccount

END
GO
