USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HUBINV_UpdateUser]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_HUBINV_UpdateUser] 
	@uid nvarchar(50),
	@username nvarchar(50),
	@isActive bit,
	@isAdmin bit,
	@domain nvarchar(50),
	@emailAddress nvarchar(50),
	@department nvarchar(50),
	@jobTitle nvarchar(50),
	@fax nvarchar(50),
	@tel nvarchar(50),
	@sitesAccess nvarchar(250),
	@lastModifiedBy nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	update HUBINV_nUser
	set userName=@userName,
	isActive=@isActive,
	isAdmin=@isAdmin,
	domain=@domain,
	emailAddress=@emailAddress,
	department=@department,
	jobTitle=@jobTitle,
	fax=@fax,tel=@tel,
	sitesAccess=@sitesAccess,
	lastModifyDate=getdate(),
	lastModifiedBy = @lastModifiedBy
	where uid=@uid
END





GO
