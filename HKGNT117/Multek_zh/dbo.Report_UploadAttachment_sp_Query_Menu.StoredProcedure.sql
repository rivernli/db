USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Report_UploadAttachment_sp_Query_Menu]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Report_UploadAttachment_sp_Query_Menu]
AS

SET NOCOUNT ON

select * from Report_UploadAttachment_Menu WHERE Modoul='Attachment'








GO
