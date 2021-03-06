USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcReservationGetSetByViewed]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-30 16:50
-- Description:	分页，获取指开头行编和条数的培训室预订列表(是否已审批)
-- =============================================
create PROCEDURE [dbo].[ProcReservationGetSetByViewed]
@Pid int,
@num int,
@Viewed bit

AS
BEGIN
    SELECT  TOP(@num) *
    FROM     ReservationTable 
    where    Viewed=@Viewed  and ID<=
    (SELECT min(ID) FROM (SELECT Top(@Pid)ID FROM ReservationTable  where Viewed=@Viewed   order by ID desc)as   tblTmp)
    order by ID desc 
	
	
	  
	
END

GO
