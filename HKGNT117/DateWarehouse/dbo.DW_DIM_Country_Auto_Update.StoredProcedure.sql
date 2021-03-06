USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [dbo].[DW_DIM_Country_Auto_Update]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DW_DIM_Country_Auto_Update]

AS
BEGIN

	SET NOCOUNT ON;

	IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'DW_DIM_Country') AND TYPE = 'U')
		BEGIN
			SELECT T$CCTY,T$DSCA INTO DW_DIM_Country FROM OPENQUERY(AS1P1,'SELECT * FROM BAAN.TTCMCS010180')
			CREATE INDEX Index_Country ON DW_DIM_Country(T$CCTY)
		END
	ELSE
		BEGIN
			INSERT INTO DW_DIM_Country SELECT T$CCTY,T$DSCA FROM OPENQUERY(AS1P1,'SELECT T$CCTY,T$DSCA FROM BAAN.TTCMCS010180') AS X WHERE X.T$CCTY NOT IN(SELECT T$CCTY FROM DW_DIM_Country)
		END
END

GO
