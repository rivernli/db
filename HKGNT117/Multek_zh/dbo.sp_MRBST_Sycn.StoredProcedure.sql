USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRBST_Sycn]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MRBST_Sycn]
AS
	EXEC dbo.sp_MRBST_Sycn_Weekly_V1
	EXEC dbo.sp_MRBST_Sycn_Weekly_V2
	EXEC dbo.sp_MRBST_Sycn_Level31
	EXEC dbo.sp_MRBST_Sycn_Level33
	EXEC dbo.sp_MRBST_Sycn_Suggestion
	EXEC dbo.sp_MRBST_Sycn_TargetLine
GO
