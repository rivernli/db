USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[RightUserTable_sp_InsertDeleteBind]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<sun zhang>
-- Create date: <3/10/2011>
-- Description:	<RightUserTable的增删和查操作>
-- =============================================
CREATE PROCEDURE [dbo].[RightUserTable_sp_InsertDeleteBind]
	@ID INT=null,
	@manager  nvarchar(50)=null,
	@muid  nvarchar(50)=null,
	@salesman  nvarchar(50)=null,
	@suid  nvarchar(50)=null,
	
	@Operatation nvarchar(10)
AS
BEGIN


    -- Insert 
	IF @Operatation = 'Insert'
		BEGIN
            INSERT INTO RightUserTable( manager, muid, salesman, suid)
            VALUES     (@manager,@muid,@salesman,@suid)
		END
	-- Update
--	IF @Operatation = 'Update'
--		BEGIN
--			
--		END		
	-- Delete
	IF @Operatation = 'Delete'
		BEGIN
            SELECT  @suid=suid   FROM  RightUserTable  WHERE     (id = @ID)
			DELETE FROM RightUserTable WHERE     (id = @ID)
			DELETE FROM RightOEMTable  WHERE     (suid = @suid)
		END	
	-- Bind		
	IF @Operatation = 'Bind'
		BEGIN
			SELECT     id, manager, muid, salesman, suid FROM  RightUserTable
		END	
END



GO
