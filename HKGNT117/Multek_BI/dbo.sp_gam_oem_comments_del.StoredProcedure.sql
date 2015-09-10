USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_oem_comments_del]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_gam_oem_comments_del]
@comment_id int,@author nvarchar(100)
as 
	update gam_oem_comments set active=0 where comment_id=@comment_id and author=@author and active=1

GO
