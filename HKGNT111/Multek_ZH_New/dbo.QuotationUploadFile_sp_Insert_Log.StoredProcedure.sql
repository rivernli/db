USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[QuotationUploadFile_sp_Insert_Log]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[QuotationUploadFile_sp_Insert_Log] 
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50),
	@Operation VARCHAR(50),
	@Remark	VARCHAR(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	--IF CHARINDEX(@UserID,'asia\mcnrivli;asia\hkgpetxu;asia\HKGJOCHE;asia\mcnwkuan')=0
	--	BEGIN
			INSERT INTO QuotationUploadFile_Log (UserID,Operation,Remark)
				VALUES(@UserID,@Operation,@Remark)
	--	END
END
GO
