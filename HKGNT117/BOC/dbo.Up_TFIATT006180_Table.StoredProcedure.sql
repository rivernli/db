USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Up_TFIATT006180_Table]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<更新Techology 和 Surface Finish">
-- =============================================
CREATE PROCEDURE [dbo].[Up_TFIATT006180_Table] 
	
AS
BEGIN
	truncate table [BOC-Demo].dbo.TFIATT006180
	insert into [BOC-Demo].dbo.TFIATT006180
	SELECT * FROM  FactoryLoading.dbo.TFIATT006180
END

GO
