USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_oem_comments_set]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_gam_oem_comments_set]
@oem_id int, @comments nvarchar(500),@author nvarchar(50)

as 
insert into gam_oem_comments (oem_id,comment,author) values (@oem_id,@comments,@author)

GO
