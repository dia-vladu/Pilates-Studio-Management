CREATE TABLE [dbo].[Classes] (
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [Description]     VARCHAR (300) NULL,
    [DifficultyLevel] VARCHAR (20)  NULL,
    [DurationMinutes] INT           NULL,
    [Requirements]    VARCHAR (300) NULL,
    [Equipment]       VARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CHECK ([DifficultyLevel]='Advanced' OR [DifficultyLevel]='Intermediate' OR [DifficultyLevel]='Beginner')
);