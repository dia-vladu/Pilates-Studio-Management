CREATE PROCEDURE GetScheduledClasses
AS
BEGIN
    SELECT 
        sc.Id AS ScheduledClassId,
        c.Name AS ClassName,
        t.Name AS TrainerName,
        sc.StartTime AS StartsAt,
        c.DurationMinutes AS Duration,
        sc.MaxCapacity,
        sc.SoldOut
    FROM ScheduledClasses sc
    INNER JOIN Classes c ON sc.ClassId = c.Id
    INNER JOIN Trainers t ON sc.TrainerId = t.Id
    ORDER BY sc.StartTime;
END