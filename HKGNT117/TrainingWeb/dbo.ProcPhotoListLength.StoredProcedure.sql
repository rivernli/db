USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPhotoListLength]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-1027-1 18:12
-- Description:	获取分类的条数
-- =============================================
create PROCEDURE [dbo].[ProcPhotoListLength] 
	@nid int
AS
BEGIN
	Select count(*) from PhotoTable where nid=@nid
END

GO
