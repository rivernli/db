USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUpdateDelete_GPA]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_InsertUpdateDelete_GPA]
	@GPANo VARCHAR(10)=NULL OUTPUT,
	@OwnerID VARCHAR(50),
	@LegalID INT=NULL,
	@SiteID INT=NULL,
	@CustomerName VARCHAR(1000)=NULL,
	@Products VARCHAR(1000)=NULL,
	@KeyProductLine INT=NULL,
	@AgreementID INT=NULL,
	@ContractInDate VARCHAR(50)=NULL,
	@ExpectedClosingDate VARCHAR(50)=NULL,
	@ActualClosingDate VARCHAR(50)=NULL,
	@StatusID INT=NULL,
	@Closed BIT=NULL,
	@Attachment VARCHAR(50)=NULL,
	@PhysicalAttachment VARCHAR(50)=NULL,
	@Operator VARCHAR(50)=NULL,
	@Remark VARCHAR(8000)=NULL,
	@Operation VARCHAR(10)
AS

SET NOCOUNT ON

DECLARE @MaxGPANo INT

IF (@Operation='Insert' OR @Operation='Update')
	BEGIN
		IF @LegalID IS NULL
			BEGIN
				RAISERROR('Sorry, [legal rep.] can not be empty!',16,1)
				RETURN
			END
		IF @SiteID IS NULL
			BEGIN
				RAISERROR('Sorry,[site] can not be empty!',16,1)
				RETURN
			END
		IF @Products IS NULL
			BEGIN
				RAISERROR('Sorry,[products] can not be empty!',16,1)
				RETURN
			END
		IF @KeyProductLine IS NULL
			BEGIN
				RAISERROR('Sorry, [key product line] can not be empty!',16,1)
				RETURN
			END
		IF @AgreementID IS NULL
			BEGIN
				RAISERROR('Sorry, [agreement] can not be empty!',16,1)
				RETURN
			END
		IF @ContractInDate IS NULL OR @ContractInDate=''
			BEGIN
				RAISERROR('Sorry,[contract in date] can not be empty!',16,1)
				RETURN
			END
		IF @ExpectedClosingDate IS NULL
			BEGIN
				RAISERROR('Sorry, [expected closed date] can  not be empty!',16,1)
				RETURN
			END
		IF @ActualClosingDate IS NULL
			BEGIN
				RAISERROR('Sorry,[actual closed date] can not be empty!',16,1)
				RETURN
			END
		IF @StatusID IS NULL
			BEGIN
				RAISERROR('Sorry, [status] can not be empty!',16,1)
				RETURN
			END
		IF ISNULL(@Products,'')=''
			BEGIN
				RAISERROR('Sorry, [products] can not be empty!',16,1)
				RETURN
			END
		IF @CustomerName='' OR @CustomerName IS NULL
			BEGIN
				RAISERROR('Sorry, [customer] can not be empty!',16,1)
				RETURN
			END
		/* Remove 2010-01-07 by peter's request
		ELSE
			BEGIN
				IF NOT EXISTS(SELECT * FROM vpt_multek_customer WHERE [Billing Cust Name]=@CustomerName)
					BEGIN
						RAISERROR('Sorry, [customer] is invalid !',16,1)
						RETURN
					END
			END
		*/
	END
IF (@Operation='Insert' OR @Operation='Update') AND @Closed=1 
	BEGIN
		IF @ContractInDate=''
			BEGIN
				RAISERROR('Sorry, please input [contract in date] before you close it!',16,1)
				RETURN
			END
		IF @ExpectedClosingDate=''
			BEGIN
				RAISERROR('Sorry,please input [expected closed date] before you close it!',16,1)
				RETURN
			END
		IF @ActualClosingDate=''
			BEGIN
				RAISERROR('Sorry,please input [actual closed date] before you close it !',16,1)
				RETURN
			END
		IF @ExpectedClosingDate<>''
			BEGIN
				IF CONVERT(DATETIME,@ContractInDate)>CONVERT(DATETIME,@ExpectedClosingDate)
					BEGIN
						RAISERROR('Sorry,[expected closed date] should always exceed [contract in date]!',16,1)
						RETURN
					END
			END
		IF @ActualClosingDate<>''
			BEGIN
				IF CONVERT(DATETIME,@ContractInDate)>CONVERT(DATETIME,@ActualClosingDate) 
					BEGIN
						RAISERROR('Sorry, [actual closed date] should always exceed [contract in date]!',16,1)
						RETURN
					END
			END

		IF @Attachment ='' AND NOT EXISTS(SELECT * FROM Users WHERE UserID=@Operator AND Administrator=1)
			BEGIN
				RAISERROR('Sorry, if you close it, please upload the attachment!',16,1)
				RETURN
			END
	END

