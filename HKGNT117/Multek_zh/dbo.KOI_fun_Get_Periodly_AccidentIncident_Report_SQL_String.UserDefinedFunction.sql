USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[KOI_fun_Get_Periodly_AccidentIncident_Report_SQL_String]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create FUNCTION [dbo].[KOI_fun_Get_Periodly_AccidentIncident_Report_SQL_String]
(
	-- Add the parameters for the function here
	@Year VARCHAR(4),	
	@Period SMALLINT,
	@Plant NVARCHAR(50),	 
	@WorkingHours NUMERIC(18,2),
	@Incident NUMERIC(18,2),
	@First_aid NUMERIC(18,2),
	@Total_Accidents NUMERIC(18,2),
	@Recordable_Accidents NUMERIC(18,2),
	@LWD_Accidents NUMERIC(18,2),
	@Disabled NUMERIC(18,2),
	@Fatal NUMERIC(18,2),
	@Recordable_Accident_Rate NUMERIC(18,2),
	@LWD_Accident_Rate NUMERIC(18,2),
	@Lost_Working_Days NUMERIC(18,2),
	@Medical_Expense NUMERIC(18,2),
	@Manpower_Loss NUMERIC(18,2),
	@Total_Loss NUMERIC(18,2),
	@Total_Loss_per_Case NUMERIC(18,2),
	@Severity_Rate NUMERIC(18,2),
	@Injury_Rate_per_200k_WH NUMERIC(18,2) 
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM KOI_Periodly_AccidentIncident_Report WHERE Year='+''''+@Year+''''+' AND Period='+CONVERT(VARCHAR(3),@Period)+' AND Plant='+''''+@Plant+''''+') '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO KOI_Periodly_AccidentIncident_Report(Year,Period,Plant,WorkingHours,Incident,First_aid,Total_Accidents,Recordable_Accidents,LWD_Accidents,Disabled,
														Fatal,Recordable_Accident_Rate,LWD_Accident_Rate,Lost_Working_Days,Medical_Expense,Manpower_Loss,Total_Loss,Total_Loss_per_Case,Severity_Rate,Injury_Rate_per_200k_WH)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@Year+''''+','+''''+CONVERT(VARCHAR(3),@Period)+''''+','+''''+@Plant+''''+',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE KOI_Periodly_AccidentIncident_Report'
	SET @ReturnString=@ReturnString+'			SET WorkingHours='+CONVERT(VARCHAR(50),@WorkingHours)+',Incident='+CONVERT(VARCHAR(50),@Incident)+',First_aid='+CONVERT(VARCHAR(50),@First_aid)+',Total_Accidents='+CONVERT(VARCHAR(50),@Total_Accidents)+',Recordable_Accidents='+CONVERT(VARCHAR(50),@Recordable_Accidents)+',
												LWD_Accidents='+CONVERT(VARCHAR(50),@LWD_Accidents)+',Disabled='+CONVERT(VARCHAR(50),@Disabled)+',Fatal='+CONVERT(VARCHAR(50),@Fatal)+',Recordable_Accident_Rate='+CONVERT(VARCHAR(50),@Recordable_Accident_Rate)+',LWD_Accident_Rate='+CONVERT(VARCHAR(50),@LWD_Accident_Rate)+',
												Lost_Working_Days='+CONVERT(VARCHAR(50),@Lost_Working_Days)+',Medical_Expense='+CONVERT(VARCHAR(50),@Medical_Expense)+',Manpower_Loss='+CONVERT(VARCHAR(50),@Manpower_Loss)+',Total_Loss='+CONVERT(VARCHAR(50),@Total_Loss)+',Total_Loss_per_Case='+CONVERT(VARCHAR(50),@Total_Loss_per_Case)+',
												Severity_Rate='+CONVERT(VARCHAR(50),@Severity_Rate)+',Injury_Rate_per_200k_WH='+CONVERT(VARCHAR(50),@Injury_Rate_per_200k_WH)+' '
	SET @ReturnString=@ReturnString+'			WHERE Year='+''''+@Year+''''+' AND Period='+''''+CONVERT(VARCHAR(3),@Period)+''''+' AND Plant='+''''+@Plant+''' '

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END











GO
