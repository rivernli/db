USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[AccountProfile_sp_getUser]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AccountProfile_sp_getUser] 
	@uid nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	if(dbo.fx_trim(@uid)='')
		select *,(select BDM from AccountProfile_Users b where b.UserID=a.ManagerId) as Manager from AccountProfile_Users a order by BDM
	else
		select *,(select BDM from AccountProfile_Users b where b.UserID=a.ManagerId) as Manager from AccountProfile_Users a where Account=@uid
END



GO
