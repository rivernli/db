USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KPI_sp_Query_UserMenu_Authority]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE PROCEDURE [dbo].[KPI_sp_Query_UserMenu_Authority]
	@KPI_Id	 	VARCHAR(200)=NULL
AS
SET NOCOUNT ON

	BEGIN
		select a.UserID,a.BDM,b.CanUpload from KPI_Users a,KPI_Item_Authority b 
		WHERE a.UserID=b.UserID AND b.KPI_Id=@KPI_Id ORDER BY BDM ASC
	END

 
GO
