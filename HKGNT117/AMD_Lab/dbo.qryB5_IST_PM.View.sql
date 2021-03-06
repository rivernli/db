USE [AMD_Lab]
GO
/****** Object:  View [dbo].[qryB5_IST_PM]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[qryB5_IST_PM]
as 
SELECT tblAMDSamples.location, tblAMDSamples.WkCat, tblAMDSamples.month, tblISTResults.TN, tblAMDSamples.year, 
tblISTConstruction.S2_thk, tblISTConstruction.S2_rough, tblISTConstruction.Pwr_crazing, tblISTConstruction.Sns_crazing, 
tblISTResults.ConstName, 
(select [Preconditioning Name] from tblISTPrecon where tblISTPrecon.PreconditioningID=tblISTResults.[Precondition Name]) as PreconditiongName,
(select [IST Cycling Name] from tblISTCycling where tblISTCycling.[ISTCyclingID]=tblISTResults.[Cycling Name]) as CyclingName,
tblISTResults.CouponName, 
(select LamSupplier+'-'+LamName from tblLaminateSpec where tblLaminateSpec.LamSpecID=tblISTConstruction.MaterialL) as Material,
tblISTResults.[S2 ohms prescreen], tblISTResults.[P2 ohms prescreen], 
tblISTConstruction.[Surface Finish], tblISTResults.[Cyc com], tblISTResults.[Type of failure], 
tblISTResults.[Precodition File name], tblISTResults.[Cycling Data File Name], tblISTResults.FA
FROM tblISTConstruction INNER JOIN (tblAMDSamples INNER JOIN tblISTResults ON tblAMDSamples.TN = tblISTResults.TN) 
ON tblISTConstruction.[Construction ID] = tblISTResults.ConstName
WHERE ((tblAMDSamples.location)=6) AND ((tblAMDSamples.WkCat)='Process Monitoring')
GO
