USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_MaintainTarget_Type]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<sun zhang>
-- Create date: <7/14/2011>
-- Description:	<MaintainTargett的Type下拉列表值>
-- =============================================
create PROCEDURE [dbo].[ManageReportAnalysis_MaintainTarget_Type]
	@Target  nvarchar(50)
AS
BEGIN

    SELECT      distinct  T$ASTR
	FROM       TFIATT006180
	WHERE     ([T$ATTR] = @Target and [T$ASTR]<>'')
	order by  [T$ASTR]
   
END



GO
