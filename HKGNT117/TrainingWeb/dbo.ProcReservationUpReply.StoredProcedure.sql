USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcReservationUpReply]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-30 12:55
-- Description:	更新预订审批
-- =============================================
create PROCEDURE [dbo].[ProcReservationUpReply]
@id int,
@Reply bit
AS
BEGIN

	Update ReservationTable set  [Reply]=@Reply,[Viewed]=1    where [ID]=@id
	select @@rowcount

END

GO
