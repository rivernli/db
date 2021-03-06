USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[boc_sp_Query_UserList]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[boc_sp_Query_UserList]
	@Domain VARCHAR(50)=NULL,
	@Account VARCHAR(50)=NULL,
	@BDMGAM	VARCHAR(50)=NULL,
	@Email	VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
		SET NOCOUNT ON

		SET @Domain=ISNULL(@Domain,'')
		SET @Domain='%'+RTRIM(LTRIM(@Domain))+'%'
		SET @Account=ISNULL(@Account,'')
		SET @Account='%'+RTRIM(LTRIM(@Account))+'%'
		SET @BDMGAM=ISNULL(@BDMGAM,'')
		SET @BDMGAM='%'+RTRIM(LTRIM(@BDMGAM))+'%'
		SET @Email=ISNULL(@Email,'')
		SET @Email='%'+RTRIM(LTRIM(@Email))+'%'

    -- Insert statements for procedure here
		SELECT A.autoid,Region as Domain,userid as Account,username as Name,Email,B.Browse_Authority as Authority,C.Price_authority as Price_Authority,
			(SELECT TOP 1 CASE AUTHORITY WHEN 'B1' THEN 1 ELSE 0 END FROM Authority_Trend_Key_Plant WHERE USERID = A.USERID AND AUTHORITY = 'B1') AS B1,
			(SELECT TOP 1 CASE AUTHORITY WHEN 'B3' THEN 1 ELSE 0 END FROM Authority_Trend_Key_Plant WHERE USERID = A.USERID AND AUTHORITY = 'B3') AS B3,
			(SELECT TOP 1 CASE AUTHORITY WHEN 'B4' THEN 1 ELSE 0 END  FROM Authority_Trend_Key_Plant WHERE USERID = A.USERID AND AUTHORITY = 'B4') AS B4,
			(SELECT TOP 1 CASE AUTHORITY WHEN 'B5' THEN 1 ELSE 0 END  FROM Authority_Trend_Key_Plant WHERE USERID = A.USERID AND AUTHORITY = 'B5') AS B5,
			Enable
		FROM Authority_User AS A 
			LEFT JOIN	dbo.Authority_Role  AS B ON B.ID = A.ROLE
			LEFT JOIN	dbo.Authority_Price AS C ON C.ID = A.PRICE
		WHERE	A.REGION LIKE @Domain
			AND A.USERID LIKE @Account
			AND A.USERNAME LIKE @BDMGAM
			AND A.Email LIKE @Email
		ORDER BY A.UserID ASC
END


GO
