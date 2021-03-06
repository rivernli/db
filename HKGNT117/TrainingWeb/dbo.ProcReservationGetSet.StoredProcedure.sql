USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcReservationGetSet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-30 16:35
-- Description:	分页，获取指开头行编和条数的培训室预订列表
-- =============================================
create PROCEDURE [dbo].[ProcReservationGetSet]
@Pid int,
@num int

AS
BEGIN
    SELECT  TOP(@num) *
    FROM     ReservationTable 
    where    ID<=(SELECT min(ID) FROM (SELECT Top(@Pid)ID FROM ReservationTable order by ID desc)as   tblTmp)
    order by ID desc 
	
	
	  
	
END

GO
