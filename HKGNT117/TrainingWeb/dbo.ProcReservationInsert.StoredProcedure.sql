USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcReservationInsert]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-30 16:28
-- Description:	增加培训室预订
-- =============================================
create PROCEDURE  [dbo].[ProcReservationInsert]
@Use nvarchar(100),
@room nvarchar(50),
@Description nvarchar(300),
@IP nvarchar(50),
@Start datetime,
@End datetime,
@email nvarchar(50),
@ID int output
AS
BEGIN

   INSERT INTO ReservationTable
              ([Use], room, [Description], SubjectTime, IP, Start, email, [End], Reply, Viewed)
   VALUES     (@Use,@room,@Description,getdate(),@IP,@Start,@email,@End,0,0)
    

    select @@IDENTITY
       
    SET @ID= IDENT_CURRENT('ReservationTable')  ---返回自动编号的id 



END

GO
