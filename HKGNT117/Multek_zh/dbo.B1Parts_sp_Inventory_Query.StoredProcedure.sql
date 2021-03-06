USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_Inventory_Query]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[B1Parts_sp_Inventory_Query]
	--@DateState NVARCHAR(50),
	@DateEnd NVARCHAR(50),
	@SPPN NVARCHAR(50) 
AS

declare @strWhere nvarchar(max),@strWhere1 nvarchar(max), @strWhere2 nvarchar(max), @sql nvarchar(max) 
set @strWhere='where 1=1 ' 
set @strWhere1='where 1=1 ' 
set @strWhere2='where 1=1 ' 
--if @DateState <> ''
--	set @strWhere = @strWhere+ ' and Date >= '''+ @DateState +'''' 
--	set @strWhere1 = @strWhere1+ ' and ReceivedDate >= '''+ @DateState +'''' 
if @DateEnd <> ''
	set @strWhere = @strWhere+ ' and Date <= '''+ @DateEnd +''''
	set @strWhere1 = @strWhere1+ ' and ReceivedDate <= '''+ @DateEnd +'''' 
if @SPPN<>''
    set @strWhere = @strWhere+ ' and PartNo >= '''+ @SPPN +'''' 
	set @strWhere1 = @strWhere1+ ' and PartNo >= '''+ @SPPN +'''' 
	set @strWhere2 = @strWhere2+ ' and NewPN like ''%'+@SPPN+'%'''


--发货
--INNER JOIN B1Parts_Equipment_List ON B1Parts_Equipment_List.EqNo=B1Parts_Daily_Issue_List.WorkCenter
--INNER JOIN B1Parts_Line_List ON B1Parts_Line_List.EqAr=B1Parts_Equipment_List.EqAr '
set @sql ='select B1Parts_Daily_Issue_List.PartNo,SUM(B1Parts_Daily_Issue_List.IssuedQty) AS TllissueQty  
INTO ##B1Parts_Daily_Issue_Temp
from B1Parts_SP_Part_List 
LEFT JOIN B1Parts_Daily_Issue_List ON B1Parts_SP_Part_List.NewPN=B1Parts_Daily_Issue_List.PartNo 
INNER JOIN B1Parts_FES_Engineers ON B1Parts_FES_Engineers.ESUserNo=B1Parts_Daily_Issue_List.UserNo '
+ @strWhere + 'GROUP BY B1Parts_Daily_Issue_List.PartNO'
exec(@sql)
--------------------------------------------------------
--收货
set @sql ='select B1Parts_Daily_Receive_List.PartNo,SUM(B1Parts_Daily_Receive_List.ReceivedQty) AS TllReceiveQty 
INTO ##B1Parts_Daily_Receive_Temp
from B1Parts_Supplier_List 
LEFT JOIN B1Parts_Daily_Receive_List ON B1Parts_Daily_Receive_List.VendorNo=B1Parts_Supplier_List.VendorNo
INNER JOIN B1Parts_SP_Part_List ON B1Parts_SP_Part_List.NewPN=B1Parts_Daily_Receive_List.PartNo 
INNER JOIN B1Parts_Exchange_Rate_List ON B1Parts_Exchange_Rate_List.CC=B1Parts_Daily_Receive_List.Currency '
+ @strWhere1 +' GROUP BY B1Parts_Daily_Receive_List.PartNo'
exec(@sql)
---------------------------------------------------------
set @sql='select NewPN AS SPPN,NewDescription,Baanrice,
sum(Opening) as Opening, 
sum([In]) as StockIn, 
sum([Out]) as StockOut, 
sum(TransferOut) as TransferOut, 
((sum(Opening)+sum([In]))-sum([Out])-sum(TransferOut)) as Closing,Unit,Location,ABC, [Max], [Min],Belongto from 
(
select B1Parts_SP_Part_List.NewPN,B1Parts_SP_Part_List.NewDescription,B1Parts_SP_Part_List.Baanrice, 
(CASE WHEN Stocktaking_Qty IS NULL THEN ''0'' ELSE Stocktaking_Qty END) AS Opening,
(CASE WHEN TllReceiveQty IS NULL THEN ''0'' ELSE TllReceiveQty END) AS [In],
(CASE WHEN TllIssueQty IS NULL THEN ''0'' ELSE TllIssueQty END) AS Out,
(CASE WHEN TllTransferredQty IS NULL THEN ''0'' ELSE TllTransferredQty END) AS TransferOut,
B1Parts_SP_Part_List.Unit,B1Parts_SP_Part_List.Location,B1Parts_SP_Part_List.ABC,
B1Parts_SP_Part_List.[Max],B1Parts_SP_Part_List.[Min],B1Parts_SP_Part_List.Belongto 
 from B1Parts_SP_Part_List 
LEFT JOIN ##B1Parts_Daily_Issue_Temp ON B1Parts_SP_Part_List.NewPN=##B1Parts_Daily_Issue_Temp.PartNO 
LEFT JOIN ##B1Parts_Daily_Receive_Temp ON B1Parts_SP_Part_List.NewPN=##B1Parts_Daily_Receive_Temp.PartNo
LEFT JOIN vw_B1Parts_Tll_Transfer_Qty ON B1Parts_SP_Part_List.NewPN=vw_B1Parts_Tll_Transfer_Qty.PartNO 
LEFT JOIN B1Parts_Opening_Inventory_SP ON B1Parts_SP_Part_List.NewPN=B1Parts_Opening_Inventory_SP.SPNO_Opening 
) a ' + @strWhere2 +' GROUP BY NewPN,NewDescription,Baanrice,Unit,Location,ABC, [Max], [Min],Belongto '
--print(@sql)
exec(@sql)


drop table ##B1Parts_Daily_Issue_Temp 
drop table ##B1Parts_Daily_Receive_Temp 






GO
