USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Attachment_sp_UserUploaded_Authority]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Attachment_sp_UserUploaded_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@UserRight BIT
AS

SET NOCOUNT ON

UPDATE Attachment_Authority SET User_Right=@UserRight WHERE UserID=@UserID AND MenuID=@MenuID







GO
