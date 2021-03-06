USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Product_Cost_Project]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 

CREATE PROCEDURE [dbo].[Product_Cost_Project]
	@plant VARCHAR(2),
	@oem NVARCHAR(100),
	@Technology NVARCHAR(100),
	@Layers NVARCHAR(50), 
	@CostVersion VARCHAR(2) 
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @QuertString NVARCHAR(MAX) 

	IF @plant<>'' 
		SET @QuertString = ' AND T$PLNT = '''+@plant+''' '
	IF @oem<>''
		SET @QuertString =@QuertString+ ' AND T$dsca = '''+@oem+''' '
	IF @Technology<>''
		SET @QuertString =@QuertString+ ' AND T$atyp = '''+@Technology+''' '
	IF @Layers<>''
		SET @QuertString =@QuertString+ ' AND SUBSTRING(T$PJNO,2,2) = '''+@Layers+''' '
	IF @CostVersion<>''
		SET @QuertString =@QuertString+ ' AND T$SERN = '''+@CostVersion+''' '

	EXEC('select T$PJNO from vc_Standard_Cost_TFSBOM400180
	WHERE 1=1 '+@QuertString +' order by T$PJNO ASC' )
END 






GO
