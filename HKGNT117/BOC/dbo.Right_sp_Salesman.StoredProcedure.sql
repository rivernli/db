USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Right_sp_Salesman]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<sun zhang>
-- Create date: <3/10/2011>
-- Description:	<salesman选项>
-- =============================================
CREATE PROCEDURE [dbo].[Right_sp_Salesman]
	
AS
BEGIN  

SELECT Cost_Users.UserID AS suid, Cost_Users.BDM AS salesman 
FROM Cost_Users 
WHERE Cost_Users.[UserID] not in ( SELECT RightUserTable.[suid] FROM RightUserTable )
ORDER BY UserID

END
GO
