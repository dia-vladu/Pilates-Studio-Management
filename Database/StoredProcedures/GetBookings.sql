CREATE PROCEDURE GetBookings
AS
BEGIN
    SELECT 
        b.Id AS BookingId,
        m.Name AS MemberName,
        c.Name AS ClassName,
        t.Name AS TrainerName,
        sc.StartTime AS DateTime
    FROM Bookings b
    INNER JOIN Members m ON b.MemberId = m.Id
    INNER JOIN ScheduledClasses sc ON b.ScheduledClassId = sc.Id
    INNER JOIN Classes c ON sc.ClassId = c.Id
    INNER JOIN Trainers t ON sc.TrainerId = t.Id
    ORDER BY sc.StartTime ASC
END