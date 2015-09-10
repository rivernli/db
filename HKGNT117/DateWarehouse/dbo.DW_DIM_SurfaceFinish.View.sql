USE [DataWarehouse]
GO
/****** Object:  View [dbo].[DW_DIM_SurfaceFinish]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--ALTER VIEW DW_DIM_Product_Type
--AS
--SELECT	RTRIM(T$VALU) AS T$VALU FROM dbo.TFSAMI028180 
--WHERE T$ITEM = 'type                '


CREATE VIEW [dbo].[DW_DIM_SurfaceFinish]
AS
SELECT T$MNWC,RTRIM(T$DSCA) AS T$DSCA FROM dbo.TFSAMI040180
GO
