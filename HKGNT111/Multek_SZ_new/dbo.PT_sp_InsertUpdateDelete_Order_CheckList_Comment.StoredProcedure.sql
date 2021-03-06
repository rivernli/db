USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_InsertUpdateDelete_Order_CheckList_Comment]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_InsertUpdateDelete_Order_CheckList_Comment]
	-- Add the parameters for the stored procedure here
		-- Add the parameters for the stored procedure here
	@AutoID INT=NULL,
	@OrderNo VARCHAR(50)=NULL,
	@CheckListAutoID INT=NULL,
	@OrderCheckListAutoID INT=NULL,
	@Comment NVARCHAR(MAX)=NULL,
	@OperatorUserID	VARCHAR(50)=NULL,
	@OperationType VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @OperationType='Insert'
		BEGIN
			SET @OrderCheckListAutoID=(SELECT AutoID FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=@CheckListAutoID)
			INSERT INTO PT_Order_CheckList_Comment (OrderCheckListAutoID,Comment,UserID)	
				VALUES(@OrderCheckListAutoID ,@Comment,@OperatorUserID)
		END
END
GO
