USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MCOS_addUser]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[sp_MCOS_addUser] 
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
	@createdBy nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	insert into MCOS_nUser
 (uid,userName,isActive,isAdmin,domain,emailAddress,department,jobTitle,fax,tel,sitesAccess,creationDate,createdBy) 
values
 (@uid,@userName,@isActive,@isAdmin,@domain,@emailAddress,@department,@jobTitle,@fax,@tel,@sitesAccess,getdate(),@createdBy) 
END

GO
