USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Query_User]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Query_User]
	@Domain VARCHAR(50)=NULL,
	@Account VARCHAR(50)=NULL,
	@BDMGAM	VARCHAR(50)=NULL,
	@Email	VARCHAR(50)=NULL
AS

SET NOCOUNT ON

SET @Domain=ISNULL(@Domain,'')
SET @Domain='%'+RTRIM(LTRIM(@Domain))+'%'
SET @Account=ISNULL(@Account,'')
SET @Account='%'+RTRIM(LTRIM(@Account))+'%'
SET @BDMGAM=ISNULL(@BDMGAM,'')
SET @BDMGAM='%'+RTRIM(LTRIM(@BDMGAM))+'%'
SET @Email=ISNULL(@Email,'')
SET @Email='%'+RTRIM(LTRIM(@Email))+'%'

SELECT *,BDM+' ('+UserID+')' AS UserName 
FROM SalesAnalysis_Users 
WHERE Region LIKE @Domain
	AND Account LIKE @Account
	AND BDM LIKE @BDMGAM
	AND Email LIKE @Email
--ORDER BY UserID ,BDM
ORDER BY BDM,Region,Account
GO
