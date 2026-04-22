CREATE TABLE [dbo].[Members] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Name]     VARCHAR (50)  NOT NULL,
    [Phone]    VARCHAR (20)  NOT NULL,
    [Email]    VARCHAR (100) NOT NULL,
    [JoinDate] DATE          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC)
);