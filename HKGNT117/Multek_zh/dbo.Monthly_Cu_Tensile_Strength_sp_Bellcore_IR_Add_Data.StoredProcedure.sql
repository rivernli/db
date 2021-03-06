USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Bellcore_IR_Add_Data]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Monthly_Cu_Tensile_Strength_sp_Bellcore_IR_Add_Data] 
	@Year varchar(5),
	@Month varchar(2),
	@Plant varchar(5),
	@Process nvarchar(50),
	@ProcessTest nvarchar(50),
	@ProcessType varchar(10),
	@SN varchar(50),
	@TestValue float=NULL 
AS
BEGIN

IF EXISTS(SELECT * FROM Monthly_Cu_Tensile_Strength_Bellcore_IR_Data WHERE [Year]=@Year AND [Month]=@Month AND Plant=@Plant AND Process=@Process AND ProcessTest=@ProcessTest AND ProcessType=@ProcessType AND SN=@SN)
	BEGIN
		UPDATE Monthly_Cu_Tensile_Strength_Bellcore_IR_Data SET TestValue=@TestValue WHERE [Year]=@Year AND [Month]=@Month AND Plant=@Plant AND Process=@Process AND ProcessTest=@ProcessTest AND ProcessType=@ProcessType AND SN=@SN  
	END
ELSE
	BEGIN
		INSERT INTO Monthly_Cu_Tensile_Strength_Bellcore_IR_Data ([Year],[Month],Plant,Process,ProcessTest,ProcessType,SN,TestValue)
				VALUES(@Year,@Month,@Plant,@Process,@ProcessTest,@ProcessType,@SN,@TestValue)
	END
			
				
END





GO
