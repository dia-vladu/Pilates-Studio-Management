CREATE TABLE [dbo].[Trainers] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [Name]      VARCHAR (50)  NOT NULL,
    [Specialty] VARCHAR (100) NULL,
    [Phone]     VARCHAR (20)  NULL,
    [Email]     VARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC)
);