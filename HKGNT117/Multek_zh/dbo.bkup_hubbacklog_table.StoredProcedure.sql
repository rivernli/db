USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[bkup_hubbacklog_table]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[bkup_hubbacklog_table]
as
insert into dbo.temp_verify_hubbacklog_fscpp253(T$crfn,T$eono,T$sern,T$eopo,T$orno,T$pono,T$wono,T$wsfx,T$wopo,T$wodt,T$oqty,T$cqty,T$sqty,T$pcdt,T$plnt,T$pjno,T$cwar,T$stat,T$nlne,T$RCDE,T$pos1,T$isub,T$frwq,T$txta,T$pitm,T$aqty,T$tqty,T$hksq,T$hubq,T$cqpm,T$desc) select T$crfn,T$eono,T$sern,T$eopo,T$orno,T$pono,T$wono,T$wsfx,T$wopo,T$wodt,T$oqty,T$cqty,T$sqty,T$pcdt,T$plnt,T$pjno,T$cwar,T$stat,T$nlne,T$RCDE,T$pos1,T$isub,T$frwq,T$txta,T$pitm,T$aqty,T$tqty,T$hksq,T$hubq,T$cqpm,T$desc from FactoryLoading.dbo.TFSCPP253180 where T$pcdt >'2010-10-1 00:00:00.000'
update dbo.temp_verify_hubbacklog_fscpp253 set T$date = getdate() where T$date is null


insert into dbo.temp_verify_hubbacklog_fsolp100(T$orno,T$pono,T$bad1,T$bad2,T$coba,T$cuno,T$cunm,T$cwar,T$refa,T$eono,T$item,T$cupn,T$podt,T$ddta,T$rqdt,T$oqua,T$bqua,T$ccur,T$pric,T$amnt,T$area,T$ecdt,T$addr,T$nama,T$csco,T$usnm,T$segm,T$cdsc,T$stat,T$cotp,T$styp,T$pspl,T$prdn,T$flex,T$iseg,T$desc) 
select T$orno,T$pono,T$bad1,T$bad2,T$coba,T$cuno,T$cunm,T$cwar,T$refa,T$eono,T$item,T$cupn,T$podt,T$ddta,T$rqdt,T$oqua,T$bqua,T$ccur,T$pric,T$amnt,T$area,T$ecdt,T$addr,T$nama,T$csco,T$usnm,T$segm,T$cdsc,T$stat,T$cotp,T$styp,T$pspl,T$prdn,T$flex,T$iseg,T$desc from multekchi_realtime.dbo.TFSOLP100180
update dbo.temp_verify_hubbacklog_fsolp100 set T$date = getdate() where T$date is null


insert into dbo.temp_verify_hubbacklog_HubBacklog(T$orno,T$pono,T$item,T$ecdt,FG_avaible,T$amnt,T$ddta,T$plnt,T$cdsc) 
select T$orno,T$pono,T$item,T$ecdt,FG_avaible,T$amnt,T$ddta,T$plnt,T$cdsc from dbo.HubBacklog
update dbo.temp_verify_hubbacklog_HubBacklog set T$date = getdate() where T$date is null
GO
