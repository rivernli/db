USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Up_CostItemMatchOEM_Table]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<更新OEM>
-- =============================================
create PROCEDURE [dbo].[Up_CostItemMatchOEM_Table] 
	
AS
BEGIN
	truncate table [BOC-Demo].dbo.CostItemMatchOEM
	insert into [BOC-Demo].dbo.CostItemMatchOEM    
	SELECT CAST(a.T$ITEM AS Nvarchar(55)) AS item, CAST(a.T$CSGS AS Nvarchar(6)) AS OEM, CAST(b.T$DSCA AS Nvarchar(50)) AS OEM_Name
	FROM         FactoryLoading.dbo.TTIITM001180 AS a LEFT OUTER JOIN FactoryLoading.dbo.TTCMCS044180 AS b ON a.T$CSGS = b.T$CSGP
END

GO
