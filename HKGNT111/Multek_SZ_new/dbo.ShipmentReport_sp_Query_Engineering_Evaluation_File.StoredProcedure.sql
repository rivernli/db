USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Engineering_Evaluation_File]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Engineering_Evaluation_File]
	-- Add the parameters for the stored procedure here
	@FileName VARCHAR(255),
	@FileDescription VARCHAR(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @FileName='%'+RTRIM(LTRIM(@FileName))+'%'
	SET @FileDescription='%'+RTRIM(LTRIM(@FileDescription))+'%'

	SELECT a.* ,b.BDM AS UserName,b.BDM +' '+CONVERT(VARCHAR(20),UploadedTime,120) AS Uploaded ,dbo.ShipmentReport_fun_GetDownLoad_History_Engineering_Evaluation_File(a.AutoID) AS Downloaded
	FROM ShipmentReport_Engineering_Evaluation_File a,ShipmentReport_Users b
	WHERE a.FileName LIKE @FileName
		AND a.FileDescription LIKE @FileDescription
		AND a.Uploader=b.UserID
	ORDER BY a.AutoID DESC
END
GO
