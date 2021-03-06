USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_InsertUpdateDelete_Baan_Handly_File]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_InsertUpdateDelete_Baan_Handly_File]
	-- Add the parameters for the stored procedure here
	@Kind VARCHAR(50)=NULL,
	@AutoID INT=NULL,
	@PhysicalFileName VARCHAR(50)=NULL,
	@FileName VARCHAR(255)=NULL,
	@FileDescription VARCHAR(500)=NULL,
	@Uploader VARCHAR(50)=NULL,
	@Operation VARCHAR(10)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Option VARCHAR(MAX),@Comment VARCHAR(MAX),@MenuID VARCHAR(50) 
	IF @Operation='Add'
		BEGIN
			INSERT INTO ShipmentReport_Baan_Handly_File(PhysicalFileName,FileName,FileDescription,Uploader,Kind)
				VALUES (@PhysicalFileName,@FileName,@FileDescription,@Uploader,@Kind)
			SET @Option='Baan Handly File'
			SET @Comment=(
							CASE @Kind WHEN 'A' THEN 'total material cost trend based on last P12'
									   WHEN 'B' THEN 'total material cost trend Q2Q'
									   WHEN 'C' THEN 'materials cost trend by supplier and item group'
									   WHEN 'D' THEN 'book To bill (B2B)'
									   WHEN 'E' THEN 'hub inventory trend'
									   WHEN 'F' THEN 'EDM and OS consumption'
									   WHEN 'G' THEN 'material price trend in moving 12 periods for those having price change'
									   WHEN 'H' THEN 'exfactory-output and KPI ($ & ft2)'
									   WHEN 'I' THEN 'invoice sales and main categories '
									   WHEN 'J' THEN 'invoice sales and KPI'
									   WHEN 'K' THEN 'Monthly MSS Loading per OEM vs MKT forecast update'
									   WHEN 'L' THEN 'Daily reports for billed revenue and backlog orders'
								ELSE
								       ''
								END
						 )
			SET @MenuID=(
							CASE @Kind WHEN 'A' THEN '0000300008'
									   WHEN 'B' THEN '0000300009'
									   WHEN 'C' THEN '0000300010'
									   WHEN 'D' THEN '0000300011'
									   WHEN 'E' THEN '0000300012'
									   WHEN 'F' THEN '0000300013'
									   WHEN 'G' THEN '0000300014'
									   WHEN 'H' THEN '0000300015'
									   WHEN 'I' THEN '0000300016'
									   WHEN 'J' THEN '0000300017'
									   WHEN 'K' THEN '0000300018'
									   WHEN 'L' THEN '0000300019'
								ELSE
								       ''
								END
						 )
			SET @Comment=(SELECT Description FROM ShipmentReport_2D_Report WHERE Code=@Kind)
			IF EXISTS(SELECT * FROM ShipmentReport_2D_Report WHERE Code=@Kind AND ISNULL(SendMail,0)=1)
				BEGIN
					EXECUTE ShipmentReport_sp_Send_Mail @Option,@Comment,@MenuID
				END
		END
	IF @Operation='Delete'
		BEGIN
			DELETE ShipmentReport_Baan_Handly_File WHERE AutoID=@AutoID
		END

END
GO
