USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[SQM_fun__WorkDay]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--计算两个日期相差的工作天数   
  CREATE   FUNCTION   [dbo].[SQM_fun__WorkDay]
(   
  @dt_begin   datetime,     --计算的开始日期   
  @dt_end     datetime         --计算的结束日期   
 )RETURNS   int   
  AS
BEGIN   
  DECLARE   @workday   int,@i   int,@bz   bit,@dt   datetime   
  IF   @dt_begin>@dt_end   
  SELECT   @bz=1,@dt=@dt_begin,@dt_begin=@dt_end,@dt_end=@dt   
  ELSE   
  SET   @bz=0   
  SELECT   @i=DATEDIFF(Day,@dt_begin,@dt_end)+1,   
  @workday=@i/7*5,   
  @dt_begin=DATEADD(Day,@i/7*7,@dt_begin)   
  WHILE   @dt_begin<=@dt_end   
  BEGIN   
  SELECT   @workday=CASE     
  WHEN   (@@DATEFIRST+DATEPART(Weekday,@dt_begin)-1)%7   BETWEEN   1   AND   5   
  THEN   @workday+1   ELSE   @workday   END,   
  @dt_begin=@dt_begin+1   
	--print @workday
  END   
  RETURN(CASE   WHEN   @bz=1   THEN   -@workday   ELSE   @workday   END)   
	
  END

GO
