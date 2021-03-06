USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_InsertUpdateDelete_ByEHS]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[KOI_sp_InsertUpdateDelete_ByEHS]
   @ID INT=NULL,	
   @Plant varchar(2)=NULL,
   @Date datetime=NULL,
   @Incident float,
   @First_aid float,
   @Total_Accidents float,
   @Recordable_Accidents float,
   @LWD_Accidents float,
   @Disabled float,
   @Fatal float,
   @Recordable_Accident_Rate float,
   @LWD_Accident_Rate float,
   @Lost_Working_Days float,
   @Medical_Expense float,
   @Manpower_Loss float,
   @Total_Loss float,
   @Total_Loss_per_Case float,
   @Severity_Rate float,
   @Injury_Rate_per_200k_WH float,
	@Operation VARCHAR(10)
AS

SET NOCOUNT ON

IF @Operation='Insert' 
	BEGIN
		INSERT INTO KOI_InputByEHS (
		   [Plant] 
		   ,[Date] 
		   ,[Incident]
           ,[First_aid]
           ,[Total_Accidents]
           ,[Recordable_Accidents]
           ,[LWD_Accidents]
           ,[Disabled]
           ,[Fatal]
           ,[Recordable_Accident_Rate]
           ,[LWD_Accident_Rate]
           ,[Lost_Working_Days]
           ,[Medical_Expense]
           ,[Manpower_Loss]
           ,[Total_Loss]
           ,[Total_Loss_per_Case]
           ,[Severity_Rate]
           ,[Injury_Rate_per_200k_WH])
		VALUES(
		   @Plant  
		   ,@Date 
		   ,@Incident 
           ,@First_aid
           ,@Total_Accidents
           ,@Recordable_Accidents
           ,@LWD_Accidents
           ,@Disabled
           ,@Fatal
           ,@Recordable_Accident_Rate
           ,@LWD_Accident_Rate
           ,@Lost_Working_Days
           ,@Medical_Expense
           ,@Manpower_Loss
           ,@Total_Loss
           ,@Total_Loss_per_Case
           ,@Severity_Rate
           ,@Injury_Rate_per_200k_WH)
	END
IF @Operation='Update' 
	BEGIN
		UPDATE KOI_InputByEHS 
		SET
			[Plant]=@Plant 
		   ,[Date]=@Date 
		   ,[Incident]=@Incident
           ,[First_aid]=@First_aid
           ,[Total_Accidents]=@Total_Accidents
           ,[Recordable_Accidents]=@Recordable_Accidents
           ,[LWD_Accidents]=@LWD_Accidents
           ,[Disabled]=@Disabled
           ,[Fatal]=@Fatal
           ,[Recordable_Accident_Rate]=@Recordable_Accident_Rate
           ,[LWD_Accident_Rate]=@LWD_Accident_Rate
           ,[Lost_Working_Days]=@Lost_Working_Days
           ,[Medical_Expense]=@Medical_Expense
           ,[Manpower_Loss]=@Manpower_Loss
           ,[Total_Loss]=@Total_Loss
           ,[Total_Loss_per_Case]=@Total_Loss_per_Case
           ,[Severity_Rate]=@Severity_Rate 
           ,[Injury_Rate_per_200k_WH]=@Injury_Rate_per_200k_WH 
		WHERE ID=@ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE KOI_InputByEHS 
		WHERE ID=@ID 
	END










GO
