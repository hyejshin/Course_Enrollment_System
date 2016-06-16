CREATE OR REPLACE TRIGGER BeforeUpdateProfessor BEFORE
	UPDATE ON professor
	FOR EACH ROW
	DECLARE
		underflow_length EXCEPTION;
		invalid_value EXCEPTION;
		nLength NUMBER;
		nBlank NUMBER;
	BEGIN
	/* �г� �������� : DDL���� �ذ� */
	/* ���� ������ ���������� �ٷ�� ���ϰ� �� */
	/* ��ȣ �������� : 4�ڸ� �̻�, blank�� ������ */
		SELECT length(:new.p_pwd), instr(:new.p_pwd,' ')
		INTO nLength, nBlank
		FROM DUAL;

		IF (nLength < 4) THEN
			RAISE underflow_length;
		ELSIF (nBlank > 0) THEN
			RAISE invalid_value;
		END IF;
		EXCEPTION
			WHEN underflow_length THEN
			RAISE_APPLICATION_ERROR
			(-20008, '��ȣ�� 4�ڸ� �̻��̾�� �մϴ�');
			WHEN invalid_value THEN
			RAISE_APPLICATION_ERROR
			(-20009, '��ȣ�� ������ �Էµ��� �ʽ��ϴ�.');
END;
/