/*Add new GPA*/
IF @Operation='Insert'
	BEGIN
		SET @MaxGPANo=ISNULL(CONVERT(INT,RIGHT((SELECT MAX(GPANo) FROM GPA),7)),0)+1
		SET @GPANo='GPA'+REPLICATE('0',(
							CASE WHEN @MaxGPANo BETWEEN 1 AND 9 THEN 6  
							           WHEN @MaxGPANo BETWEEN 10 AND 99 THEN 5
							           WHEN @MaxGPANo BETWEEN 100 AND 999 THEN 4  
							           WHEN @MaxGPANo BETWEEN 1000 AND 9999 THEN 3  
							           WHEN @MaxGPANo BETWEEN 10000 AND 99999 THEN 2  
							           WHEN @MaxGPANo BETWEEN 100000 AND 999999 THEN 1
							           ELSE 0 END
						         ))+CONVERT(VARCHAR(7),@MaxGPANo)
		INSERT INTO GPA (GPANo,OwnerID,LegalID,SiteID,CustomerName,Products,KeyProductLine,AgreementID,ContractInDate,ExpectedClosingDate,ActualClosingDate,StatusID,Closed,Remark)
			VALUES (@GPANo,@OwnerID,@LegalID,@SiteID,@CustomerName,@Products,@KeyProductLine,@AgreementID,@ContractInDate,@ExpectedClosingDate,@ActualClosingDate,@StatusID,@Closed,@Remark)

		INSERT INTO GPAHistory(GPANo,Operator,OperationType)
				VALUES(@GPANo,@Operator,'Add New')
	END
/*Update GPA*/
IF @Operation='Update'
	BEGIN
		IF @Operator<>(SELECT OwnerID FROM GPA WHERE GPANo=@GPANo) 
			BEGIN
				IF NOT EXISTS(SELECT * FROM Users WHERE UserID=@Operator AND Administrator=1)
					BEGIN
						RAISERROR('Sorry, you have not authority to update the case!',16,1)
						RETURN
					END
			END

		UPDATE GPA
		SET OwnerID=@OwnerID,
			LegalID=@LegalID,
			SiteID=@SiteID,
			CustomerName=@CustomerName,
			Products=@Products,
			KeyProductLine=@KeyProductLine,
			AgreementID=@AgreementID,
			ContractInDate=@ContractInDate,
			ExpectedClosingDate=@ExpectedClosingDate,
			ActualClosingDate=@ActualClosingDate,
			StatusID=@StatusID,
			Closed=@Closed,
			Remark=@Remark
		WHERE GPANo=@GPANo
	END
/*After user close GPA, system must update closeddate and attachment*/
IF (@Operation='Insert' OR @Operation='Update') 
	BEGIN
		UPDATE GPA
		SET Attachment=@Attachment,PhysicalAttachment=@PhysicalAttachment
		WHERE GPANo=@GPANo
	END
IF (@Operation='Insert' OR @Operation='Update') AND @Closed=1
	BEGIN
		UPDATE GPA
		SET ClosedDate=GETDATE(),Attachment=@Attachment,PhysicalAttachment=@PhysicalAttachment,ClosedOperator=@Operator
		WHERE GPANo=@GPANo

		INSERT INTO GPAHistory(GPANo,Operator,OperationType)
						VALUES(@GPANo,@Operator,'Close')
	END
/*Delete GPA*/
IF @Operation='Delete'
	BEGIN
		--DELETE GPA WHERE GPANo=@GPANo
		IF @Operator<>(SELECT OwnerID FROM GPA WHERE GPANo=@GPANo) 
			BEGIN
				IF NOT EXISTS(SELECT * FROM Users WHERE UserID=@Operator AND Administrator=1)
					BEGIN
						RAISERROR('Sorry, you have not authority to delete the case!',16,1)
						RETURN
					END
			END

		UPDATE GPA SET Deleted=1 ,Deleter=@Operator,DeletedDate=GETDATE() WHERE GPANo=@GPANo
		INSERT INTO GPAHistory(GPANo,Operator,OperationType)
						VALUES(@GPANo,@Operator,'Delete')
	END
/*ReOpen GPA */
IF @Operation='ReOpen'
	BEGIN
		IF @Operator<>(SELECT OwnerID FROM GPA WHERE GPANo=@GPANo) 
			BEGIN
				IF NOT EXISTS(SELECT * FROM Users WHERE UserID=@Operator AND Administrator=1)
					BEGIN
						RAISERROR('Sorry, you have not authority to reopen the case!',16,1)
						RETURN
					END
			END

		IF NOT EXISTS(SELECT * FROM GPA WHERE GPANo=@GPANo AND Closed=1)
			BEGIN
				RAISERROR('Sorry, the GPA is not closed, you need not reopen it!',16,1)
				RETURN
			END

		UPDATE GPA
		SET Closed=0
		WHERE GPANo=@GPANo

		INSERT INTO GPAHistory(GPANo,Operator,OperationType)
						VALUES(@GPANo,@Operator,'ReOpen')
	END
/*Undelete GPA */
IF @Operation='UnDelete'
	BEGIN
		IF @Operator<>(SELECT OwnerID FROM GPA WHERE GPANo=@GPANo) 
			BEGIN
				IF NOT EXISTS(SELECT * FROM Users WHERE UserID=@Operator AND Administrator=1)
					BEGIN
						RAISERROR('Sorry, you have not authority to undelete the case!',16,1)
						RETURN
					END
			END

		IF NOT EXISTS(SELECT * FROM GPA WHERE GPANo=@GPANo AND Deleted=1)
			BEGIN
				RAISERROR('Sorry, the GPA is not deleted, you need not undelete it!',16,1)
				RETURN
			END

		UPDATE GPA
		SET Deleted=0
		WHERE GPANo=@GPANo

		INSERT INTO GPAHistory(GPANo,Operator,OperationType)
						VALUES(@GPANo,@Operator,'UnDelete')
	END
GO
