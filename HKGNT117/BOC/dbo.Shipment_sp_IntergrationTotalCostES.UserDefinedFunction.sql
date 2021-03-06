USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Shipment_sp_IntergrationTotalCostES]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Rivern Li>
-- Create date: <Create Date,2010/01/21>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[Shipment_sp_IntergrationTotalCostES](@Plant nvarchar(15),@Period nvarchar(5),@project nvarchar(30))
RETURNS nvarchar(30)
AS
BEGIN
	declare @c nvarchar(30)
	declare @x nvarchar(30)
	declare @y nvarchar(30)

	set @c = ''
	set @x = ''
	set @y = ''

	if ltrim(rtrim(@plant)) <> 'ALL'
		begin
			select @y=@x,@x=x.project,
			--@c=@c + (case @x when @y then ',' else ';'+ x.project end) +cast(x.d as nvarchar(20))
			@c=@c + (case @x when @y then ',' else ';' end) +cast(x.d as nvarchar(20))
			from (select cast(TotalCostExcludedScrap as decimal(18, 2)) as d,Project from costdetail where costdetail.plant = @plant  and Period = @Period and project = @project group by TotalCostExcludedScrap ,Project) as x 
			order by x.project 

			set @c=substring(@c,2,len(@c)-1) 
		end
	else
		begin
			select @y=@x,@x=x.project,
			--@c=@c + (case @x when @y then ',' else ';'+ x.project end) +cast(x.d as nvarchar(20))
			@c=@c + (case @x when @y then ',' else ';' end) +cast(x.d as nvarchar(20))
			from (select cast(TotalCostExcludedScrap as decimal(18, 2)) as d,Project from costdetail where Period = @Period and project = @project group by TotalCostExcludedScrap ,Project) as x 
			order by x.project 

			set @c=substring(@c,2,len(@c)-1) 
		end
	set @c = isnull(@c,'')
	set @c = ltrim(rtrim(@c))
	RETURN @c

END

GO
