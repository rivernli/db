USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_InsertUpdateDelete_Engineering_Evaluation_File]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_InsertUpdateDelete_Engineering_Evaluation_File]
	-- Add the parameters for the stored procedure here
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
    DECLARE @Comment VARCHAR(300),@Option VARCHAR(200),@MenuID VARCHAR(20),@Kind VARCHAR(2)
    SET @Option='Engineering Evaluation File'
    SET @MenuID='0000300007'
    SET @Kind='1'
	IF @Operation='Add'
		BEGIN
			INSERT INTO ShipmentReport_Engineering_Evaluation_File(PhysicalFileName,FileName,FileDescription,Uploader)
				VALUES (@PhysicalFileName,@FileName,@FileDescription,@Uploader)

			SET @Comment=(SELECT Description FROM ShipmentReport_2D_Report WHERE Code=@Kind)
			IF EXISTS(SELECT * FROM ShipmentReport_2D_Report WHERE Code=@Kind AND ISNULL(SendMail,0)=1)
				BEGIN
					EXECUTE ShipmentReport_sp_Send_Mail @Option,@Comment,@MenuID
				END
		END
	IF @Operation='Delete'
		BEGIN
			DELETE ShipmentReport_Engineering_Evaluation_File WHERE AutoID=@AutoID
		END

END
GO
