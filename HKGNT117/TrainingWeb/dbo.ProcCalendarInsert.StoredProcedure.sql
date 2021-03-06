USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcCalendarInsert]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-26 20:28
-- Description:	增加日历
-- =============================================
CREATE PROCEDURE  [dbo].[ProcCalendarInsert]

@Title nvarchar(255),
@Start datetime,
@End datetime,
@ID int output
AS
BEGIN
	INSERT INTO CalendarTable(Title, [Start], [End])
VALUES     (@Title,@Start,@End)
       
    SET @ID= IDENT_CURRENT('CalendarTable')  ---返回自动编号的id 



END

GO
