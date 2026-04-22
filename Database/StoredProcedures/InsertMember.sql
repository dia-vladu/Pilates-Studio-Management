CREATE PROCEDURE dbo.InsertMember
    @Name VARCHAR(50),
    @Phone VARCHAR(20),
    @Email VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [Members] ([Name], [Phone], [Email])
    VALUES (@Name, @Phone, @Email);
    -- JoinDate will use default GETDATE()
END