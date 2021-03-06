USE [Multek_SZ_New]
GO
/****** Object:  View [dbo].[PT_uvw_Order_test]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PT_uvw_Order_test]
AS
SELECT     dbo.PT_Order.OrderNo, dbo.PT_Order.TransferingDepartmentAutoID, dbo.PT_Order.TransferingSiteOwnerUserID, dbo.PT_Order.ReceivingDepartmentAutoID, 
                      dbo.PT_Order.ReceivingSiteOwnerUserID, dbo.PT_Order.PartNumber, dbo.PT_Order.RevisionNumber, dbo.PT_Order.ToolNumber, dbo.PT_Order.CustomerCEM, 
                      dbo.PT_Order.CustomerOEM, dbo.PT_Order.DeliveryDate, dbo.PT_Order.CustomerApprove, dbo.PT_Order.SalesOrderOption, dbo.PT_Order.SalesOrderAttachment, 
                      dbo.PT_Order.SalesOrderPhysicalAttachment, dbo.PT_Order.SalesOrderComment, dbo.PT_Order.PurchaseOrderOption, dbo.PT_Order.PurchaseOrderAttachment, 
                      dbo.PT_Order.PurchaseOrderPhysicalAttachment, dbo.PT_Order.PurchaseOrderComment, dbo.PT_Order.TransferingInvolvedDepartmentAutoID, 
                      dbo.PT_Order.GoldenBoardShipment, dbo.PT_Order.GoldenBoardQuantity, dbo.PT_Order.GoldenBoardWhen, dbo.PT_Order.GoldenBoardAWB, 
                      dbo.PT_Order.GoldenBoardByWhom, dbo.PT_Order.GoldenBoardComment, dbo.PT_Order.RejectedBoardShipment, dbo.PT_Order.RejectedBoardQuantity, 
                      dbo.PT_Order.RejectedBoardWhen, dbo.PT_Order.RejectedBoardAWB, dbo.PT_Order.RejectedBoardByWhom, dbo.PT_Order.RejectedBoardComment, 
                      dbo.PT_Order.Closed, dbo.PT_Order.ClosedUserID, dbo.PT_Order.ClosedDate, dbo.PT_Order.CreatedUserID, dbo.PT_Order.CreatedDate, dbo.PT_Order.Deleted, 
                      dbo.PT_Order.DeletedUserID, dbo.PT_Order.DeletedDate, dbo.PT_Order.LastUpdatedUserID, dbo.PT_Order.LastUpdatedDate, 
                      dbo.PT_Users.BDM + '(' + dbo.PT_Users.Region + '\' + dbo.PT_Users.Account + ')' AS OwnerName, dbo.PT_Location.Name AS TransferringSiteName, 
                      PT_Location_1.Name AS ReceivingSiteName, PT_Users_1.BDM + '(' + PT_Users_1.Region + '\' + PT_Users_1.Account + ')' AS TransferringSiteOwnerName, 
                      PT_Users_2.BDM + '(' + PT_Users_2.Region + '\' + PT_Users_2.Account + ')' AS ReceivingSiteOwnerName, dbo.PT_Order.ReceivingSiteOwnerApprove, 
                      dbo.PT_Order.ReceivingSiteOwnerApproveDate, dbo.PT_Order.TransferringSiteOwnerApprove, dbo.PT_Order.TransferringSiteOwnerApproveDate, 
                      PT_Users_3.BDM + '(' + PT_Users_3.Region + '\' + PT_Users_3.Account + ')' AS ClosedName
FROM         dbo.PT_Order INNER JOIN
                      dbo.PT_Users ON dbo.PT_Order.CreatedUserID = dbo.PT_Users.UserID INNER JOIN
                      dbo.PT_Location ON dbo.PT_Order.TransferingDepartmentAutoID = dbo.PT_Location.AutoID INNER JOIN
                      dbo.PT_Location AS PT_Location_1 ON dbo.PT_Order.ReceivingDepartmentAutoID = PT_Location_1.AutoID INNER JOIN
                      dbo.PT_Users AS PT_Users_1 ON dbo.PT_Order.TransferingSiteOwnerUserID = PT_Users_1.UserID INNER JOIN
                      dbo.PT_Users AS PT_Users_2 ON dbo.PT_Order.ReceivingSiteOwnerUserID = PT_Users_2.UserID LEFT OUTER JOIN
                      dbo.PT_Users AS PT_Users_3 ON dbo.PT_Order.ClosedUserID COLLATE Chinese_PRC_CI_AS = PT_Users_3.UserID
GO
