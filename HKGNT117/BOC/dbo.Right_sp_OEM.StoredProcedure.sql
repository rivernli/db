USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Right_sp_OEM]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<sun zhang>
-- Create date: <3/12/2011>
-- Description:	<OEM选项>
-- =============================================
CREATE  PROCEDURE [dbo].[Right_sp_OEM]
	
AS
BEGIN
	
    SELECT     T$DSCA
    FROM         TTCMCS044180
    ORDER BY T$DSCA
END

GO
