USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryPeriod]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/01/22>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[ManageReportAnalysis_sp_QueryPeriod]
@FYear nvarchar(15)
AS
BEGIN
	SET NOCOUNT ON;

	--select distinct (Fyear+Period) as Period
	--Apr(P1) May(P2) PToday Jul(P4) Aug(P5) Sep(P6) Oct(P7) Nov(P8) Dec(P9) Jan(P10) Feb(P11) Mar(P12) 
/*
	case Period  when 'P01' then 'Apr(P1)'
				 when 'P02' then 'May(P2)'
				 when 'P03' then 'Jun(P3)'
				 when 'P04' then 'Jul(P4)'
				 when 'P05' then 'Aug(P5)'
				 when 'P06' then 'Sep(P6)'
				 when 'P07' then 'Oct(P7)'
				 when 'P08' then 'Nov(P8)'
				 when 'P09' then 'Dec(P9)'
				 when 'P10' then 'Jan(P10)'
				 when 'P11' then 'Feb(P11)'
				 when 'P12' then 'Mar(P12)'
	end 
*/

	if exists (select * from sysobjects where id = object_id(N'temp.#temp_CostDetail') and type = 'U')
		drop table #temp_CostDetail

	select distinct Period
	into #temp_CostDetail
	from dbo.CostDetail 
	where Fyear = @FYear
	order by Period

	alter table #temp_CostDetail add Period_Desc nvarchar(50)

	update #temp_CostDetail set Period_Desc = (select 	case Period  when 'P01' then 'Apr(P1)'
				 when 'P02' then 'May(P2)'
				 when 'P03' then 'Jun(P3)'
				 when 'P04' then 'Jul(P4)'
				 when 'P05' then 'Aug(P5)'
				 when 'P06' then 'Sep(P6)'
				 when 'P07' then 'Oct(P7)'
				 when 'P08' then 'Nov(P8)'
				 when 'P09' then 'Dec(P9)'
				 when 'P10' then 'Jan(P10)'
				 when 'P11' then 'Feb(P11)'
				 when 'P12' then 'Mar(P12)'
	end  from #temp_CostDetail as x where x.Period = #temp_CostDetail.period)

	select Period_Desc from #temp_CostDetail order by period
END




GO
