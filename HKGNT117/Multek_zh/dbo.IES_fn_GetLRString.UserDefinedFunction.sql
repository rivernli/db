USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[IES_fn_GetLRString]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[IES_fn_GetLRString] 
(
	@RLayer	varchar(50),
	@Building varchar(10),
	@LRString varchar(4000)
)
RETURNS varchar(4000)
AS
BEGIN

	DECLARE @MLayer VARCHAR(50)
	DECLARE @Result DECIMAL(18, 2)
	SELECT @MLayer = MLayer FROM IES_LayerRelation WHERE RLayer = @RLayer AND RLayer <> MLayer
	IF @MLayer IS NOT NULL
		BEGIN
			SET @LRString = @MLayer + ',' + dbo.IES_fn_GetLRString(@MLayer,@Building,@LRString)
		END
	
	RETURN @LRString
END


GO
