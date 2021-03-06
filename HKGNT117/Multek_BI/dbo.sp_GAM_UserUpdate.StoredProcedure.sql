USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_GAM_UserUpdate]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[sp_GAM_UserUpdate] 
	@uid nvarchar(50),
	@domain nvarchar(15),

	@username nvarchar(50),
	@isReportViewer bit,
	@isSales bit,
	@isActive bit,
	@isAdmin bit,
	@isPriceView bit=0,
	@group nvarchar(50) = ''
AS
BEGIN
	SET NOCOUNT ON;
/*
check if manager status change before update.
if changed from y to n.
	subordinate need to update manager id.
*/
	update gam_users
	set userName=@userName,
	isActive=@isActive,
	isAdmin=@isAdmin,
	isReportViewer=@isReportViewer,
	isSales=@isSales,
	isPriceView=@isPriceView,
	ugroup = @group
	where uid=@uid and domain=@domain
END








GO
