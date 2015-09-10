USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcReservationDelete]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-6-30 10:50
-- Description:	删除培训室预定
-- =============================================
create PROCEDURE [dbo].[ProcReservationDelete]
@id int
AS
BEGIN
	Delete ReservationTable where ID=@id
	select @@rowcount
END

GO
