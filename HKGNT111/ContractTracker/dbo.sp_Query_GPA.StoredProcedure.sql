USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_GPA]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Query_GPA]
	@GPANo VARCHAR(20)=NULL ,
	@OwnerID VARCHAR(50)=NULL,
	@LegalName VARCHAR(200)=NULL,
	@SiteName VARCHAR(200)=NULL,
	@CustomerName VARCHAR(1000)=NULL,
	@KeyProductLineName VARCHAR(200)=NULL,
	@ProductName VARCHAR(200)=NULL,
	@AgreementName VARCHAR(200)=NULL,
	@ContractInDateFrom DATETIME=NULL,
	@ContractInDateTo DATETIME=NULL,
	@ExpectedClosingDateFrom DATETIME=NULL,
	@ExpectedClosingDateTo DATETIME=NULL,
	@ActualClosingDateFrom DATETIME=NULL,
	@ActualClosingDateTo DATETIME=NULL,
	@StatusName VARCHAR(200)=NULL,
	@Closed INT,
	@Attachment VARCHAR(50)=NULL
AS

SET NOCOUNT ON

SET @GPANo='%'+(CASE WHEN @GPANo='------ALL------'  THEN '' ELSE RTRIM(LTRIM(ISNULL(@GPANo,''))) END)+'%'
SET @OwnerID='%'+(CASE WHEN @OwnerID='------ALL------'  THEN '' ELSE RTRIM(LTRIM(ISNULL(@OwnerID,''))) END)+'%'
SET @LegalName='%'+(CASE WHEN @LegalName='------ALL------'  THEN '' ELSE RTRIM(LTRIM(ISNULL(@LegalName,''))) END)+'%'
SET @SiteName='%'+(CASE WHEN @SiteName='------ALL------'  THEN '' ELSE RTRIM(LTRIM(ISNULL(@SiteName,''))) END)+'%'
SET @CustomerName='%'+(CASE WHEN @CustomerName='------ALL------'  THEN '' ELSE RTRIM(LTRIM(ISNULL(@CustomerName,''))) END)+'%'
SET @KeyProductLineName='%'+(CASE WHEN @KeyProductLineName='------ALL------'  THEN '' ELSE RTRIM(LTRIM(ISNULL(@KeyProductLineName,''))) END)+'%'
SET @AgreementName='%'+(CASE WHEN @AgreementName='------ALL------'  THEN '' ELSE RTRIM(LTRIM(ISNULL(@AgreementName,''))) END)+'%'
SET @StatusName='%'+(CASE WHEN @StatusName='------ALL------'  THEN '' ELSE RTRIM(LTRIM(ISNULL(@StatusName,''))) END)+'%'
SET @Attachment='%'+(CASE WHEN @Attachment='------ALL------'  THEN '' ELSE RTRIM(LTRIM(ISNULL(@Attachment,''))) END)+'%'
SET @ContractInDateFrom=ISNULL(@ContractInDateFrom,'1900-01-01')
SET @ContractInDateTo=ISNULL(@ContractInDateTo,'9999-01-01')
SET @ExpectedClosingDateFrom=ISNULL(@ExpectedClosingDateFrom,'1900-01-01')
SET @ExpectedClosingDateTo=ISNULL(@ExpectedClosingDateTo,'9999-01-01')
SET @ActualClosingDateFrom=ISNULL(@ActualClosingDateFrom,'1900-01-01')
SET @ActualClosingDateTo=ISNULL(@ActualClosingDateTo,'9999-01-01')
SET @ProductName='%'+(CASE WHEN @ProductName='------ALL------'  THEN '' ELSE RTRIM(LTRIM(ISNULL(@ProductName,''))) END)+'%'

