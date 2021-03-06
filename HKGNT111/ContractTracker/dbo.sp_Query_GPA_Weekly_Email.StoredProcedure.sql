USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_GPA_Weekly_Email]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Query_GPA_Weekly_Email] 
	-- Add the parameters for the stored procedure here
	@OwnerID VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM uvwGPA
	WHERE OwnerID =@OwnerID
		AND Closed=0
		AND Deleted=0
	ORDER BY GPANo
END
GO
