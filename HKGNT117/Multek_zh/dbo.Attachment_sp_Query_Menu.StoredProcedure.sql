USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Attachment_sp_Query_Menu]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Attachment_sp_Query_Menu]
AS

SET NOCOUNT ON

select * from Attachment_Menu WHERE Modoul='Attachment'







GO
