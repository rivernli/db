USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_GetNewNo]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SQM_sp_GetNewNo]
(
        @ModuleName NVARCHAR(50),
		@KeyName NVARCHAR(50),
		@totalWidth INT,
		@PadChar VARCHAR(5),
        @NewNo nvarchar(50) output
)
as
begin

		DECLARE @Lsh NVARCHAR(50) 
		SELECT @Lsh=Lsh FROM SQM_Ts_Lsh WHERE ModuleName = @ModuleName AND KeyName = @KeyName 

       IF @Lsh=''
		BEGIN
			INSERT INTO SQM_Ts_Lsh(ModuleName, KeyName, Lsh) VALUES (@ModuleName, @KeyName, 1)
			SET @NewNo =@KeyName+dbo.SQM_fun_PadLeft('1',@PadChar,@totalWidth)
		END
	ELSE 
		BEGIN
			SET @NewNo = @KeyName+dbo.SQM_fun_PadLeft(@Lsh,@PadChar,@totalWidth)
		END
end
GO
