USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSdel_dboTFSOLP102180]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_MSdel_dboTFSOLP102180]
		@pkc1 float,
		@pkc2 float,
		@pkc3 float,
		@pkc4 float
as
begin  
	delete [dbo].[TFSOLP102180]
where [T$ORNO] = @pkc1
  and [T$PONO] = @pkc2
  and [T$SRNB] = @pkc3
  and [T$COMP] = @pkc4
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  

GO
