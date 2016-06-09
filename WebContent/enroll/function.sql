CREATE OR REPLACE FUNCTION Date2EnrollYear(dDate IN DATE)
	RETURN NUMBER
	IS 
	currentYear NUMBER;
	currentMonth NUMBER;
	year NUMBER;
	BEGIN
	SELECT to_number(to_char(dDate, 'YYYY')) INTO currentYear FROM DUAL;
	SELECT to_number(to_char(dDate, 'MM')) INTO currentMonth FROM DUAL;
	if currentMonth = 11 or currentMonth = 12 then
	   year := currentYear + 1;
	else
	   year := currentYear;
	end if;
	return year;
END;
/


CREATE OR REPLACE FUNCTION Date2EnrollSemester(dDate IN DATE)
	RETURN NUMBER
	IS
	currentMonth NUMBER;
	semester NUMBER;
	BEGIN
	SELECT to_number(to_char(dDate, 'MM')) INTO currentMonth FROM DUAL;
	if currentMonth >= 5 and currentMonth <= 10 then
	   semester := 2;
	else
	   semester := 1;
	end if;
	return semester;
END;
/