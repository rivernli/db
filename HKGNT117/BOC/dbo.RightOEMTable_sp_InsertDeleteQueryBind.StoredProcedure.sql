USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[RightOEMTable_sp_InsertDeleteQueryBind]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<sun zhang>
-- Create date: <3/10/2011>
-- Description:	<RightOEMTable的增删和查操作>
-- =============================================
CREATE PROCEDURE [dbo].[RightOEMTable_sp_InsertDeleteQueryBind]
	@ID INT=null,
	@suid  nvarchar(50)=null,
	@oem  nvarchar(200)=null,
	
	@Operatation nvarchar(10)
AS
BEGIN


    -- Insert 
	IF @Operatation = 'Insert'
		BEGIN
            INSERT INTO RightOEMTable (suid, oem)
            VALUES     (@suid,@oem )
		END
	-- Update
--	IF @Operatation = 'Update'
--		BEGIN
--			
--		END		
	-- Delete
	IF @Operatation = 'Delete'
		BEGIN
			DELETE FROM RightOEMTable WHERE    (id = @ID)
		END	
    -- QueryOEM
	IF @Operatation = 'QueryOEM'
		BEGIN
			SELECT   RightUserTable.manager, dbo.RightUserTable.muid, RightUserTable.salesman, 
                     RightUserTable.suid, RightOEMTable.id, RightOEMTable.oem
            FROM RightOEMTable INNER JOIN RightUserTable ON RightOEMTable.suid = RightUserTable.suid
			WHERE RightOEMTable.oem=@oem
            ORDER BY RightUserTable.id DESC
		END	
    -- QueryOEM
	IF @Operatation = 'QuerySUID'
		BEGIN
			SELECT   RightUserTable.manager, dbo.RightUserTable.muid, RightUserTable.salesman, 
                     RightUserTable.suid, RightOEMTable.id, RightOEMTable.oem
            FROM RightOEMTable INNER JOIN RightUserTable ON RightOEMTable.suid = RightUserTable.suid
			WHERE RightUserTable.suid=@suid
		END	
	-- Bind		
	IF @Operatation = 'Bind'
		BEGIN
			SELECT   RightUserTable.manager, dbo.RightUserTable.muid, RightUserTable.salesman, 
                     RightUserTable.suid, RightOEMTable.id, RightOEMTable.oem
            FROM RightOEMTable INNER JOIN RightUserTable ON RightOEMTable.suid = RightUserTable.suid
            ORDER BY RightUserTable.id DESC
		END	
END


GO
