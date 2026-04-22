CREATE PROCEDURE GetScheduledClassesByDate
    @TargetDate DATE
AS
BEGIN
    SELECT 
        sc.Id AS ScheduledClassId,
        c.Name + ' with ' + t.Name AS DisplayName
    FROM ScheduledClasses sc
    INNER JOIN Classes c ON sc.ClassId = c.Id
    INNER JOIN Trainers t ON sc.TrainerId = t.Id
    WHERE CAST(sc.StartTime AS DATE) = @TargetDate  
      AND sc.SoldOut = 0
	  AND sc.StartTime >= GETDATE()
    ORDER BY sc.StartTime;
END