USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Update_Standard_OEM_Customer]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Update_Standard_OEM_Customer]
	-- Add the parameters for the stored procedure here
	@AutoID BIGINT=NULL,
	@Baan_OEM VARCHAR(500),
	@Baan_Customer VARCHAR(500),
	@Baan_Loc VARCHAR(3),
	@Standard_OEM VARCHAR(MAX),
	@Standard_Customer VARCHAR(MAX),
	@Operator VARCHAR(50),
	@Remark VARCHAR(MAX)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @Standard_OEM=RTRIM(LTRIM(ISNULL(@Standard_OEM,'')))
	SET @Standard_Customer=RTRIM(LTRIM(ISNULL(@Standard_Customer,'')))
	SET @Remark=RTRIM(LTRIM(ISNULL(@Remark,'')))
	IF @AutoID IS NULL
		BEGIN
			UPDATE ShipmentReport_OEM_Customer
			SET Std_OEM=@Standard_OEM,Std_Customer=@Standard_Customer,Updater=@Operator,Updated_Time=GETDATE(),Remark=@Remark
			WHERE Baan_OEM=@Baan_OEM
				AND Baan_Customer=@Baan_Customer
				AND (Std_OEM<>@Standard_OEM
						OR Std_Customer<>@Standard_Customer
					)
		END
	ELSE
		BEGIN
			UPDATE ShipmentReport_OEM_Customer
			SET Std_OEM=@Standard_OEM,Std_Customer=@Standard_Customer,Updater=@Operator,Updated_Time=GETDATE(),Remark=@Remark
			WHERE AutoID=@AutoID
				AND (Std_OEM<>@Standard_OEM
						OR Std_Customer<>@Standard_Customer
					)
		END

END
GO
