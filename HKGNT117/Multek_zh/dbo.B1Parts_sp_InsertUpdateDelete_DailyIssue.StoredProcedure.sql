USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_DailyIssue]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_DailyIssue] 	
		@ID INT=NULL,
		@Date DATETIME=NULL,
		@PartNO NVARCHAR(50),
		@WorkCenter NVARCHAR(50),
		@SerialNo NVARCHAR(50),
		@Item INT=NULL,
		@IssuedQty float, 
		@ScarpQty float,
		@PDSigned bit,
		@UserNo NVARCHAR(50),
		@MaintainCausation NVARCHAR(50),
		@MaintainNo NVARCHAR(50),
		@OldPartsRecyclingDate DATETIME=NULL,
		@Remark ntext,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_Daily_Issue_List (Date, PartNO, WorkCenter, SerialNo, Item, IssuedQty, ScarpQty, PDSigned, UserNo, MaintainCausation, MaintainNo, OldPartsRecyclingDate, Remark)
					VALUES(@Date, @PartNO, @WorkCenter, @SerialNo, @Item, @IssuedQty, @ScarpQty, @PDSigned, @UserNo, @MaintainCausation, @MaintainNo, @OldPartsRecyclingDate, @Remark) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_Daily_Issue_List
		SET Date=@Date, PartNO=@PartNO, WorkCenter=@WorkCenter, SerialNo=@SerialNo, Item=@Item, IssuedQty=@IssuedQty, ScarpQty=@ScarpQty, 
			PDSigned=@PDSigned, UserNo=@UserNo, MaintainCausation=@MaintainCausation, MaintainNo=@MaintainNo, OldPartsRecyclingDate=@OldPartsRecyclingDate, Remark=@Remark 
		WHERE ID=@ID 	
	return @ID 
	END











GO
