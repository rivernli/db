USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_TOP_20_OEM_Yearly_Shipment_Trend]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_TOP_20_OEM_Yearly_Shipment_Trend] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Loc VARCHAR(3)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7)

	IF @Loc IS NULL
		BEGIN
			SELECT * 
			FROM dbo.ShipmentReport_Shipped_All_Fixed_Top_20_OEM
			WHERE Year=@Year
			ORDER BY Amount DESC
		END
	ELSE
		BEGIN
			SELECT * 
			FROM dbo.ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc
			WHERE Year=@Year
				AND Loc=@Loc
			ORDER BY Amount DESC
		END

END
GO
