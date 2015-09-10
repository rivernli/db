USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Revenue_by_OEM_SetKeyOEM_List]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[KOI_sp_Revenue_by_OEM_SetKeyOEM_List] 
@Plant NVARCHAR(4),
@CreateUser NVARCHAR(50) 
as
select OEM from KOI_Revenue_by_OEM_SetKey where Plant=@Plant AND CreateUser=@CreateUser ORDER BY OEM DESC



GO
