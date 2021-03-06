USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[IES_fn_GetParentTotalLT]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IES_fn_GetParentTotalLT] 
(
	@RLayer	varchar(50),
	@Building varchar(10),
	@TotalValue DECIMAL(18, 2),
	@QTA INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
	DECLARE @MLayer VARCHAR(50)
	DECLARE @Result DECIMAL(18, 2)
	IF @QTA = 1 
		SELECT @MLayer = MLayer, 
				@Result = (SELECT SUM(QTALT) FROM IES_WorkFlow WHERE LayerNo = MLayer AND Building = @Building) 
				FROM IES_LayerRelation WHERE RLayer = @RLayer AND RLayer <> MLayer
	ELSE 
		SELECT @MLayer = MLayer, 
				@Result = (SELECT SUM(LT) FROM IES_WorkFlow WHERE LayerNo = MLayer AND Building = @Building) 
				FROM IES_LayerRelation WHERE RLayer = @RLayer AND RLayer <> MLayer
		
	IF @MLayer IS NULL
		SET @Result = @TotalValue
	ELSE 
		BEGIN
			SET @Result = @TotalValue + ISNULL(@Result,0)
			SET @Result = dbo.IES_fn_GetParentTotalLT(@MLayer,@Building,@Result,@QTA)
		END
	
	RETURN @Result
END


GO