IF @GPANO<>'%Undelete%'
	BEGIN
		IF EXISTS(SELECT * FROM Users WHERE UserID LIKE @OwnerID AND Administrator=1) OR EXISTS(SELECT * FROM Users WHERE UserID LIKE @OwnerID AND ViewAll=1)
			BEGIN
				SELECT * 
				FROM uvwGPA
				WHERE GPANo LIKE @GPANo
					--AND OwnerID LIKE @OwnerID
					AND LegalName LIKE @LegalName
					AND SiteName LIKE @SiteName
					AND CustomerName LIKE @CustomerName
					AND KeyProductLineName LIKE @KeyProductLineName
					AND ProductName LIKE @ProductName
					AND AgreementName LIKE @AgreementName
					AND StatusName LIKE @StatusName
					AND ContractInDate Between @ContractInDateFrom AND @ContractInDateTo
					AND ExpectedClosingDate Between @ExpectedClosingDateFrom AND @ExpectedClosingDateTo
					AND ActualClosingDate Between @ActualClosingDateFrom AND @ActualClosingDateTo
					AND StatusName LIKE @StatusName
					AND ISNULL(Attachment,'') LIKE @Attachment
					AND Closed=@Closed
					AND ISNULL(Deleted,0)=0
				ORDER BY GPANo
			END
		ELSE
			BEGIN
				SELECT * 
				FROM uvwGPA
				WHERE GPANo LIKE @GPANo
					AND OwnerID LIKE @OwnerID
					AND LegalName LIKE @LegalName
					AND SiteName LIKE @SiteName
					AND CustomerName LIKE @CustomerName
					AND KeyProductLineName LIKE @KeyProductLineName
					AND ProductName LIKE @ProductName
					AND AgreementName LIKE @AgreementName
					AND StatusName LIKE @StatusName
					AND ContractInDate Between @ContractInDateFrom AND @ContractInDateTo
					AND ExpectedClosingDate Between @ExpectedClosingDateFrom AND @ExpectedClosingDateTo
					AND ActualClosingDate Between @ActualClosingDateFrom AND @ActualClosingDateTo
					AND StatusName LIKE @StatusName
					AND ISNULL(Attachment,'') LIKE @Attachment
					AND Closed=@Closed
					AND ISNULL(Deleted,0)=0
				ORDER BY GPANo
			END
	END
IF @GPANO='%Undelete%'
	BEGIN
		IF EXISTS(SELECT * FROM Users WHERE UserID LIKE @OwnerID AND Administrator=1) OR EXISTS(SELECT * FROM Users WHERE UserID LIKE @OwnerID AND ViewAll=1)
			BEGIN
				SELECT * 
				FROM uvwGPA
				WHERE GPANo LIKE '%'
					--AND OwnerID LIKE @OwnerID
					AND LegalName LIKE @LegalName
					AND SiteName LIKE @SiteName
					AND CustomerName LIKE @CustomerName
					AND KeyProductLineName LIKE @KeyProductLineName
					AND ProductName LIKE @ProductName
					AND AgreementName LIKE @AgreementName
					AND StatusName LIKE @StatusName
					AND ContractInDate Between @ContractInDateFrom AND @ContractInDateTo
					AND ExpectedClosingDate Between @ExpectedClosingDateFrom AND @ExpectedClosingDateTo
					AND ActualClosingDate Between @ActualClosingDateFrom AND @ActualClosingDateTo
					AND StatusName LIKE @StatusName
					AND ISNULL(Attachment,'') LIKE @Attachment
					--AND Closed=@Closed
					AND ISNULL(Deleted,0)=1
				ORDER BY GPANo
			END
		ELSE
			BEGIN
				SELECT * 
				FROM uvwGPA
				WHERE GPANo LIKE @GPANo
					AND OwnerID LIKE @OwnerID
					AND LegalName LIKE @LegalName
					AND SiteName LIKE @SiteName
					AND CustomerName LIKE @CustomerName
					AND KeyProductLineName LIKE @KeyProductLineName
					AND ProductName LIKE @ProductName
					AND AgreementName LIKE @AgreementName
					AND StatusName LIKE @StatusName
					AND ContractInDate Between @ContractInDateFrom AND @ContractInDateTo
					AND ExpectedClosingDate Between @ExpectedClosingDateFrom AND @ExpectedClosingDateTo
					AND ActualClosingDate Between @ActualClosingDateFrom AND @ActualClosingDateTo
					AND StatusName LIKE @StatusName
					AND ISNULL(Attachment,'') LIKE @Attachment
					--AND Closed=@Closed
					AND ISNULL(Deleted,0)=1
				ORDER BY GPANo
			END

	END
GO
