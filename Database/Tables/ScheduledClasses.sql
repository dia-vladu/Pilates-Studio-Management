CREATE TABLE [dbo].[ScheduledClasses] (
    [Id]          INT      IDENTITY (1, 1) NOT NULL,
    [ClassId]     INT      NOT NULL,
    [TrainerId]   INT      NOT NULL,
    [StartTime]   DATETIME NOT NULL,
    [MaxCapacity] INT      NOT NULL,
    [SoldOut]     BIT      DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ScheduledClasses_Classes] FOREIGN KEY ([ClassId]) REFERENCES [dbo].[Classes] ([Id]),
    CONSTRAINT [FK_ScheduledClasses_Trainers] FOREIGN KEY ([TrainerId]) REFERENCES [dbo].[Trainers] ([Id]),
    CHECK ([MaxCapacity]>(0))
);