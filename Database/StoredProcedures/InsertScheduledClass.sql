CREATE PROCEDURE InsertScheduledClass
    @ClassId INT,
    @TrainerId INT,
    @StartTime DATETIME,
    @MaxCapacity INT
AS
BEGIN
    -- Optional: Validate max capacity
    IF @MaxCapacity <= 0
    BEGIN
        RAISERROR('MaxCapacity must be greater than 0', 16, 1)
        RETURN
    END

    -- Insert the scheduled class
    INSERT INTO ScheduledClasses (ClassId, TrainerId, StartTime, MaxCapacity, SoldOut)
    VALUES (@ClassId, @TrainerId, @StartTime, @MaxCapacity, 0)
END