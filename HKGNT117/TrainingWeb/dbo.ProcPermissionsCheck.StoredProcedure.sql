USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPermissionsCheck]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 21:40
-- Description:	判断权限
-- =============================================
CREATE PROCEDURE [dbo].[ProcPermissionsCheck]
@aid int,
@oid int,
@Value varchar(255)
AS
BEGIN
    declare @SQLString nvarchar(200)
    declare @returnText nvarchar(255)
    declare @r_id int
    
    select @r_id=r_id  from  admin  where id=@aid  
    
	set @SQLString = N'Select  '+ @Value + N' from PermissionsTable where  (r_id=@r_id) and (oid=@oid)'
	
	EXECUTE  sp_executesql @SQLString,N'@oid int,@r_id int',@oid,@r_id
END

GO
