USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_getUser]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[EHS_sp_getUser] 
	@uid nvarchar(50)=NULL,
	@Plant nvarchar(25)=NULL 
AS
BEGIN
	SET NOCOUNT ON;
	--if(dbo.fx_trim(@uid)='')
	--	select * from EHS_users order by BDM
	--else
	--	select * from EHS_users where Account=@uid


	SET @uid='%'+LTRIM(RTRIM(ISNULL(@uid,'')))+'%'
	SET @Plant='%'+LTRIM(RTRIM(ISNULL(@Plant,'')))+'%'

	select * from EHS_users where Account LIKE @uid AND Plant LIKE @Plant ORDER BY Plant ASC

END






GO
