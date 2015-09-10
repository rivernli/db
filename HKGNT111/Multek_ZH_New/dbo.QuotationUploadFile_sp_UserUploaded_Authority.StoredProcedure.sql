USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[QuotationUploadFile_sp_UserUploaded_Authority]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[QuotationUploadFile_sp_UserUploaded_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@UserRight BIT
AS

SET NOCOUNT ON

UPDATE QuotationUploadFile_Authority SET User_Right=@UserRight WHERE UserID=@UserID AND MenuID=@MenuID
GO
