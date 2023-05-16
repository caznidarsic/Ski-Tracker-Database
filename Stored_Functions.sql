DELIMITER //
CREATE FUNCTION get_num_runs (skierId INT, resortId INT, seasonName VARCHAR(45))
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE numRuns INT;
SELECT COUNT(*) INTO numRuns FROM (
SELECT * FROM SKI
WHERE SKIER_Skier_Id = skierId AND Date_Time BETWEEN 
(SELECT Start_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND
    (SELECT End_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND TRAIL_Trail_Id IN (SELECT Trail_Id FROM TRAIL WHERE RESORT_Resort_Id = resortId)
    ) skiInstances;
    RETURN numRuns;
END //


DELIMITER //
CREATE FUNCTION get_num_lifts (skierId INT, resortId INT, seasonName VARCHAR(45))
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE numLifts INT;
SELECT COUNT(*) INTO numLifts FROM (
SELECT * FROM RIDE
WHERE SKIER_Skier_Id = skierId AND Date_Time BETWEEN 
(SELECT Start_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND
    (SELECT End_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND CHAIRLIFT_Chairlift_Id IN (SELECT Chairlift_Id FROM CHAIRLIFT WHERE RESORT_Resort_Id = resortId)
    ) chairInstances;
    RETURN numLifts;
END //


DELIMITER //
CREATE FUNCTION get_num_awards (skierId INT, resortId INT, seasonName VARCHAR(45))
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE numAwards INT;
SELECT COUNT(*) INTO numAwards FROM (
SELECT * FROM EARN
WHERE SKIER_Skier_Id = skierId AND Date_Earned BETWEEN 
(SELECT Start_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND
    (SELECT End_Date FROM SEASON
    WHERE RESORT_Resort_Id = resortId AND Name = seasonName)
    AND AWARD_Award_Id IN (SELECT Award_Id FROM AWARD WHERE RESORT_Resort_Id = resortId)
    ) awardInstances;
    RETURN numAwards;
END //
