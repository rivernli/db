USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Right_sp_Manager]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<sun zhang>
-- Create date: <3/10/2011>
-- Description:	<manager选项>
-- =============================================
CREATE PROCEDURE [dbo].[Right_sp_Manager]
	
AS

SELECT UserID AS muid, BDM AS manager 
FROM Cost_Users 
ORDER BY UserID

GO
