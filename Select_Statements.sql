DELIMITER //
CREATE PROCEDURE get_ski_by_resort_season (resortId INT, skierId INT, seasonName VARCHAR(45))
BEGIN
SELECT TRAIL.Name, SKI.Date_Time FROM SKI JOIN TRAIL ON SKI.TRAIL_Trail_Id = TRAIL.Trail_Id
WHERE SKI.Date_Time BETWEEN
    (SELECT Start_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND
    (SELECT End_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND
    SKI.SKIER_Skier_Id = skierId
    AND
    SKI.TRAIL_Trail_Id IN (SELECT Trail_Id FROM TRAIL WHERE RESORT_Resort_Id = resortId);
END ;

 


DELIMITER //
CREATE PROCEDURE get_ski_by_resort_day (resortId INT, skierId INT, date DATE)
BEGIN
SELECT TRAIL.Name, SKI.Date_Time FROM SKI JOIN TRAIL ON SKI.TRAIL_Trail_Id = TRAIL.Trail_Id
WHERE SKI.Date_Time = date
    AND
    SKI.SKIER_Skier_Id = skierId
    AND
    SKI.TRAIL_Trail_Id IN (SELECT Trail_Id FROM TRAIL WHERE RESORT_Resort_Id = resortId);
END ;

 


DELIMITER //
CREATE PROCEDURE get_ride_by_resort_day (resortId INT, skierId INT, date DATE)
BEGIN
SELECT CHAIRLIFT.Name, RIDE.Date_Time FROM RIDE JOIN CHAIRLIFT ON RIDE.CHAIRLIFT_Chairlift_Id = CHAIRLIFT.Chairlift_Id
WHERE RIDE.Date_Time = date
    AND
    RIDE.SKIER_Skier_Id = skierId
    AND
    RIDE.CHAIRLIFT_Chairlift_Id IN (SELECT Chairlift_Id FROM CHAIRLIFT WHERE RESORT_Resort_Id = resortId);
END ;

 


DELIMITER //
CREATE PROCEDURE get_runs_by_rating_and_season (resortId INT, skierId INT, rating VARCHAR(45), seasonName VARCHAR(45))
BEGIN
SELECT COUNT(*) FROM (
SELECT * FROM SKI JOIN TRAIL ON SKI.TRAIL_Trail_Id = TRAIL.Trail_Id
WHERE SKI.Date_Time BETWEEN
    (SELECT Start_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND
    (SELECT End_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND
    SKI.SKIER_Skier_Id = skierId
    AND
    SKI.TRAIL_Trail_Id IN (SELECT Trail_Id FROM TRAIL WHERE RESORT_Resort_Id = resortId)
    AND
    TRAIL.Rating = rating) greensSkied;
END ;

 


DELIMITER //
CREATE PROCEDURE get_skier_information (skierId INT)
BEGIN
SELECT Fname, Lname, Email
FROM SKIER
WHERE Skier_Id = skierId;
END ;

 


DELIMITER //
CREATE PROCEDURE get_earn_by_season (skierId INT, resortId INT, seasonName VARCHAR(45))
BEGIN
SELECT AWARD.Name, AWARD.Description, EARN.Date_Earned FROM EARN JOIN AWARD ON EARN.AWARD_Award_Id = AWARD.Award_Id
WHERE EARN.SKIER_Skier_Id = skierId AND EARN.Earned = TRUE AND EARN.Date_Earned BETWEEN 
(SELECT Start_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND
    (SELECT End_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND EARN.AWARD_Award_Id IN (SELECT Award_Id FROM AWARD WHERE RESORT_Resort_Id = resortId);
END ;

 


DELIMITER //
CREATE PROCEDURE get_chair_status_by_resort (resortId INT)
BEGIN
SELECT CHAIRLIFT.Name, CHAIR_STATUS.Description
FROM CHAIRLIFT JOIN CHAIR_STATUS ON CHAIRLIFT.CHAIR_STATUS_Status_Id = CHAIR_STATUS.Status_Id
WHERE RESORT_Resort_Id = resortId;
END ;

 

DELIMITER //
CREATE PROCEDURE get_resort_info (resortId INT)
BEGIN
SELECT RESORT.Name AS Resort_Name, CITY.Name AS City_Name, STATE.Name AS State_Name
FROM 
RESORT JOIN CITY ON RESORT.CITY_City_Id = CITY.City_Id
JOIN STATE ON CITY.STATE_State_Id = STATE.State_Id
WHERE RESORT.Resort_Id = resortId;
END ;
