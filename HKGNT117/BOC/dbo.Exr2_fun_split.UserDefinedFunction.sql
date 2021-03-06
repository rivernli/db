USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Exr2_fun_split]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   function   [dbo].[Exr2_fun_split](@c   varchar(max),@split   varchar(2))   
returns   @t   table(col   varchar(50))   
as   
    begin   
    -- 分割字符串
      while(charindex(@split,@c)<>0)   
        begin   
          insert   @t(col)   values   (substring(@c,1,charindex(@split,@c)-1))   
          set   @c   =   stuff(@c,1,charindex(@split,@c),'')   
        end   
      insert   @t(col)   values   (@c)   
      return   
    end   


GO
