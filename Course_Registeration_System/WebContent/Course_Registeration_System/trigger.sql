CREATE OR REPLACE TRIGGER BeforeUpdateStudent
BEFORE UPDATE ON student
FOR EACH ROW

DECLARE
underflow_length EXCEPTION;
invalid_value EXCEPTION;
nLength NUMBER;
nBlank NUMBER;

BEGIN
nLength := LENGTH(:new.s_pwd);
IF nLength < 4 THEN
DBMS_OUTPUT.PUT_LINE('암호는 4자리 이상이어야 합니다.');
RAISE underflow_length;
END IF;
nBlank := INSTR(:new.s_pwd, ' ', 1, 1);
IF nBlank != 0 THEN
DBMS_OUTPUT.PUT_LINE('암호에 공란은 입력되지 않습니다.');
RAISE invalid_value;
END IF;

EXCEPTION
WHEN underflow_length THEN
RAISE_APPLICATION_ERROR(-20002, '암호는 4자리 이상이어야 합니다.');
WHEN invalid_value THEN
RAISE_APPLICATION_ERROR(-20003, '암호에 공란은 입력되지 않습니다.');
END;
/