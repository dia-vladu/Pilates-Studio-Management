CREATE TABLE [dbo].[Bookings] (
    [Id]               INT IDENTITY (1, 1) NOT NULL,
    [ScheduledClassId] INT NOT NULL,
    [MemberId]         INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([ScheduledClassId]) REFERENCES [dbo].[ScheduledClasses] ([Id]),
    FOREIGN KEY ([MemberId]) REFERENCES [dbo].[Members] ([Id])
);
