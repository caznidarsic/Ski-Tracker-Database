CREATE TRIGGER before_trail_insert BEFORE INSERT ON TRAIL
FOR EACH ROW
BEGIN
	IF NEW.Rating != 'Green' AND NEW.Rating != 'Blue' AND NEW.Rating != 'Black' AND NEW.Rating != 'Double Black'
	THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Cannot add or update row: only Green, Blue, Black and Double Black are allowed as rating values';
	END IF;
END;


DELIMITER //
CREATE TRIGGER before_skier_insert BEFORE INSERT ON SKIER
FOR EACH ROW
BEGIN
	IF (EXISTS (SELECT * FROM SKIER WHERE Email = NEW.Email))
	THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Cannot add or update row: user email already exists';
	END IF;
END;


DELIMITER //
CREATE TRIGGER before_earn_insert BEFORE INSERT ON EARN
FOR EACH ROW
BEGIN
	IF (EXISTS (SELECT * FROM EARN WHERE SKIER_Skier_Id = NEW.SKIER_Skier_Id AND AWARD_Award_Id = NEW.AWARD_Award_Id))
	THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Cannot add or update row: \'earn\' instance is already created for given skier and award';
	END IF;
END;
