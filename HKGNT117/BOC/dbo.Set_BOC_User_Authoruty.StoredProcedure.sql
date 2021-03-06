USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Set_BOC_User_Authoruty]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE proc [dbo].[Set_BOC_User_Authoruty]
@UserId			nvarchar(15),
@userName	nvarchar(50),
@Set_type	nvarchar(50),
@userAuthority		int,
@price_authority	int,
--@plant_2F	nvarchar(50),
--@plant_P1	nvarchar(50),
@plant_P2	nvarchar(50),
@plant_B3	nvarchar(50),
@plant_B4	nvarchar(50),
@plant_B5	nvarchar(50)
--@plant_B8	nvarchar(50),
--@plant_B12	nvarchar(50),
--@plant_HK	nvarchar(50)
AS
begin
	if @Set_type = 'delete'
		begin
			delete Authority_User where userid = @UserId
			delete Authority_Trend_Key_Plant where userid = @UserID
		end
	else
		begin
			if @Set_type = 'update'
				begin
					update Authority_User set role = @userAuthority,price = @price_authority,username = @username where userid = @UserId
				end
			if @Set_type = 'insert' and not exists (select * from Authority_User where userid = @UserId)
				begin
					insert into Authority_User values(@UserId,@username,@userAuthority,@price_authority)--1/22
				end
--			if @plant_2F = ''
--				delete Authority_Trend_Key_Plant where userid = @UserID and authority = '2F'
--			else
--				if not exists (select * from Authority_Trend_Key_Plant where userid = @UserID and authority = @plant_2F)
--					insert into Authority_Trend_Key_Plant (userid,authority) values (@UserId,@plant_2F)
--			if @plant_P1 = ''
--				delete Authority_Trend_Key_Plant where userid = @UserID and authority = 'P1'
--			else
--				if not exists (select * from Authority_Trend_Key_Plant where userid = @UserID and authority = @plant_P1)
--					insert into Authority_Trend_Key_Plant (userid,authority) values (@UserId,@plant_P1)
			if @plant_P2 = ''
				delete Authority_Trend_Key_Plant where userid = @UserID and authority = 'P2'
			else
				if  not exists (select * from Authority_Trend_Key_Plant where userid = @UserID and authority = @plant_P2)
					insert into Authority_Trend_Key_Plant (userid,authority) values (@UserId,@plant_P2)
			if @plant_B3 = ''
				delete Authority_Trend_Key_Plant where userid = @UserID and authority = 'B3'
			else
				if not exists (select * from Authority_Trend_Key_Plant where userid = @UserID and authority = @plant_B3)
				insert into Authority_Trend_Key_Plant (userid,authority) values (@UserId,@plant_B3)
			if @plant_B4 = ''
				delete Authority_Trend_Key_Plant where userid = @UserID and authority = 'B4'
			else
				if not exists (select * from Authority_Trend_Key_Plant where userid = @UserID and authority = @plant_B4)
				insert into Authority_Trend_Key_Plant (userid,authority) values (@UserId,@plant_B4)
			if @plant_B5 = ''
				delete Authority_Trend_Key_Plant where userid = @UserID and authority = 'B5'
			else
				if not exists (select * from Authority_Trend_Key_Plant where userid = @UserID and authority = @plant_B5)
					insert into Authority_Trend_Key_Plant (userid,authority) values (@UserId,@plant_B5)
--			if @plant_B8 = ''
--				delete Authority_Trend_Key_Plant where userid = @UserID and authority = 'B8'
--			else
--				if  not exists (select * from Authority_Trend_Key_Plant where userid = @UserID and authority = @plant_B8)
--					insert into Authority_Trend_Key_Plant (userid,authority) values (@UserId,@plant_B8)
--			if @plant_B12 = ''
--				delete Authority_Trend_Key_Plant where userid = @UserID and authority = 'B12'
--			else
--				if not exists (select * from Authority_Trend_Key_Plant where userid = @UserID and authority = @plant_B12)
--					insert into Authority_Trend_Key_Plant (userid,authority) values (@UserId,@plant_B12)
--			if @plant_HK = ''
--				delete Authority_Trend_Key_Plant where userid = @UserID and authority = 'HK'
--			else
--				if not exists (select * from Authority_Trend_Key_Plant where userid = @UserID and authority = @plant_HK)
--					insert into Authority_Trend_Key_Plant (userid,authority) values (@UserId,@plant_HK)
		end
end




GO
