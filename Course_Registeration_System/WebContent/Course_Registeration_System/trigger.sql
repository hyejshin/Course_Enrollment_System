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
DBMS_OUTPUT.PUT_LINE('��ȣ�� 4�ڸ� �̻��̾�� �մϴ�.');
RAISE underflow_length;
END IF;
nBlank := INSTR(:new.s_pwd, ' ', 1, 1);
IF nBlank != 0 THEN
DBMS_OUTPUT.PUT_LINE('��ȣ�� ������ �Էµ��� �ʽ��ϴ�.');
RAISE invalid_value;
END IF;

EXCEPTION
WHEN underflow_length THEN
RAISE_APPLICATION_ERROR(-20002, '��ȣ�� 4�ڸ� �̻��̾�� �մϴ�.');
WHEN invalid_value THEN
RAISE_APPLICATION_ERROR(-20003, '��ȣ�� ������ �Էµ��� �ʽ��ϴ�.');
END;
/