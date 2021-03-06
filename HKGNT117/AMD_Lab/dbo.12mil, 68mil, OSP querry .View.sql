USE [AMD_Lab]
GO
/****** Object:  View [dbo].[12mil, 68mil, OSP querry ]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[12mil, 68mil, OSP querry ] as 
SELECT tblISTConstruction.[Construction ID], tblISTConstruction.[# Layers], '' AS Expr1, tblISTConstruction.[Coupon thickness], tblISTConstruction.MaterialL, tblISTConstruction.Tg, tblISTConstruction.[Material Tg], tblISTConstruction.[Surface Finish], tblISTConstruction.[S1 Via type], tblISTResults.CouponID, tblISTResults.CouponName, tblISTResults.TN, tblISTResults.ConstName, tblISTResults.[Precondition Name], tblISTResults.[Cycling Name], tblISTResults.[P1 ohms prescreen], tblISTResults.[P2 ohms prescreen], tblISTResults.[S1 ohms prescreen], tblISTResults.[S2 ohms prescreen], tblISTResults.[Cyc com], tblISTResults.Status, tblISTConstruction.[S1 drill size], tblISTConstruction.[S2 Via type], tblISTConstruction.[S2 drill size]
FROM tblISTConstruction INNER JOIN tblISTResults ON tblISTConstruction.[Construction ID] = tblISTResults.ConstName;

GO
