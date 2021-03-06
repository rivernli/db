USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp__m6_buildAllCanBuyRecords]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
select isnull(b.G7_1_count,0)as G71
,a.* from #m6date as a
left join (select date,count(number) as G7_1_count from v__m6  where G7=1 group by date) as b
on a.date =b.date
*/

CREATE procedure [dbo].[sp__m6_buildAllCanBuyRecords] @b10 bit=1
as
--declare @b10 bit
--set @b10 =  1
declare @m1 int, @m2 int,@m3 int,@m4 int, @m5 int, @m6 int, @m7 int, @m8 int, @m9 int,@m10 int
set nocount on
truncate table m6_got10
if @b10 =1
begin
	select @m1=0
	while @m1<49
	begin
		select @m1=@m1+1,@m2=@m1
		while @m2<49
		begin
			select @m2=@m2+1,@m3=@m2
			while @m3<49
			begin
				select @m3=@m3+1,@m4=@m3
				while @m4<49
				begin
					select @m4=@m4+1,@m5=@m4
					while @m5<59
					begin
						select @m5=@m5+1,@m6=@m5
						while @m6<49
						begin
							select @m6=@m6+1,@m7=@m6
							while @m7<49
							begin
								select @m7=@m7+1,@m8=@m7
								while @m8<49
								begin
									select @m8=@m8+1,@m9=@m8
									while @m9<49
									begin
										select @m9=@m9+1,@m10=@m9
										while @m10<49
										begin
											select  @m10=@m10+1
											insert into m6_got10 (m1,m2,m3,m4,m5,m6,m7,m8,m9,m10) values (@m1,@m2,@m3,@m4,@m5,@m6,@m7,@m8,@m9,@m10)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
else
begin
	select @m1=0
	while @m1<49
	begin
		select @m1=@m1+1,@m2=@m1
		while @m2<49
		begin
			select @m2=@m2+1,@m3=@m2
			while @m3<49
			begin
				select @m3=@m3+1,@m4=@m3
				if(@m1+1=@m2 and @m2+1=@m3)
					select @m3=@m3+1,@m4=@m3
				while @m4<49
				begin
					select @m4=@m4+1,@m5=@m4
					if(@m2+1=@m3 and @m3+1=@m4)
						select @m4=@m4+1,@m5=@m4
					while @m5<59
					begin
						select @m5=@m5+1,@m6=@m5
						if(@m3+1=@m4 and @m4+1=@m5)
							select @m5=@m5+1,@m6=@m5
						while @m6<49
						begin
							select  @m6=@m6+1
							if(@m4+1=@m5 and @m5+1=@m6)
								select  @m6=@m6+1
							insert into m6_got10 (m1,m2,m3,m4,m5,m6,m7,m8,m9,m10) values (@m1,@m2,@m3,@m4,@m5,@m6,0,0,0,0)
						end
					end
				end
			end
		end
	end
end
set nocount off
GO
