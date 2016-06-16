CREATE OR REPLACE TRIGGER BeforeUpdateProfessor BEFORE
	UPDATE ON professor
	FOR EACH ROW
	DECLARE
		underflow_length EXCEPTION;
		invalid_value EXCEPTION;
		nLength NUMBER;
		nBlank NUMBER;
	BEGIN
	/* 학년 제약조건 : DDL에서 해결 */
	/* 보다 복잡한 제약조건을 다루기 편하게 함 */
	/* 암호 제약조건 : 4자리 이상, blank는 허용안함 */
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
			(-20008, '암호는 4자리 이상이어야 합니다');
			WHEN invalid_value THEN
			RAISE_APPLICATION_ERROR
			(-20009, '암호에 공란은 입력되지 않습니다.');
END;
/