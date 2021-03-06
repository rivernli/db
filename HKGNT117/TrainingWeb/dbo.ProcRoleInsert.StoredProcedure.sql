USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcRoleInsert]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 15:05
-- Description:	增加角色
-- =============================================
CREATE PROCEDURE [dbo].[ProcRoleInsert]
	@r_name nvarchar(50),
	@r_desc nvarchar(50)
AS
BEGIN
	   declare @r_bid int
	   set @r_bid=0
	   select @r_bid=max(r_bid) from Role
	   INSERT INTO Role
                      (r_name, r_bid, r_desc)
           VALUES     (@r_name,@r_bid,@r_desc)
       select @@rowcount
END

GO
