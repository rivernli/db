USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Revenue_by_Technology_SetKeyTechnology_List]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create proc [dbo].[KOI_sp_Revenue_by_Technology_SetKeyTechnology_List] 
@Plant NVARCHAR(4),
@CreateUser NVARCHAR(50) 
as

select Technology from KOI_Revenue_by_Technology_SetKey where Plant=@Plant AND CreateUser=@CreateUser ORDER BY Technology DESC





GO
