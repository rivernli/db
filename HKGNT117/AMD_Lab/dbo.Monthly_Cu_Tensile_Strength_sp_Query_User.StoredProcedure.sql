USE [AMD_Lab]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Query_User]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create PROCEDURE [dbo].[Monthly_Cu_Tensile_Strength_sp_Query_User]
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

SELECT *,BDM+' ('+Account+')' AS UserName 
FROM Monthly_Cu_Tensile_Strength_Users 
WHERE Region LIKE @Domain
	AND Account LIKE @Account
	AND BDM LIKE @BDMGAM
	AND Email LIKE @Email
ORDER BY BDM ASC 











GO
