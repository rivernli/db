USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_cemUploadCompareOutputTemp]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_gam_cemUploadCompareOutputTemp] @keyStamp nvarchar(100)
as

set nocount on

select oem,code,pn,cpn,ipn,plant,q1,q2,q3,q4,q5,q6 
from cemFCtable2 as a left join cemFC_customerPN  as b
on cpn like '%' + a.pn +'%' 
where keystamp =@keyStamp

delete cemFCtable2 where keystamp=@keyStamp

set nocount off



GO
