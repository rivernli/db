USE [multekchi_realtime]
GO
/****** Object:  StoredProcedure [dbo].[Backlog_CN_DE_BR]    Script Date: 2014/11/12 17:13:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[Backlog_CN_DE_BR]
@OEM varchar(MAX),
@CEM varchar(MAX),
@project nvarchar(10),
@Committed_Date_From  nvarchar(30),
@Committed_Date_To   nvarchar(30),
@cust_part_no nvarchar(50),
@warehouse        nvarchar(10),
@deliver          nvarchar(10),
@cust_po          nvarchar(50),
@order_type       nvarchar(50),
@Baan_SO          nvarchar(15),
@site             varchar(15),
@ast_so           nvarchar(50),
@cust_code        nvarchar(50)
as
declare @expOEM varchar(MAX)
declare @expCEM varchar(MAX)
declare @expProject varchar(MAX)

declare @expcust_part_no varchar(MAX)
declare @expCommittedDate  varchar(MAX)
declare @expWarehouse varchar(MAX)

declare @expDeliver varchar(MAX)
declare @expCustPo varchar(MAX)
declare @expOrderType varchar(MAX)


declare @expSO varchar(MAX)
declare @expSite varchar(MAX)

declare @expAST varchar(MAX)
declare @expCustCode varchar(MAX)
declare @expInvoice varchar(MAX)
declare  @view      nvarchar(50)
declare @sqlstr varchar(MAX)
declare @order nvarchar(100)




SET @project=N'%'+ISNULL(ltrim(rtrim(@project)),'')+'%'  
--SET @cust_part_no = N'%'+ISNULL(ltrim(rtrim(@cust_part_no)),'')+'%' 

set @Committed_Date_From = isnull(@Committed_Date_From,getdate()-20000)
set @Committed_Date_To = isnull(@Committed_Date_To,getdate()+100000)


SET @warehouse=N'%'+ISNULL(ltrim(rtrim(@warehouse)),'')+'%'  

SET @cust_po=N'%'+ISNULL(ltrim(rtrim(@cust_po)),'')+'%'
SET @order_type=N'%'+ISNULL(ltrim(rtrim(@order_type)),'')+'%'
SET @Baan_SO=N'%'+ISNULL(ltrim(rtrim(@Baan_SO)),'')+'%'
set @order = ' order by part_no'

if  @OEM  = ''
	set @expOEM  = ''
else
	begin
		SET @OEM=N'%'+ISNULL(ltrim(rtrim(@OEM)),'')+'%'
		set @expOEM  =' and ltrim(rtrim(OEM_NAME)) like '+''''+ltrim(rtrim(@OEM))+''''
--		set @expOEM  =' and CHARINDEX(ltrim(rtrim(OEM_NAME)),'+''''+ltrim(rtrim(@OEM))+''''+')>0'
	end 

if  @CEM = ''
	set @expCEM  = ''
else
	begin
		SET @CEM=N'%'+ISNULL(ltrim(rtrim(@CEM)),'')+'%'
		set @expCEM  =' and ltrim(rtrim(CEM_NAME)) like '+''''+ltrim(rtrim(@CEM))+''''
--	set @expCEM  =' and CHARINDEX(ltrim(rtrim(CEM_NAME)),'+''''+ltrim(rtrim(@CEM))+''''+')>0'
	end 

if  @project  = ''
	set @expProject = ''
else
	set @expProject  =' and ltrim(rtrim(Prj_No)) like '+''''+ltrim(rtrim(@project))+''''


if  @cust_part_no  = ''
	set @expcust_part_no = ''
else
	begin
	    SET @cust_part_no = N'%'+ISNULL(ltrim(rtrim(@cust_part_no)),'')+'%' 
		set @expcust_part_no  =' and ltrim(rtrim(part_No)) like '+''''+ltrim(rtrim(@cust_part_no))+''''
	end 



	set @expCommittedDate = ' and Committed_Date between '+''''+@Committed_Date_From+''''+' and '+ ''''+@Committed_Date_To+''''

if  @warehouse  = ''
	set @expWarehouse = ''
else
	set @expWarehouse  =' and ltrim(rtrim(Warehouse)) like '+''''+ltrim(rtrim(@warehouse))+''''

if  @deliver  = ''
	set @expDeliver = ''
else
	begin
		SET @deliver=N'%'+ISNULL(@deliver,'')+'%'
		set @expDeliver  =' and ltrim(rtrim(Del_code)) like '+''''+ltrim(rtrim(@deliver))+''''
	end 

if  @cust_po  = ''
	set @cust_po = ''
else
	set @expCustPo  =' and ltrim(rtrim(PO_No)) like '+''''+ltrim(rtrim(@cust_po))+''''

if  @order_type  = ''
	set @expOrderType = ''
else
	set @expOrderType  =' and ltrim(rtrim(Order_type)) like '+''''+ltrim(rtrim(@order_type))+''''

if  @Baan_SO  = ''
	set @expSO = ''
else
	set @expSO  =' and ltrim(rtrim(Baan_SO)) like '+''''+ltrim(rtrim(@Baan_SO))+''''


if  @site  = 'CN'
	set @view = 'vMKT_Backlog_CN_New'
if  @site  = 'DE'
	set @view = 'vMKT_Backlog_DE_New'
if  @site  = 'BR'
	set @view = 'vMKT_Backlog_BR_New'

if  @ast_so  = ''
	set @expAST = ''
else
	begin
		SET @ast_so=N'%'+ISNULL(@ast_so,'')+'%'
		set @expAST  =' and ltrim(rtrim(AST_SO)) like '+''''+ltrim(rtrim(@ast_so))+''''
	end 


if  @cust_code  = ''
	set @expCustCode = ''
else
	begin
		SET @cust_code=N'%'+ISNULL(@cust_code,'')+'%'
		set @expCustCode  =' and ltrim(rtrim(Cust_Code)) like '+''''+ltrim(rtrim(@cust_code))+''''
	end 


set @sqlstr = 'select *  from '+ @view + '  where 1 = 1'+@expOEM + @expCEM + @expProject +@expcust_part_no +@expCommittedDate  + @expWarehouse + @expDeliver + @expCustPo + @expOrderType + @expSO + @expAST + @expCustCode + @order
--set @sqlstr = 'select oem_name,part_no,prj_no,po_no,UnitPrice,po_date,cust_req_date,invoice_date,currency,del_qty,del_sqft,Del_Amt_USD,ship_to_cty,order_type, sale_type,Unit_panel,invoice_no ,baan_so, site, warehouse,  ast_so, cust_code,product_name,Del_Code,Project_type  from vMKT_Backlog_CN_New  where 1 = 1'--+@expOEM + @expCEM + @expProject +@expCommittedDate  + @expWarehouse + @expDeliver + @expCustPo + @expOrderType + @expSO + @expAST + @expCustCode 

--print @sqlstr
execute(@sqlstr)


GO
