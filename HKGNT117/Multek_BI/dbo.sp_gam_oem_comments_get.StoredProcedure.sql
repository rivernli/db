USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_oem_comments_get]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_gam_oem_comments_get]
@oem_id int,@author nvarchar(100)

as 
select top 50 *,case when @author=author then 1 else 0 end as del from gam_oem_comments where oem_id=@oem_id and active=1
order by comment_id desc
GO
