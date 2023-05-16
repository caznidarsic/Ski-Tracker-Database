DELIMITER //
CREATE PROCEDURE add_ski_instance (_Date_Time DATETIME, _Skier_Id INT, _Trail_Id INT)
BEGIN
INSERT INTO SKI (Date_Time, SKIER_Skier_Id, TRAIL_Trail_Id)
VALUES (_Date_Time, _Skier_Id, _Trail_Id);
END ;


DELIMITER //
CREATE PROCEDURE add_ride_instance (_Date_Time DATETIME, _Skier_Id INT, _Chairlift_Id INT)
BEGIN
INSERT INTO RIDE (Date_Time, SKIER_Skier_Id, CHAIRLIFT_Chairlift_Id)
VALUES (_Date_Time, _Skier_Id, _Chairlift_Id);
END ;


DELIMITER //
CREATE PROCEDURE create_new_skier (_Fname VARCHAR(45), _Lname VARCHAR(45), _Email VARCHAR(45), _Password BINARY(45))
BEGIN
INSERT INTO SKIER (Fname, Lname, Email, Password)
VALUES (_Fname, _Lname, _Email, _Password);
END ;
