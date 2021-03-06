USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Add_Data]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[Monthly_Cu_Tensile_Strength_sp_Add_Data] 
	@Year varchar(5),
	@Month varchar(2),
	@Plant varchar(5),
	@ProductionLine	nvarchar(50),
	@Tank nvarchar(50),
	@TankType varchar(10),
	@Type nvarchar(50),
	@SN varchar(50),
	@TestValue float=NULL 
AS
BEGIN

IF EXISTS(SELECT * FROM Monthly_Cu_Tensile_Strength_Data WHERE [Year]=@Year AND [Month]=@Month AND Plant=@Plant AND ProductionLine=@ProductionLine AND Tank=@Tank AND TankType=@TankType AND [Type]=@Type AND SN=@SN)
	BEGIN
		UPDATE Monthly_Cu_Tensile_Strength_Data SET TestValue=@TestValue WHERE [Year]=@Year AND [Month]=@Month AND Plant=@Plant AND ProductionLine=@ProductionLine AND Tank=@Tank AND TankType=@TankType AND [Type]=@Type AND SN=@SN 
	END
ELSE
	BEGIN
		INSERT INTO Monthly_Cu_Tensile_Strength_Data ([Year],[Month],Plant,ProductionLine,Tank,TankType,[Type],SN,TestValue)
				VALUES(@Year,@Month,@Plant,@ProductionLine,@Tank,@TankType,@Type,@SN,@TestValue)
	END
			
				
END





GO
