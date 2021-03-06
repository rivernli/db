USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [dbo].[DW_DIM_ItemGroup_Auto_Update]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DW_DIM_ItemGroup_Auto_Update]

AS
BEGIN

	SET NOCOUNT ON;

	IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'DW_DIM_ItemGroup') AND TYPE = 'U')
		BEGIN
			SELECT T$CITG,T$DSCA INTO DW_DIM_ItemGroup FROM OPENQUERY(AS1P1,'SELECT T$CITG,T$DSCA FROM BAAN.TTCMCS023180')
			CREATE INDEX Index_ItemGroup ON DW_DIM_ItemGroup(T$CITG)
		END
	ELSE
		BEGIN
			INSERT INTO DW_DIM_Country SELECT T$CITG,T$DSCA FROM OPENQUERY(AS1P1,'SELECT T$CITG,T$DSCA FROM BAAN.TTCMCS023180') AS X WHERE X.T$CITG NOT IN(SELECT T$CITG FROM DW_DIM_ItemGroup)
		END
END

GO
