USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Judge_Order_Authority]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Judge_Order_Authority]
	-- Add the parameters for the stored procedure here
	@OrderNo VARCHAR(50)=NULL,
	@Operator VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   -- Insert statements for procedure here
	SELECT (
					CASE WHEN EXISTS(SELECT * FROM PT_Users WHERE UserID=@Operator AND Administrator=1 AND Enable=1) THEN 1
						 WHEN EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND TransferingSiteOwnerUserID=@Operator) THEN 1
						 WHEN EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND CreatedUserID=@Operator) THEN 1
						 WHEN EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND ClosedUserID=@Operator) THEN 1
						 WHEN EXISTS(SELECT * FROM PT_Users WHERE UserID=@Operator AND CHARINDEX(','+CONVERT(VARCHAR(10),DepartmentAutoID)+',',(SELECT TransferingInvolvedDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo))>0) THEN 1
						 WHEN EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND ReceivingSiteOwnerUserID=@Operator) THEN 1
						 WHEN EXISTS(SELECT * FROM PT_Order_CheckList a,PT_Department_CheckList b WHERE a.OrderNo=@OrderNo AND a.NotAvaliable=0 AND a.CheckListAutoID=b.CheckListAutoID AND b.DepartmentAutoID=(SELECT DepartmentAutoID FROM PT_uvw_User WHERE UserID=@Operator AND SiteName=(SELECT ReceivingSiteName FROM PT_uvw_Order WHERE OrderNo=@OrderNo))) THEN 1
					ELSE 0
					END
		 ) AS CanSee
END
GO
