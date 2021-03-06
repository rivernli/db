USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[QuotationUploadFile_sp_Insert_Quotation_List]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[QuotationUploadFile_sp_Insert_Quotation_List] 	
		   @Lsh varchar(20),
		   @FileName NVARCHAR(50),
		   @NewName varchar(20),
		   @Uploaded NVARCHAR(50)
           
AS

INSERT INTO [Quotation_List]
           ([Lsh]
           ,[FileName]
           ,[NewName]
           ,[Uploaded]
           )
     VALUES
           (
           @Lsh,
           @FileName,
           @NewName,
           @Uploaded 
           )
GO
