USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ProductNature_sp_Query_Menu]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[ProductNature_sp_Query_Menu]
AS

SET NOCOUNT ON

select * from ProductNature_Menu WHERE Modoul='Attachment'








GO
