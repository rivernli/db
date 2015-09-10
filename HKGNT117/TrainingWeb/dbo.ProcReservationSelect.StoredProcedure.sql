USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcReservationSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-30 18:12
-- Description:	获取指定编号的培训室预订
-- =============================================
create PROCEDURE [dbo].[ProcReservationSelect]
@id int

AS
BEGIN

Select * from ReservationTable where [ID]=@id 

END

GO
