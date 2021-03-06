USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Baan_Handly_File_Authority]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Baan_Handly_File_Authority]
	-- Add the parameters for the stored procedure here
	@Kind VARCHAR(50)=NULL,
	@UserID VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @CanOperate BIT
	/*
	IF EXISTS(SELECT * FROM  ShipmentReport_Users WHERE UserID=@UserID AND Administrator=1) OR @UserID='asia\MCN00236'
		BEGIN
			SET @CanOperate=1
		END 
	IF CHARINDEX(@Kind,'A,B,C,F,G')>0 AND CHARINDEX(@UserID,'asia\hkg10237,asia\hkg10052,asia\mcnandto')>0
		BEGIN
			SET @CanOperate=1
		END		
	IF CHARINDEX(@Kind,'D,E,H,I,J')>0 AND CHARINDEX(@UserID,'asia\mcn00637,asia\mcn00666')>0 
		BEGIN
			SET @CanOperate=1
		END
	IF CHARINDEX(@Kind,'E,F,H,I,J')>0 AND CHARINDEX(@UserID,'asia\mcnCZHEN,asia\mcn00666')>0
		BEGIN
			SET @CanOperate=1
		END
	IF CHARINDEX(@Kind,'D,E,H')>0 AND CHARINDEX(@UserID,'asia\mcn00741')>0
		BEGIN
			SET @CanOperate=1
		END
	IF CHARINDEX(@Kind,'D,I,J')>0 AND CHARINDEX(@UserID,'asia\mcn01377')>0
		BEGIN
			SET @CanOperate=1
		END

	IF CHARINDEX(@Kind,'B')>0 AND CHARINDEX(@UserID,'asia\hkg10237,asia\hkg10052')>0
		BEGIN
			SET @CanOperate=1
		END
	*/
	SET @CanOperate=ISNULL((SELECT CanUpload FROM ShipmentReport_2D_Report_Upload_Authority WHERE ReportCode=@Kind AND UserID=@UserID),0)
	SELECT @CanOperate AS CanOperate
END
GO
