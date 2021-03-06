USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_addUser]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_SGP_addUser]
@uid nvarchar(10),@name nvarchar(100),@manager nvarchar(100),@company nvarchar(100)='Multek',
@phone nvarchar(50),@fax nvarchar(50),@cellphone nvarchar(50),@email nvarchar(100),
@dom nvarchar(50),@status nvarchar(10),@memail nvarchar(100)
as 
SET NOCOUNT ON;
insert into sgp_ACL (uid,name,manager,company,phone,fax,cellphone,email,dom,status,memail)
values (@uid,@name,@manager,@company,@phone,@fax,@cellphone,@email,@dom,@status,@memail)
GO
