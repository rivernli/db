USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryProcess]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[ManageReportAnalysis_sp_QueryProcess]
@plant nvarchar(15),
@top int
as
	begin
		declare @c nvarchar(30)
		declare @x nvarchar(30)
		declare @y nvarchar(30)
		declare	@SQL_String nvarchar(300)

		set @c = ''
		set @x = ''
		set @y = ''

		if ltrim(rtrim(@plant)) <> 'ALL'
			begin
				select  distinct plant,project into #Temp from costdetail where plant = @plant
				
				alter table #Temp add ShipmentAmount float
				update #Temp set #Temp.ShipmentAmount = (select sum(salesamount) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project)
				
				alter table #Temp add SaleAmountP05 float
				update #Temp set #Temp.SaleAmountP05 = (select sum(salesamount) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P05')

				alter table #Temp add SaleAmountP06 float
				update #Temp set #Temp.SaleAmountP06 = (select sum(salesamount) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P06')

				alter table #Temp add SaleAmountP07 float
				update #Temp set #Temp.SaleAmountP07 = (select sum(salesamount) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P07')

				alter table #Temp add SaleAmountP08 float
				update #Temp set #Temp.SaleAmountP08 = (select sum(salesamount) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P08')

				alter table #Temp add SaleAmountP09 float
				update #Temp set #Temp.SaleAmountP09 = (select sum(salesamount) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P09')
			
				--===============================  Unit Price ==================================
				alter table #Temp add UnitPriceP05 nvarchar(30)
				update #Temp set #Temp.UnitPriceP05 = (select top 1 cast(unitprice as decimal(18, 2)) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P05')
				-- update more than 1 projec unitprice
				select project into #Temp0 from costdetail where plant = @plant and period = 'P05' group by project having count(project)>1
				update #Temp set #Temp.UnitPriceP05 = dbo.Shipment_sp_IntergrationUnitPrice(@plant,'P05',#Temp.project)
				where #Temp.project in(select project from #Temp0)

				truncate table #Temp0
				alter table #Temp add UnitPriceP06 nvarchar(30)
				update #Temp set #Temp.UnitPriceP06 = (select top 1 cast(unitprice as decimal(18, 2)) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P06')
				-- update more than 1 projec unitprice
				insert into #Temp0(Project) select project from costdetail where plant = @plant and period = 'P06' group by project having count(project)>1
				update #Temp set #Temp.UnitPriceP06 = dbo.Shipment_sp_IntergrationUnitPrice(@plant,'P06',#Temp.project)
				where #Temp.project in(select project from #Temp0)

				truncate table #Temp0
				alter table #Temp add UnitPriceP07 nvarchar(30)
				update #Temp set #Temp.UnitPriceP07 = (select top 1 cast(unitprice as decimal(18, 2)) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P07')
				-- update more than 1 projec unitprice
				insert into #Temp0(project) select project from costdetail where plant = @plant and period = 'P07' group by project having count(project)>1
				update #Temp set #Temp.UnitPriceP07 = dbo.Shipment_sp_IntergrationUnitPrice(@plant,'P07',#Temp.project)
				where #Temp.project in(select project from #Temp0)

				truncate table #Temp0
				alter table #Temp add UnitPriceP08 nvarchar(30)
				update #Temp set #Temp.UnitPriceP08 = (select top 1 cast(unitprice as decimal(18, 2)) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P08')
				-- update more than 1 projec unitprice
				insert into #Temp0(project) select project from costdetail where plant = @plant and period = 'P08' group by project having count(project)>1
				update #Temp set #Temp.UnitPriceP08 = dbo.Shipment_sp_IntergrationUnitPrice(@plant,'P08',#Temp.project)
				where #Temp.project in(select project from #Temp0)

				truncate table #Temp0
				alter table #Temp add UnitPriceP09 nvarchar(30)
				update #Temp set #Temp.UnitPriceP09 = (select top 1 cast(unitprice as decimal(18, 2)) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P09')
				-- update more than 1 projec unitprice
				insert into #Temp0(project) select project from costdetail where plant = @plant and period = 'P09' group by project having count(project)>1
				update #Temp set #Temp.UnitPriceP09 = dbo.Shipment_sp_IntergrationUnitPrice(@plant,'P09',#Temp.project)
				where #Temp.project in(select project from #Temp0)

				-- ============================== Average Unit Price =================================================
				alter table #Temp add AveUnitPriceP05 float
				update #Temp set #Temp.AveUnitPriceP05 = cast((select sum(salesamount)/sum(ShipmentQty) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P05') as decimal(18, 2))

				alter table #Temp add AveUnitPriceP06 float
				update #Temp set #Temp.AveUnitPriceP06 = cast((select sum(salesamount)/sum(ShipmentQty) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P06') as decimal(18, 2))

				alter table #Temp add AveUnitPriceP07 float
				update #Temp set #Temp.AveUnitPriceP07 = cast((select sum(salesamount)/sum(ShipmentQty) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P07') as decimal(18, 2))
				
				alter table #Temp add AveUnitPriceP08 float
				update #Temp set #Temp.AveUnitPriceP08 = cast((select sum(salesamount)/sum(ShipmentQty) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P08') as decimal(18, 2))

				alter table #Temp add AveUnitPriceP09 float
				update #Temp set #Temp.AveUnitPriceP09 = cast((select sum(salesamount)/sum(ShipmentQty) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P09') as decimal(18, 2))

				-- ============================== Average Total Cost exclude scrp =================================================
				alter table #Temp add AveTotalcostexcP05 float
				update #Temp set #Temp.AveTotalcostexcP05 = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P05') as decimal(18, 2))

				alter table #Temp add AveTotalcostexcP06 float
				update #Temp set #Temp.AveTotalcostexcP06 = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P06') as decimal(18, 2))

				alter table #Temp add AveTotalcostexcP07 float
				update #Temp set #Temp.AveTotalcostexcP07 = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P07') as decimal(18, 2))
				
				alter table #Temp add AveTotalcostexcP08 float
				update #Temp set #Temp.AveTotalcostexcP08 = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P08') as decimal(18, 2))

				alter table #Temp add AveTotalcostexcP09 float
				update #Temp set #Temp.AveTotalcostexcP09 = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P09') as decimal(18, 2))


				--===================== Total cost exclude Scrpt =======================================================
				alter table #Temp add TotalCostExScrptP05 nvarchar(30)
				update #Temp set #Temp.TotalCostExScrptP05 = (select top 1 cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P05')
				-- update more than 1 projec TotalCostExScrpt
				select  project,TotalCostExcludedScrap into #Temp1 from costdetail where plant = @plant and period = 'P05' group by project,TotalCostExcludedScrap having count(project)>1

				update #Temp set #Temp.TotalCostExScrptP05 = dbo.Shipment_sp_IntergrationTotalCostES(@plant,'P05',#Temp.project)
				where #Temp.project in(select project from #Temp1 )

				truncate table #Temp1
				alter table #Temp add TotalCostExScrptP06 nvarchar(30)
				update #Temp set #Temp.TotalCostExScrptP06 = (select top 1 cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P06')
				-- update more than 1 projec TotalCostExScrpt
				insert into #Temp1(project,TotalCostExcludedScrap) select  project,cast(TotalCostExcludedScrap as decimal(18, 2))  from costdetail where plant = @plant and period = 'P06' group by project,TotalCostExcludedScrap having count(project)>1

				update #Temp set #Temp.TotalCostExScrptP06 = dbo.Shipment_sp_IntergrationTotalCostES(@plant,'P06',#Temp.project)
				where #Temp.project in(select project from #Temp1 )

				truncate table #Temp1
				alter table #Temp add TotalCostExScrptP07 nvarchar(30)
				update #Temp set #Temp.TotalCostExScrptP07 = (select top 1 cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P07')
				-- update more than 1 projec TotalCostExScrpt
				insert into #Temp1(project,TotalCostExcludedScrap) select  project,cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where plant = @plant and period = 'P07' group by project,TotalCostExcludedScrap having count(project)>1

				update #Temp set #Temp.TotalCostExScrptP07 = dbo.Shipment_sp_IntergrationTotalCostES(@plant,'P07',#Temp.project)
				where #Temp.project in(select project from #Temp1 )

				truncate table #Temp1
				alter table #Temp add TotalCostExScrptP08 nvarchar(30)
				update #Temp set #Temp.TotalCostExScrptP08 = (select top 1 cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P08')
				-- update more than 1 projec TotalCostExScrpt
				insert into #Temp1(project,TotalCostExcludedScrap) select  project,cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where plant = @plant and period = 'P08' group by project,TotalCostExcludedScrap having count(project)>1

				update #Temp set #Temp.TotalCostExScrptP08 = dbo.Shipment_sp_IntergrationTotalCostES(@plant,'P08',#Temp.project)
				where #Temp.project in(select project from #Temp1 )

				truncate table #Temp1
				alter table #Temp add TotalCostExScrptP09 nvarchar(30)
				update #Temp set #Temp.TotalCostExScrptP09 = (select top 1 cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where costdetail.plant = @plant and costdetail.project = #Temp.project and Period = 'P09')
				-- update more than 1 projec TotalCostExScrpt
				insert into #Temp1(project,TotalCostExcludedScrap) select  project,cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where plant = @plant and period = 'P09' group by project,TotalCostExcludedScrap having count(project)>1

				update #Temp set #Temp.TotalCostExScrptP09 = dbo.Shipment_sp_IntergrationTotalCostES(@plant,'P09',#Temp.project)
				where #Temp.project in(select project from #Temp1 )

				--===================== Total cost exclude Scrpt =======================================================
				alter table #Temp add SpreadP05 nvarchar(30),SpreadP06 nvarchar(30),SpreadP07 nvarchar(30),SpreadP08 nvarchar(30),SpreadP09 nvarchar(30)
				update #Temp set SpreadP05 = AveUnitPriceP05 - TotalCostExScrptP05,
								 SpreadP06 = AveUnitPriceP06 - TotalCostExScrptP06,
								 SpreadP07 = AveUnitPriceP07 - TotalCostExScrptP07,
								 SpreadP08 = AveUnitPriceP08 - TotalCostExScrptP08,
								 SpreadP09 = AveUnitPriceP09 - TotalCostExScrptP09

				-- ================ Add OEM Name ===========================
				alter table #Temp add OEM_Name nvarchar(50)
				update #Temp set OEM_Name = (select Oem_name from dbo.CostItemMatchOEM where CostItemMatchOEM.item = #Temp.project)

				-- ================ show result ===========================
				create index Index_ShipmentAmount on #Temp (ShipmentAmount)
				
				set @SQL_String = 'select top '+cast(@top as nvarchar(5))+' * from #Temp order by ShipmentAmount desc '

				--print @SQL_String
				execute(@SQL_String)
				--select * from #Temp order by ShipmentAmount desc
			end
		else
			begin
				select  distinct plant,project into #Temp_else from costdetail
				
				alter table #Temp_else add ShipmentAmount float
				update #Temp_else set #Temp_else.ShipmentAmount = (select sum(salesamount) from costdetail where  costdetail.project = #Temp_else.project)
				
				alter table #Temp_else add SaleAmountP05 float
				update #Temp_else set #Temp_else.SaleAmountP05 = (select sum(salesamount) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P05')

				alter table #Temp_else add SaleAmountP06 float
				update #Temp_else set #Temp_else.SaleAmountP06 = (select sum(salesamount) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P06')

				alter table #Temp_else add SaleAmountP07 float
				update #Temp_else set #Temp_else.SaleAmountP07 = (select sum(salesamount) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P07')

				alter table #Temp_else add SaleAmountP08 float
				update #Temp_else set #Temp_else.SaleAmountP08 = (select sum(salesamount) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P08')

				alter table #Temp_else add SaleAmountP09 float
				update #Temp_else set #Temp_else.SaleAmountP09 = (select sum(salesamount) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P09')
			
				--===============================  Unit Price ==================================
				alter table #Temp_else add UnitPriceP05 nvarchar(30)
				update #Temp_else set #Temp_else.UnitPriceP05 = (select top 1 cast(unitprice as decimal(18, 2)) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P05')
				-- update more than 1 projec unitprice
				select project into #Temp_else0 from costdetail where  period = 'P05' group by project having count(project)>1
				update #Temp_else set #Temp_else.UnitPriceP05 = dbo.Shipment_sp_IntergrationUnitPrice(@plant,'P05',#Temp_else.project)
				where #Temp_else.project in(select project from #Temp_else0)

				truncate table #Temp_else0
				alter table #Temp_else add UnitPriceP06 nvarchar(30)
				update #Temp_else set #Temp_else.UnitPriceP06 = (select top 1 cast(unitprice as decimal(18, 2)) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P06')
				-- update more than 1 projec unitprice
				insert into #Temp_else0(Project) select project from costdetail where  period = 'P06' group by project having count(project)>1
				update #Temp_else set #Temp_else.UnitPriceP06 = dbo.Shipment_sp_IntergrationUnitPrice(@plant,'P06',#Temp_else.project)
				where #Temp_else.project in(select project from #Temp_else0)

				truncate table #Temp_else0
				alter table #Temp_else add UnitPriceP07 nvarchar(30)
				update #Temp_else set #Temp_else.UnitPriceP07 = (select top 1 cast(unitprice as decimal(18, 2)) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P07')
				-- update more than 1 projec unitprice
				insert into #Temp_else0(project) select project from costdetail where  period = 'P07' group by project having count(project)>1
				update #Temp_else set #Temp_else.UnitPriceP07 = dbo.Shipment_sp_IntergrationUnitPrice(@plant,'P07',#Temp_else.project)
				where #Temp_else.project in(select project from #Temp_else0)

				truncate table #Temp_else0
				alter table #Temp_else add UnitPriceP08 nvarchar(30)
				update #Temp_else set #Temp_else.UnitPriceP08 = (select top 1 cast(unitprice as decimal(18, 2)) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P08')
				-- update more than 1 projec unitprice
				insert into #Temp_else0(project) select project from costdetail where  period = 'P08' group by project having count(project)>1
				update #Temp_else set #Temp_else.UnitPriceP08 = dbo.Shipment_sp_IntergrationUnitPrice(@plant,'P08',#Temp_else.project)
				where #Temp_else.project in(select project from #Temp_else0)

				truncate table #Temp_else0
				alter table #Temp_else add UnitPriceP09 nvarchar(30)
				update #Temp_else set #Temp_else.UnitPriceP09 = (select top 1 cast(unitprice as decimal(18, 2)) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P09')
				-- update more than 1 projec unitprice
				insert into #Temp_else0(project) select project from costdetail where  period = 'P09' group by project having count(project)>1
				update #Temp_else set #Temp_else.UnitPriceP09 = dbo.Shipment_sp_IntergrationUnitPrice(@plant,'P09',#Temp_else.project)
				where #Temp_else.project in(select project from #Temp_else0)

				-- ============================== Average Unit Price =================================================
				alter table #Temp_else add AveUnitPriceP05 float
				update #Temp_else set #Temp_else.AveUnitPriceP05 = cast((select sum(salesamount)/sum(ShipmentQty) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P05') as decimal(18, 2))

				alter table #Temp_else add AveUnitPriceP06 float
				update #Temp_else set #Temp_else.AveUnitPriceP06 = cast((select sum(salesamount)/sum(ShipmentQty) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P06') as decimal(18, 2))

				alter table #Temp_else add AveUnitPriceP07 float
				update #Temp_else set #Temp_else.AveUnitPriceP07 = cast((select sum(salesamount)/sum(ShipmentQty) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P07') as decimal(18, 2))
				
				alter table #Temp_else add AveUnitPriceP08 float
				update #Temp_else set #Temp_else.AveUnitPriceP08 = cast((select sum(salesamount)/sum(ShipmentQty) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P08') as decimal(18, 2))

				alter table #Temp_else add AveUnitPriceP09 float
				update #Temp_else set #Temp_else.AveUnitPriceP09 = cast((select sum(salesamount)/sum(ShipmentQty) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P09') as decimal(18, 2))

				-- ============================== Average Total Cost exclude scrp =================================================
				alter table #Temp_else add AveTotalcostexcP05 float
				update #Temp_else set #Temp_else.AveTotalcostexcP05 = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P05') as decimal(18, 2))

				alter table #Temp_else add AveTotalcostexcP06 float
				update #Temp_else set #Temp_else.AveTotalcostexcP06 = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P06') as decimal(18, 2))

				alter table #Temp_else add AveTotalcostexcP07 float
				update #Temp_else set #Temp_else.AveTotalcostexcP07 = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P07') as decimal(18, 2))
				
				alter table #Temp_else add AveTotalcostexcP08 float
				update #Temp_else set #Temp_else.AveTotalcostexcP08 = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P08') as decimal(18, 2))

				alter table #Temp_else add AveTotalcostexcP09 float
				update #Temp_else set #Temp_else.AveTotalcostexcP09 = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P09') as decimal(18, 2))

				--===================== Total cost exclude Scrpt =======================================================
				alter table #Temp_else add TotalCostExScrptP05 nvarchar(30)
				update #Temp_else set #Temp_else.TotalCostExScrptP05 = (select top 1 cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P05')
				-- update more than 1 projec TotalCostExScrpt
				select  project,TotalCostExcludedScrap into #Temp_else1 from costdetail where  period = 'P05' group by project,TotalCostExcludedScrap having count(project)>1

				if exists(select top 1 * from #Temp_else1)
					begin
						update #Temp_else set #Temp_else.TotalCostExScrptP05 = dbo.Shipment_sp_IntergrationTotalCostES(@plant,'P05',#Temp_else.project)
						where #Temp_else.project in(select project from #Temp_else1 )
					end

				truncate table #Temp_else1
				alter table #Temp_else add TotalCostExScrptP06 nvarchar(30)
				update #Temp_else set #Temp_else.TotalCostExScrptP06 = (select top 1 cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P06')
				-- update more than 1 projec TotalCostExScrpt
				insert into #Temp_else1(project,TotalCostExcludedScrap) select  project,cast(TotalCostExcludedScrap as decimal(18, 2))  from costdetail where  period = 'P06' group by project,TotalCostExcludedScrap having count(project)>1
				if exists(select top 1 * from #Temp_else1)
					begin
						update #Temp_else set #Temp_else.TotalCostExScrptP06 = dbo.Shipment_sp_IntergrationTotalCostES(@plant,'P06',#Temp_else.project)
						where #Temp_else.project in(select project from #Temp_else1 )
					end

				truncate table #Temp_else1
				alter table #Temp_else add TotalCostExScrptP07 nvarchar(30)
				update #Temp_else set #Temp_else.TotalCostExScrptP07 = (select top 1 cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P07')
				-- update more than 1 projec TotalCostExScrpt
				insert into #Temp_else1(project,TotalCostExcludedScrap) select  project,cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where  period = 'P07' group by project,TotalCostExcludedScrap having count(project)>1
				if exists(select top 1 * from #Temp_else1)
					begin
						update #Temp_else set #Temp_else.TotalCostExScrptP07 = dbo.Shipment_sp_IntergrationTotalCostES(@plant,'P07',#Temp_else.project)
						where #Temp_else.project in(select project from #Temp_else1 )
					end

				truncate table #Temp_else1
				alter table #Temp_else add TotalCostExScrptP08 nvarchar(30)
				update #Temp_else set #Temp_else.TotalCostExScrptP08 = (select top 1 cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P08')
				-- update more than 1 projec TotalCostExScrpt
				insert into #Temp_else1(project,TotalCostExcludedScrap) select  project,cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where  period = 'P08' group by project,TotalCostExcludedScrap having count(project)>1
				if exists(select top 1 * from #Temp_else1)
					begin
						update #Temp_else set #Temp_else.TotalCostExScrptP08 = dbo.Shipment_sp_IntergrationTotalCostES(@plant,'P08',#Temp_else.project)
						where #Temp_else.project in(select project from #Temp_else1 )
					end

				truncate table #Temp_else1
				alter table #Temp_else add TotalCostExScrptP09 nvarchar(30)
				update #Temp_else set #Temp_else.TotalCostExScrptP09 = (select top 1 cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where  costdetail.project = #Temp_else.project and Period = 'P09')
				-- update more than 1 projec TotalCostExScrpt
				insert into #Temp_else1(project,TotalCostExcludedScrap) select  project,cast(TotalCostExcludedScrap as decimal(18, 2)) from costdetail where  period = 'P09' group by project,TotalCostExcludedScrap having count(project)>1
				if exists(select top 1 * from #Temp_else1)
					begin
						update #Temp_else set #Temp_else.TotalCostExScrptP09 = dbo.Shipment_sp_IntergrationTotalCostES(@plant,'P09',#Temp_else.project)
						where #Temp_else.project in(select project from #Temp_else1 )
					end

				--===================== Total cost exclude Scrpt =======================================================
				alter table #Temp_else add SpreadP05 nvarchar(30),SpreadP06 nvarchar(30),SpreadP07 nvarchar(30),SpreadP08 nvarchar(30),SpreadP09 nvarchar(30)
				update #Temp_else set SpreadP05 = AveUnitPriceP05 - AveTotalcostexcP05,
								 SpreadP06 = AveUnitPriceP06 - AveTotalcostexcP06,
								 SpreadP07 = AveUnitPriceP07 - AveTotalcostexcP07,
								 SpreadP08 = AveUnitPriceP08 - AveTotalcostexcP08,
								 SpreadP09 = AveUnitPriceP09 - AveTotalcostexcP09
				-- ================ Add OEM Name ===========================
				alter table #Temp_else add OEM_Name nvarchar(50)
				update #Temp_else set OEM_Name = (select Oem_name from dbo.CostItemMatchOEM where CostItemMatchOEM.item = #Temp_else.project)
				-- ================ show result ===========================
				create index Index_ShipmentAmount on #Temp_else (ShipmentAmount)
				
				set @SQL_String = 'select top '+cast(@top as nvarchar(5))+' * from #Temp_else order by ShipmentAmount desc '

				--print @SQL_String
				execute(@SQL_String)
				--select * from #Temp_else order by ShipmentAmount desc
			end
	end



GO
