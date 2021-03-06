USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_GAM_UserAdd]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_GAM_UserAdd] 
	@uid nvarchar(50),
	@domain varchar(15),
	@username nvarchar(50),
	@managerId int,
	@isReportViewer bit,
	@isSales bit,
	@isActive bit,
	@isAdmin bit,
@isPriceView bit=0,
	@emailAddress nvarchar(50),
	@department nvarchar(50),
	@jobTitle nvarchar(50),
	@fax nvarchar(50),
	@tel nvarchar(50),
@group nvarchar(50) = ''
	AS
BEGIN
	SET NOCOUNT ON;
	insert into gam_users
 (uid,userName,isActive,isAdmin,domain,managerId,isReportViewer,isSales,isPriceView,emailAddress,department,jobTitle,fax,tel,uGroup) 
values
 (@uid,@userName,@isActive,@isAdmin,@domain,@managerId,@isReportViewer,@isSales,@isPriceView,@emailAddress,@department,@jobTitle,@fax,@tel,@group) 
END









GO
