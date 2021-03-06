USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Update_ProjectUSY]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IES_sp_Update_ProjectUSY] 	
		@ID INT=NULL,
		@Building VARCHAR(50)=NULL,
		@Project VARCHAR(50)=NULL
AS
	DECLARE @Unit DECIMAL(18, 4)
	DECLARE @Sqft DECIMAL(18, 4)

	SELECT TOP 1 @Unit=Unit, @Sqft=Sqft FROM IES_PJList_Source 
		WHERE Project = @Project AND Building = @Building 
		ORDER BY 
			CASE WHEN SubProject LIKE '%-00' THEN 1 
				 WHEN SubProject LIKE '%-AS%' THEN 2 
				 ELSE 3 END ASC, 
			CASE WHEN Yield IS NOT NULL THEN 1 
				 ELSE 2 END ASC,
			SubProject DESC,ID DESC
	UPDATE IES_PJDatabase SET Unit = ISNULL(@Unit, Unit), Sqft = ISNULL(@Sqft, Sqft)
		WHERE ID = @ID



GO
