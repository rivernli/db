USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Loading_report_WhatIFQueryHistory]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Loading_report_WhatIFQueryHistory]
	@Analysis_User NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

    SET @Analysis_User = ISNULL(@Analysis_User,'')

	IF @Analysis_User = ''
		RAISERROR('Please select analysis user ID',16,1)
	ELSE
		BEGIN
			SELECT Analysis_User,Fiscal_Year,Fiscal_Period,Plant FROM dbo.tfsboc100180_analyse
			WHERE Analysis_User = @Analysis_User
			GROUP BY Analysis_User,Fiscal_Year,Fiscal_Period,Plant
		END
END

GO
