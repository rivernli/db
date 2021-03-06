USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[AD_UserCheck_users_sp_Query_userlist]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AD_UserCheck_users_sp_Query_userlist]
@Show_Type	NVARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Show_Type = ISNULL(@Show_Type,'')
	IF @Show_Type = ''
		SET @Show_Type = 'ALL'
    -- Insert statements for procedure here

	UPDATE Multek_ZH.dbo.AD_UserCheck_users SET WrokDay_ID = b.employeenumber,Windows_ID = B.sAMAccountName , CN_Name = B.FullName
	FROM Multek_ZH.dbo.AD_UserCheck_users AS A,Multek_ZH.dbo.ActiveDirectory_User AS B
	WHERE 'CHNMHR'+A.EmployeeID = B.EMPLOYEEID
	AND	  (A.Windows_ID IS NULL OR A.Windows_ID = '')

	UPDATE Multek_ZH.dbo.AD_UserCheck_users SET WrokDay_ID = b.employeenumber,Windows_ID = B.sAMAccountName , CN_Name = B.FullName
	FROM Multek_ZH.dbo.AD_UserCheck_users AS A,Multek_ZH.dbo.ActiveDirectory_User AS B
	WHERE 'Workday'+A.EmployeeID = B.EMPLOYEEID
	AND	  (A.Windows_ID IS NULL OR A.Windows_ID = '')

	UPDATE Multek_ZH.dbo.AD_UserCheck_users SET WrokDay_ID = b.employeenumber,Windows_ID = B.sAMAccountName , CN_Name = B.FullName
	FROM Multek_ZH.dbo.AD_UserCheck_users AS A,Multek_ZH.dbo.ActiveDirectory_User AS B
	WHERE 'CHNZHR'+A.EmployeeID = B.EMPLOYEEID
	AND	  (A.Windows_ID IS NULL OR A.Windows_ID = '')

	UPDATE Multek_ZH.dbo.AD_UserCheck_users SET WrokDay_ID = b.employeenumber,Windows_ID = B.sAMAccountName , CN_Name = B.FullName
	FROM Multek_ZH.dbo.AD_UserCheck_users AS A,Multek_ZH.dbo.ActiveDirectory_User AS B
	WHERE 'HKGMC'+A.EmployeeID = B.EMPLOYEEID
	AND	  (A.Windows_ID IS NULL OR A.Windows_ID = '')

	IF @Show_Type = 'ALL'
		BEGIN
			SELECT * from Multek_ZH.dbo.AD_UserCheck_users
		END
	IF @Show_Type = 'EXISTS'
		BEGIN
			SELECT * from Multek_ZH.dbo.AD_UserCheck_users WHERE (WrokDay_ID IS NOT NULL OR WrokDay_ID<> '')
		END
END






GO
