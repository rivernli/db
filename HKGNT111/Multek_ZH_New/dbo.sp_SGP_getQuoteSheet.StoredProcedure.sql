USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_getQuoteSheet]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_SGP_getQuoteSheet] @id int
as

Select a.id, A.rfq,  A.outdate, A.OEM, A.CEM, A.name, A.programme, 
A.tPN as PN, A.REV, A.qty1, A.leadtime, A.price1,
A.currency,  A.remark1, A.qty2, A.price2, 
A.remark2, A.qty3, A.price3, 
A.remark3, A.qty4, A.price4, 
A.remark4, A.qty5, A.price5, 
A.remark5, A.setupcharge,
A.EtestCharge,
A.toolingcharge, 
A.moq, A.moq as moq2, 
A.shipterms, A.payterms, A.note1, A.note2, A.matl, A.matltype, A.thk, 

A.unit, A.copper, A.finishing, 
A.Lno,  A.Lni,  A.outline, A.remark, A.width, A.length,  
A.arraywidth, A.arraylength,  A.unitperarray, A.layers, A.holes, A.smallesthole, 
A.imped, A.usize, A.uqty, A.blindsize, A.blindqty, A.buriesize, A.burieqty , 
case when isnumeric(a.moq)=1 and isnumeric(a.price1)=1  and charindex('$',a.moq)=0 and charindex('$',a.price1)=0 then
convert(int,(convert(float,replace(A.MOQ,',','')) / convert(float,replace(A.price1,',',''))))
else
0
end
as minorder,
 
 SUBSTRING(dbo.fx_trim(A.prodwidth)+dbo.fx_trim(A.prodlength)+dbo.fx_trim(A.unitperprod), 2, 100)
+'('+ convert(char(2),[dbo].[fx_plant2Number](building))+')' as internalREF,
 
SUBSTRING(dbo.fx_trim(A.prodwidth)+dbo.fx_trim(A.prodlength)+dbo.fx_trim(A.unitperprod), 2, 100) as internalREF_bk,
  
  B.name as salesname, B.company as salescompany, 
  B.phone as salesphone, B.fax as salesfax, B.cellphone as salescellphone, B.email as salesemail 
  
  from sgp_data A left outer join sgp_acl B on A.salesman = B.name


where a.id=@id
GO
