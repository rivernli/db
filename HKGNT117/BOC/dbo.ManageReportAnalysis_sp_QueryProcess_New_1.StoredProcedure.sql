USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryProcess_New_1]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create proc [dbo].[ManageReportAnalysis_sp_QueryProcess_New_1]
@FYear nvarchar(10),
@plant nvarchar(15),
@top int,
@Type  nvarchar(30)
as
	begin
		declare @c nvarchar(30)
		declare @x nvarchar(30)
		declare @y nvarchar(30)
		declare	@SQL_String nvarchar(500)
		declare @i int
		declare @m int
		declare @Loop_Period int
		declare @Loop_Field int
		declare @Field nvarchar(30)
		declare @Field_Properes nvarchar(30)
		declare @Field_Period nvarchar(10)

		set @c = ''
		set @x = ''
		set @y = ''

		if ltrim(rtrim(@plant)) <> 'ALL'
			set @plant = ltrim(rtrim(@plant))
		else
			set @plant = ''

		if exists(select * from tempdb.dbo.sysobjects where id = object_id(N'tempdb..#costdetail') and type = 'U')
			drop table #costdetail
		select * into #costdetail from costdetail
	
		if exists(select * from tempdb.dbo.sysobjects where id = object_id(N'tempdb..#TableField') and type = 'U')
			drop table #TableField
		Create table #TableField(ID int identity ,FieldName nvarchar(30),Fproperies nvarchar(30))
		insert into #TableField(FieldName,Fproperies) values('SaleAmount','float')
		insert into #TableField(FieldName,Fproperies) values('UnitPrice','nvarchar(50)')
		insert into #TableField(FieldName,Fproperies) values('AveUnitPrice','float')
		insert into #TableField(FieldName,Fproperies) values('AveTotalcostexc','float')
		insert into #TableField(FieldName,Fproperies) values('TotalCostExScrpt','nvarchar(50)')
		insert into #TableField(FieldName,Fproperies) values('Spread','float')

		-- Query Current Fiscal Year exists Period
		if exists(select * from tempdb.dbo.sysobjects where id = object_id(N'tempdb..#CostPeriod') and type = 'U')
			drop table #CostPeriod
		select Period into #CostPeriod from #costdetail where FYear = @FYear and Plant like N'%'+ @Plant+'%' group by Period order by Period
		alter table #CostPeriod add ID int identity

		-- Find top 5 or 10 project by ShipmentAmount
		if exists(select * from tempdb.dbo.sysobjects where id = object_id(N'tempdb..##CostSummary') and type='U')
			drop table ##CostSummary
		set @SQL_String = 'select top '+ cast(@top as nvarchar(3)) +' plant,project,sum(salesamount) as ShipmentAmount into ##CostSummary
			from #costdetail where plant like N'+''''+'%'+@plant+'%'+''''+' and FYear = '+''''+@FYear+''''+'
			group by plant,project
			order by ShipmentAmount Desc'
		execute(@SQL_String)
		-- ================ Add OEM Name ===========================
		alter table ##CostSummary add OEM_Name nvarchar(55)
		set @SQL_String = 'update ##CostSummary set ##CostSummary.OEM_Name = (select dbo.CostItemMatchOEM.OEM_Name from dbo.CostItemMatchOEM where CostItemMatchOEM.item = ##CostSummary.project)'
		execute(@SQL_String)

		-- Dynamic add Field
		-- add all request field Field 

		select @m = max(id) from #TableField
		select @i = max(ID) from #CostPeriod

		set @Loop_Field = 1
		while @Loop_Field <= @m
			begin
				select @Field = FieldName,@Field_Properes = Fproperies from #TableField where ID = @Loop_Field
				set @Loop_Period = 1
				while @Loop_Period <= @i
					BEGIN
						select @Field_Period = period from #CostPeriod where ID = @Loop_Period
						set @SQL_String = 'alter table ##CostSummary add '+@Field + @Field_Period +' '+ @Field_Properes
						EXECUTE(@SQL_String)
						
						if @Field = 'SaleAmount'
							begin
								set @SQL_String = ' UPDATE ##CostSummary set ##CostSummary.SaleAmount'+@Field_Period +' = (select sum(salesamount) from #costdetail where #costdetail.plant like N'+''''+'%'+@plant+'%'+''''+' and #costdetail.project = ##CostSummary.project and #costdetail.Period = '+''''+@Field_Period+''''+')'
								EXECUTE(@SQL_String)								
							end
						if @Field = 'UnitPrice'
							begin
								if exists(select * from tempdb.dbo.sysobjects where id = object_id(N'tempdb..#t') and type='U')
									drop table #t

								SELECT * into #t FROM ##CostSummary A 
								OUTER APPLY(SELECT unitprice= STUFF(REPLACE(REPLACE(
											(
												SELECT DISTINCT cast(unitprice as nvarchar(10)) as UnitPrice FROM #CostDetail N
												WHERE project = A.project
												and Fyear = @FYear
												and Period = @Field_Period
												and Plant like N'%'+ @Plant + '%'
												FOR XML AUTO
											), '<N UnitPrice="', ','), '"/>', ''), 1, 1, '')
								)N
								set @SQL_String = ' UPDATE ##CostSummary set ##CostSummary.UnitPrice'+@Field_Period +' = (select UnitPrice from #t where #t.project = ##CostSummary.project)'
								EXECUTE(@SQL_String)	
							end
						if @Field = 'AveUnitPrice'
							begin
								set @SQL_String = 'update ##CostSummary set ##CostSummary.AveUnitPrice'+@Field_Period +' = cast((select sum(salesamount)/sum(ShipmentQty) from #costdetail where #costdetail.plant like N'+''''+'%'+@plant+'%'+''''+'  and #costdetail.project = ##CostSummary.project and Period = '+''''+@Field_Period+''''+') as decimal(18, 2))'
								EXECUTE(@SQL_String)								
							end
						if @Field = 'AveTotalcostexc'
							begin
								set @SQL_String = 'update ##CostSummary set ##CostSummary.AveTotalcostexc'+@Field_Period +' = cast((select sum(TotalCostExcludedScrap*ShipmentQty)/sum(ShipmentQty) from costdetail where costdetail.plant like N'+''''+'%'+@plant+'%'+''''+'  and costdetail.project = ##CostSummary.project and Period = '+''''+@Field_Period+''''+') as decimal(18, 2))'
								EXECUTE(@SQL_String)
							end
						if @Field = 'TotalCostExScrpt'
							begin
								if exists(select * from tempdb.dbo.sysobjects where id = object_id(N'tempdb..#te') and type='U')
									drop table #te

								SELECT * into #te FROM ##CostSummary A 
								OUTER APPLY(SELECT TotalCostExcludedScrap= STUFF(REPLACE(REPLACE(
											(
												SELECT DISTINCT cast(cast(TotalCostExcludedScrap as decimal(18,2)) as nvarchar(30)) as TotalCostExcludedScrap FROM #CostDetail N
												WHERE project = A.project
												and Fyear = @FYear
												and Period = @Field_Period
												and Plant like N'%'+@Plant+'%'
												FOR XML AUTO
											), '<N TotalCostExcludedScrap="', ','), '"/>', ''), 1, 1, '')
								)N
								set @SQL_String = ' UPDATE ##CostSummary set ##CostSummary.TotalCostExScrpt'+@Field_Period +' = (select TotalCostExcludedScrap from #te where #te.project = ##CostSummary.project)'
								EXECUTE(@SQL_String)
							end
						if @Field = 'Spread'
							begin
								set @SQL_String = 'update ##CostSummary set Spread'+@Field_Period +' = cast(AveUnitPrice'+@Field_Period +' - AveTotalcostexc'+@Field_Period+' as decimal(18, 2))'
								EXECUTE(@SQL_String)
							end
						set @Loop_Period = @Loop_Period + 1
					end
				set @Loop_Field = @Loop_Field + 1
			end

		-- ================ show result ===========================
		create index Index_ShipmentAmount on ##CostSummary (ShipmentAmount)

		if ltrim(rtrim(@Type)) = 'UnitPrice'
			begin
				set @SQL_String = 'select Project,OEM_Name'
				set @Loop_Period = 1
				while @Loop_Period <= @i
						BEGIN
							select @Field_Period = period from #CostPeriod where ID = @Loop_Period
							set @SQL_String =  @SQL_String +','+'UnitPrice'+ @Field_Period
							set @Loop_Period = @Loop_Period + 1
						END
				set @Loop_Period = 1
				while @Loop_Period <= @i
						BEGIN
							select @Field_Period = period from #CostPeriod where ID = @Loop_Period
							set @SQL_String =  @SQL_String +','+'AveUnitPrice'+ @Field_Period
							set @Loop_Period = @Loop_Period + 1
						END
				set @SQL_String = @SQL_String + ' from ##CostSummary'
				EXECUTE(@SQL_String)
			end

		if ltrim(rtrim(@Type)) = 'TotalCostExScrpt'
			begin
				set @SQL_String = 'select Project,OEM_Name'
				set @Loop_Period = 1
				while @Loop_Period <= @i
						BEGIN
							select @Field_Period = period from #CostPeriod where ID = @Loop_Period
							set @SQL_String =  @SQL_String +','+'TotalCostExScrpt'+ @Field_Period
							set @Loop_Period = @Loop_Period + 1
						END
				set @SQL_String = @SQL_String + ' from ##CostSummary'
				EXECUTE(@SQL_String)
			end
			
		if ltrim(rtrim(@Type)) = 'Spread'
			begin
				set @SQL_String = 'select Project,OEM_Name'
				set @Loop_Period = 1
				while @Loop_Period <= @i
						BEGIN
							select @Field_Period = period from #CostPeriod where ID = @Loop_Period
							set @SQL_String =  @SQL_String +','+'AveUnitPrice'+ @Field_Period
							set @Loop_Period = @Loop_Period + 1
						END

				set @Loop_Period = 1
				while @Loop_Period <= @i
						BEGIN
							select @Field_Period = period from #CostPeriod where ID = @Loop_Period
							set @SQL_String =  @SQL_String +','+'TotalCostExScrpt'+ @Field_Period
							set @Loop_Period = @Loop_Period + 1
						END
				set @Loop_Period = 1
				while @Loop_Period <= @i
						BEGIN
							select @Field_Period = period from #CostPeriod where ID = @Loop_Period
							set @SQL_String =  @SQL_String +','+'Spread'+ @Field_Period
							set @Loop_Period = @Loop_Period + 1
						END

				set @SQL_String = @SQL_String + ' from ##CostSummary'
				EXECUTE(@SQL_String)
			end

			
		if ltrim(rtrim(@Type)) = 'ALL'
			begin
				set @SQL_String = 'select Project,OEM_Name'
				set @Loop_Period = 1
				while @Loop_Period <= @i
						BEGIN
							select @Field_Period = period from #CostPeriod where ID = @Loop_Period
							set @SQL_String =  @SQL_String +','+'AveUnitPrice'+ @Field_Period
							set @Loop_Period = @Loop_Period + 1
						END

				set @Loop_Period = 1
				while @Loop_Period <= @i
						BEGIN
							select @Field_Period = period from #CostPeriod where ID = @Loop_Period
							set @SQL_String =  @SQL_String +','+'AveTotalcostexc'+ @Field_Period
							set @Loop_Period = @Loop_Period + 1
						END
				set @Loop_Period = 1
				while @Loop_Period <= @i
						BEGIN
							select @Field_Period = period from #CostPeriod where ID = @Loop_Period
							set @SQL_String =  @SQL_String +','+'Spread'+ @Field_Period
							set @Loop_Period = @Loop_Period + 1
						END

				set @SQL_String = @SQL_String + ' from ##CostSummary'
				EXECUTE(@SQL_String)
			end
	end




GO
