CREATE PROCEDURE GetWeeklyBookings
AS
BEGIN
    SET DATEFIRST 1;

    SELECT 
        DATEPART(WEEKDAY, sc.StartTime) AS DayNumber,
        COUNT(b.Id) AS TotalBookings
    FROM Bookings b
    INNER JOIN ScheduledClasses sc ON b.ScheduledClassId = sc.Id
    WHERE 
        sc.StartTime >= DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0)
        AND sc.StartTime < DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()) + 1, 0)
    GROUP BY DATEPART(WEEKDAY, sc.StartTime)
    ORDER BY DayNumber
END