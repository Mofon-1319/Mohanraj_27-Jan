CREATE TABLE User_Login_Table
(
UserId VARCHAR(30) NOT NULL PRIMARY KEY,
Password VARCHAR(10) NOT NULL
)
GO
DROP TABLE User_Login

SELECT * FROM User_Login_Table

INSERT INTO User_Login_Table(UserId,Password) VALUES ('divya','pras@123')
DELETE FROM User_Login_Table WHERE UserId = 'divya'

ALTER TRIGGER User_Trigger ON User_Login_Table
AFTER INSERT,DELETE
AS
BEGIN
INSERT INTO Trigger_Record(UserId,Message) 
Select i.UserId,'Inserted successfully'  From inserted i
Union All 
Select d.UserId,'Deleted Successfully' From deleted d
END

DROP TRIGGER User_Trigger

SELECT * FROM Trigger_Record
CREATE TABLE Trigger_Record
(
UserId VARCHAR(15),
Message VARCHAR(10),
CreatedAt DateTime Default CURRENT_TIMESTAMP
)
GO


CREATE VIEW User_View AS SELECT User_Login_Table.UserId,User_Login_Table.Password, Trigger_Record.Message FROM User_Login_Table,Trigger_Record
WHERE User_Login_Table.UserId = Trigger_Record.UserId

SELECT * FROM User_View