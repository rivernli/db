USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Up_TFSAMI040180_Table]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<更新Surface Finish值">
-- =============================================
create PROCEDURE [dbo].[Up_TFSAMI040180_Table] 
	
AS
BEGIN
	truncate table [BOC-Demo].dbo.TFSAMI040180
	insert into [BOC-Demo].dbo.TFSAMI040180
	SELECT * FROM  FactoryLoading.dbo.TFSAMI040180
END

GO
