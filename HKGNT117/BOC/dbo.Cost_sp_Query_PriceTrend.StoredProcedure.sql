USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Cost_sp_Query_PriceTrend]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Cost_sp_Query_PriceTrend]
@Vendor nvarchar(100)
--	@Domain VARCHAR(50)=NULL,
--	@Account VARCHAR(50)=NULL,
--	@BDMGAM	VARCHAR(50)=NULL,
--	@Email	VARCHAR(50)=NULL
AS

SET NOCOUNT ON

	set @Vendor = isnull(@Vendor,'') 
BEGIN
	select * from dbo.CostPriceTrend 
	where 	Vender like N'%'+@Vendor+'%'
	order by ID

END

GO
