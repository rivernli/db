USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_Query_Menu]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[B1Parts_sp_Query_Menu]
AS

SET NOCOUNT ON

select * from B1Parts_Menu WHERE Modoul='Attachment'








GO
