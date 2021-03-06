USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_InsertUpdateDelete_Baan_Handly_File_Download_History]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_InsertUpdateDelete_Baan_Handly_File_Download_History]
	-- Add the parameters for the stored procedure here
	@FileAutoID INT,
	@OperationUserID VARCHAR(50),
	@OperationType VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @OperationType='Insert'
		BEGIN
			INSERT INTO ShipmentReport_Baan_Handly_File_Downloaded_History(FileAutoID,DownloadUserID)
				VALUES(@FileAutoID,@OperationUserID)
		END

END
GO
