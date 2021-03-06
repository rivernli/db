USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_updateUser]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_SGP_updateUser]
@uid nvarchar(10),@name nvarchar(100),@manager nvarchar(100),@company nvarchar(100)='Multek',
@phone nvarchar(50),@fax nvarchar(50),@cellphone nvarchar(50),@email nvarchar(100),
@dom nvarchar(50),@status nvarchar(10),@memail nvarchar(100)
as 
SET NOCOUNT ON;
update sgp_acl set name=@name,manager=@manager
,company=@company
,phone=@phone,fax=@fax,cellphone=@cellphone,email=@email,dom=@dom,[status]=@status,memail=@memail
where uid=@uid
GO
