USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Query_Weekly]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[VI_Report_sp_Query_Weekly]
	-- Add the parameters for the stored procedure here
	@Loc VARCHAR(10),
	@Year VARCHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @Loc='Global'	
	BEGIN
		--SELECT * FROM VI_Report_Weekly WHERE Year=@Year 	
		SELECT Year,Week,WeekDesc,SUM(Amount) as Amount FROM VI_Report_Weekly WHERE Year=@Year group by Year,Week,WeekDesc	order by Week ASC
	END
	ELSE
	BEGIN
		SELECT * FROM VI_Report_Weekly WHERE Year=@Year AND Loc = @Loc order by Week ASC
	END
END

GO
