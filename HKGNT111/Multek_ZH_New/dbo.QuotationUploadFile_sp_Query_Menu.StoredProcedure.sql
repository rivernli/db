USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[QuotationUploadFile_sp_Query_Menu]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[QuotationUploadFile_sp_Query_Menu]
AS

SET NOCOUNT ON

select * from QuotationUploadFile_Menu WHERE Modoul='Attachment'
GO
