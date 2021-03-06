USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_Query_User_Purchase]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[E_quote_sp_Query_User_Purchase]
@ManagerId VARCHAR(50)=NULL
as

with cte(UserID,ManagerId) 
as 
(--父项 
select UserID,ManagerId from E_quote_Users where ManagerId = @ManagerId
union all 
--递归结果集中的下级 
select t.UserID,t.ManagerId from E_quote_Users as t 
inner join cte as c on t.ManagerId = c.UserID 
) 
select UserID from cte 

GO
