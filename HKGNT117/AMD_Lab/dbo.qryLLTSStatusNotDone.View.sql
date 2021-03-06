USE [AMD_Lab]
GO
/****** Object:  View [dbo].[qryLLTSStatusNotDone]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[qryLLTSStatusNotDone]
as
SELECT tblLLTSLog.Equipment, tblLLTSLog.TN, tblAMDSamples.Applicant, 
(select location from tbllocation where tbllocation.locationID=tblAMDSamples.location) as locationname, 
(select Analyst from tblAnalyst where tblAnalyst.AnalystID=tblAMDSamples.Analyst) as Analystname,
 tblAMDSamples.Dept, tblAMDSamples.ProjectName, tblAMDSamples.[Sample descripton], tblAMDSamples.ProjDesc, tblLLTSLog.wt, 
tblLLTSLog.days, tblAMDSamples.Customer, tblAMDSamples.[Project#], tblLLTSLog.Notes, tblLLTSLog.LowT, 
tblLLTSLog.HiT, tblLLTSLog.LowDwell, tblLLTSLog.HiDwell, tblLLTSLog.Xtime, 
CONVERT(varchar(20),tblLLTSLog.CyclesDone)+'/'+CONVERT(varchar(20),tblLLTSLog.TotalCycles) as CyclesValue,
tblLLTSLog.Status, 
convert(varchar(12),tblLLTSLog.DateReceived,101) as DateReceived,
convert(varchar(12),tblLLTSLog.DueDate,101) as DueDate, 
convert(varchar(12),tblLLTSLog.StartDate,101) as StartDate, 
convert(varchar(12),tblLLTSLog.FinishDate,101) as FinishDate 
 FROM tblAMDSamples INNER JOIN tblLLTSLog ON tblAMDSamples.TN = tblLLTSLog.TN
WHERE (((tblLLTSLog.Status)<>1 And (tblLLTSLog.Status)<>19)) OR (((tblLLTSLog.Status) Is Null))

GO
