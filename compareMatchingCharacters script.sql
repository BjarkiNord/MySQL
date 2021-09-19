-- Paste this into create function.
CREATE DEFINER=`root`@`localhost` FUNCTION `compareMatchingCharacters`(inputString1 varchar(52), inputString2 varchar(52)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE isMatching BOOLEAN;
	DECLARE inputStringCount, loopCount INT;
	SET inputStringCount = LENGTH(inputString1);
	SET isMatching = FALSE;
    SET loopCount = 0;
	myLoop: WHILE loopCount <= inputStringCount DO
		BEGIN
			-- IF SUBSTRING(inputString1,loopCount+1,1) REGEXP'[A-Za-z0-9]' THEN  -- Finere om jeg legger til - og ' i regexp
            IF SUBSTRING(inputString1,loopCount+1,1) != '' AND SUBSTRING(inputString1,loopCount+1,1) != ' ' THEN 
				BEGIN
					IF(POSITION(SUBSTRING(inputString1,loopCount+1,1) IN inputString2) != 0) THEN
						BEGIN
							SET isMatching = TRUE;
							LEAVE myLoop;
						END; 
					END IF;
				END;
			END IF;
			SET loopCount = loopCount + 1;
		END;
	END WHILE myLoop;
RETURN isMatching;
END