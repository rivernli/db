USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[UMS_Insert_DocRecord]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[UMS_Insert_DocRecord] 			
		@Doc_Name NVarChar(200),	
		@New_Name NVARCHAR(50),
		@Doc_Text NVarChar(MAX),
		@DocTextString NVarChar(MAX),
		@Doc_Dir NVARCHAR(50),
		@Uploaded NVARCHAR(50)
		
AS

	INSERT INTO UMS_DocRecord (Doc_Name, NewName, Doc_Text, DocTextString, Doc_Dir, Uploaded)
				VALUES(@Doc_Name, @New_Name, @Doc_Text, @DocTextString, @Doc_Dir, @Uploaded) 	



GO
