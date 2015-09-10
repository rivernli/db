USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp__addM6]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp__addM6]
 @d datetime, @m1 int, @m2 int, @m3 int, @m4 int, @m5 int, @m6 int, @sp int
as
set nocount on
insert into m6 (issue,date,number,isSP) values (0,@d,@m1,0)
insert into m6 (issue,date,number,isSP) values (0,@d,@m2,0)
insert into m6 (issue,date,number,isSP) values (0,@d,@m3,0)
insert into m6 (issue,date,number,isSP) values (0,@d,@m4,0)
insert into m6 (issue,date,number,isSP) values (0,@d,@m5,0)
insert into m6 (issue,date,number,isSP) values (0,@d,@m6,0)
insert into m6 (issue,date,number,isSP) values (0,@d,@sp,1)
set nocount off
GO
