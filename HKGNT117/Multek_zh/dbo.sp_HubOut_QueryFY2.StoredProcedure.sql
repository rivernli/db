USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubOut_QueryFY2]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_HubOut_QueryFY2]
@start int,@end int,@isOEM bit,@Acl bit
as
begin
/*special for FY year on hub out. */
if(@Acl =1)
	begin
		if(@isOEM=1)
		begin
			SELECT isnull(OEM,'') as OEM,a.fiscalYear as T,isnull(sum(amount),0) as tamt 
			FROM vw_CalenderLDFY as a LEFT JOIN vw_4RP_HubOutExt as b ON a.fiscalYear = b.fiscalYear
			where a.fiscalYear between @start and @end
			group by OEM,a.fiscalYear order by a.fiscalYear
		end
		else
		begin
			SELECT isnull(plant,'') as plant,a.fiscalYear as T,isnull(sum(amount),0) as tamt 
			FROM vw_CalenderLDFY as a LEFT JOIN vw_4RP_HubOutExt as b ON a.fiscalYear = b.fiscalYear
			where a.fiscalYear between @start and @end
			group by plant,a.fiscalYear order by a.fiscalYear
		end
	end
else
	begin
		if(@isOEM=1)
		begin
			SELECT isnull(OEM,'') as OEM,a.fiscalYear as T,isnull(sum(amount),0) as tamt 
			from vw_CalenderLDFY as a LEFT JOIN vw_4RP_HubOutExt as b on lastDate=iDate
			where a.fiscalYear between @start and @end
			group by OEM,a.fiscalYear order by a.fiscalYear
		end
		else
		begin
			SELECT isnull(plant,'') as Plant,a.fiscalYear as T,isnull(sum(amount),0) as tamt 
			from vw_CalenderLDFY as a LEFT JOIN vw_4RP_HubOutExt as b on lastDate=iDate
			where a.fiscalYear between @start and @end
			group by plant,a.fiscalYear order by a.fiscalYear
		end
	end
end

GO
