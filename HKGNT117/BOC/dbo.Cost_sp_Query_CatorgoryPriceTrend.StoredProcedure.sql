USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Cost_sp_Query_CatorgoryPriceTrend]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Cost_sp_Query_CatorgoryPriceTrend]
@Vendor nvarchar(100)
--	@Domain VARCHAR(50)=NULL,
--	@Account VARCHAR(50)=NULL,
--	@BDMGAM	VARCHAR(50)=NULL,
--	@Email	VARCHAR(50)=NULL
AS

SET NOCOUNT ON
	set @Vendor = isnull(@Vendor,'') 
BEGIN

	select * from dbo.CostCatorgoryPriceTrend 
	where 	Vender like N'%'+@Vendor+'%'
	order by ID

END
GO
