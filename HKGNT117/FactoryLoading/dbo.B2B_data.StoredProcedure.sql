USE [FactoryLoading]
GO
/****** Object:  StoredProcedure [dbo].[B2B_data]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[B2B_data]
@plnt char(2),
@fdate  nvarchar(30),
@tdate  nvarchar(30)
as
declare @Total float
declare @SMP float
declare @TTC float
declare @TCC float

select @Total = sum(T$amnt)  from TFSOLP106180 where T$DATE between  @fdate and @tdate and T$plnt = @plnt --and T$cotp = 'SLS'
select @SMP = sum(T$amnt)  from TFSOLP106180 where T$DATE between  @fdate and @tdate and T$plnt = @plnt  
									AND T$ITEM NOT LIKE 'H%'
									AND T$ITEM NOT LIKE 'F%'
									AND T$ITEM NOT LIKE 'Q%'
									AND T$ITEM NOT LIKE '7%'
									AND T$ITEM NOT LIKE '9%'
									AND T$ITEM NOT LIKE 'S%'
									AND T$ITEM NOT LIKE 'P%'
									
select  @TTC = sum(T$amnt) from TFSOLP106180 where T$DATE between  @fdate and @tdate and T$plnt = @plnt and left(T$item,3) = 'TTC'
select  @TCC = sum(T$amnt)  from TFSOLP106180 where T$DATE between  @fdate and @tdate and T$plnt = @plnt and left(T$item,3) = 'TCC'
select @Total as Total,isnull(@SMP,0) as SMP,isnull(@TTC,0) as TTC,isnull(@TCC,0) as TCC,@Total-isnull(@SMP,0) - isnull(@TTC,0)- isnull(@TCC,0) as FGout

GO
