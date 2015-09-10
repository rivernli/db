USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KPI_sp_UserUploaded_Authority]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[KPI_sp_UserUploaded_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@UserRight BIT
AS

SET NOCOUNT ON

UPDATE KPI_Item_Authority SET CanUpload=@UserRight WHERE UserID=@UserID AND KPI_Id=@MenuID  
GO
