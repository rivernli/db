USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Update_2D_Report_Upload_Authority]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Update_2D_Report_Upload_Authority]
	-- Add the parameters for the stored procedure here
	@Code VARCHAR(2),
	@UserID VARCHAR(50),
	@CanUpload BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF NOT EXISTS(SELECT * FROM ShipmentReport_2D_Report_Upload_Authority WHERE ReportCode=@Code AND UserID=@UserID)
		BEGIN
			INSERT INTO ShipmentReport_2D_Report_Upload_Authority (ReportCode,UserID,CanUpload)
					VALUES(@Code,@UserID,@CanUpload)
		END
	ELSE
		BEGIN
			UPDATE ShipmentReport_2D_Report_Upload_Authority
			SET CanUpload=@CanUpload
			WHERE ReportCode=@Code
				AND UserID=@UserID
		END
END
GO
