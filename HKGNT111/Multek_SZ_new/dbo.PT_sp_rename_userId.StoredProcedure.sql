USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_rename_userId]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[PT_sp_rename_userId]  @oldId nvarchar(100),@newid nvarchar(100)
as
/*
declare @oldId nvarchar(100),@newid nvarchar(100)
select @oldId='asia\MCNCMDAT',@newid='asia\MCN_CMDAT'
*/
--select * from dbo.PT_Authority where UserID = 'asia\MCNCMDAT'
update PT_Authority set UserID=@newid where UserID = @oldId

--select * from dbo.PT_Users where UserID = 'asia\MCNCMDAT'
update PT_Users set UserID=@newid where UserID=@oldId

--select * from dbo.PT_Order_CheckList_Detail where TransferUserID='asia\MCNCMDAT'
update dbo.PT_Order_CheckList_Detail set TransferUserID=@newid where TransferUserID=@oldId

--select * from dbo.PT_Order_CheckList_Detail_DownLoad where ReceivingDownloadUserID = 'asia\MCNCMDAT'
update PT_Order_CheckList_Detail_DownLoad set ReceivingDownloadUserID=@newid where ReceivingDownloadUserID=@oldId
/*
select * from dbo.PT_Order where TransferingSiteOwnerUserID ='asia\MCNCMDAT'
or ReceivingSiteOwnerUserID = 'asia\MCNCMDAT'
select * from dbo.PT_Order_CheckList_Comment where UserID ='asia\MCNCMDAT'

select * from PT_Users where UserID = 'asia\MCN_CMDAT'
*/
GO
