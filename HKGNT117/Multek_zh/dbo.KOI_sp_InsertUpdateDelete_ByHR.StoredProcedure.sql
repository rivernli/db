USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_InsertUpdateDelete_ByHR]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KOI_sp_InsertUpdateDelete_ByHR]
	@ID INT=NULL,
	@Plant VARCHAR(2)=NULL,
	@Period VARCHAR(20)=NULL,
	@Financey VARCHAR(20)=NULL,
	@WorkingHours float=NULL,
	@Headcount float=NULL,
	@Operation VARCHAR(10)
AS

SET NOCOUNT ON

IF @Operation='Insert' 
	BEGIN
		INSERT INTO KOI_InputByHR (Plant,Period,Financey,WorkingHours,Headcount)
			VALUES(@Plant,@Period,@Financey,@WorkingHours,@Headcount)
	END
IF @Operation='Update' 
	BEGIN
		UPDATE KOI_InputByHR
		SET Plant=@Plant,Period=@Period,Financey=@Financey,WorkingHours=@WorkingHours,Headcount=@Headcount 
		WHERE ID=@ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE KOI_InputByHR
		WHERE ID=@ID 
	END









GO
