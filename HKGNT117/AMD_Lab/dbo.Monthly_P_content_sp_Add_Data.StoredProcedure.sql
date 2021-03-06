USE [AMD_Lab]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_P_content_sp_Add_Data]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[Monthly_P_content_sp_Add_Data] 
	@Year varchar(5),
	@Plant varchar(10),
	@Site nvarchar(50),
	@Jan char(5),
	@Feb char(5),
	@Mar char(5),
	@Apr char(5),
	@May char(5),
	@Jun char(5),
	@Jul char(5),
	@Aug char(5),
	@Sep char(5),
	@Oct char(5),
	@Nov char(5),
	@Dec char(5) 
AS
BEGIN 

IF EXISTS(SELECT * FROM Monthly_P_content_Data WHERE [Year]=@Year AND Plant=@Plant AND [Site]=@Site)
	BEGIN
		UPDATE Monthly_P_content_Data SET Jan=@Jan, Feb=@Feb, Mar=@Mar, Apr=@Apr, May=@May, Jun=@Jun, Jul=@Jul, Aug=@Aug, Sep=@Sep, Oct=@Oct, Nov=@Nov, [Dec]=@Dec WHERE [Year]=@Year AND Plant=@Plant AND [Site]=@Site 
	END
 ELSE
	BEGIN
		INSERT INTO Monthly_P_content_Data ([Year], Plant, [Site], Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, [Dec])
			   VALUES(@Year, @Plant, @Site, @Jan, @Feb, @Mar, @Apr, @May, @Jun, @Jul, @Aug, @Sep, @Oct, @Nov, @Dec)			
	END			
END






GO
