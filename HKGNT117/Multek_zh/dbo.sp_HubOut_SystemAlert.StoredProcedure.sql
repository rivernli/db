USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubOut_SystemAlert]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_HubOut_SystemAlert]
as

declare @yesterday int
set @yesterday = convert(nvarchar(8),getdate()-1,112)
/*
select o.plant,o.oem,o.partNumber,i.amt as invAmt, o.amt as outAmt,i.amt-o.amt as dif from 
(select oem,plant,partNumber,sum(amount) as amt from vw_4RP_HUBOUT where idate=@yesterday group by oem,plant,partNumber) as o 
left join 
(select oem,plant,partNumber,sum(amount) as amt from vw_4RP_HubInv where idate=@yesterday-1 group by oem,plant,partNumber) as i 
on o.oem=i.oem and o.plant=i.plant and o.partNumber=i.partNumber
where i.amt-o.amt < 0
order by plant,oem,partNumber

*/

select o.plant,o.oem,o.partNumber,i.amt as invAmt, o.amt as outAmt,i.amt-o.amt as dif
,i.tqty as invQty,o.tqty as outQty, isnull(i.tqty,0)-isnull(o.tqty,0) as Qdif

 from 
(select oem,plant,partNumber,sum(amount) as amt,sum(qty) as tqty from vw_4RP_HUBOUT where idate=@yesterday group by oem,plant,partNumber) as o 
left join 
(select oem,plant,partNumber,sum(amount) as amt,sum(qty) as tqty from vw_4RP_HubInv where idate=@yesterday-1 group by oem,plant,partNumber) as i 
on o.oem=i.oem and o.plant=i.plant and o.partNumber=i.partNumber
where i.amt-o.amt < 0 or i.tqty-o.tqty < 0
order by plant,oem,partNumber

GO
