CREATE OR REPLACE PROCEDURE InsertEnroll(sStudentId IN VARCHAR2,
	sCourseId IN VARCHAR2, nCourseIdNo IN NUMBER, result OUT VARCHAR2)
IS
	too_many_sumCourseUnit EXCEPTION;
	duplicate_courses EXCEPTION;
	too_many_students EXCEPTION;
	duplicate_time EXCEPTION;
	nYear NUMBER;
	nSemester NUMBER;
	nSumCourseUnit NUMBER;
	nCourseUnit NUMBER;
	nCnt NUMBER;
	nTeachMax NUMBER;
BEGIN
	result := '';
	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId || '���� �����ȣ ' || sCourseId ||
	', �й� ' || TO_CHAR(nCourseIdNo) || '�� ���� ����� ��û�Ͽ����ϴ�.');
	
	/* �⵵, �б� �˾Ƴ��� */
	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);

	/* ���� ó�� 1 : �ִ����� �ʰ����� */
	SELECT SUM(c.c_unit)
	INTO nSumCourseUnit
	FROM course c, enroll e
	WHERE e.s_id = sStudentId and e.e_year = nYear and
		e.e_semester = nSemester and e.c_id = c.c_id and e.c_id_no = c.c_id_no;
		
	SELECT c_unit
	INTO nCourseUnit
	FROM course
	WHERE c_id = sCourseId and c_id_no = nCourseIdNo;
	
	IF (nSumCourseUnit + nCourseUnit > 18)
	THEN
	RAISE too_many_sumCourseUnit;
	END IF;
	
	/* ���� ó�� 2 : ������ ���� ��û ���� */
	SELECT COUNT(*)
	INTO nCnt
	FROM enroll
	WHERE s_id = sStudentId and c_id = sCourseId and e_year = nYear and e_semester = nSemester ;
	IF (nCnt > 0) THEN
		RAISE duplicate_courses;
	END IF;
		
	/* ���� ó�� 3 : ������û �ο� �ʰ� ���� */
	SELECT t_max
	INTO nTeachMax
	FROM teach
	WHERE t_year= nYear and t_semester = nSemester
	and c_id = sCourseId and c_id_no= nCourseIdNo;
	
	SELECT COUNT(*)
	INTO nCnt
	FROM enroll
	WHERE e_year = nYear and e_semester = nSemester
	and c_id = sCourseId and c_id_no = nCourseIdNo;
	IF (nCnt >= nTeachMax) THEN
		RAISE too_many_students;
	END IF;
	
	/* ���� ó�� 4 : ��û�� ����� �ð� �ߺ� ���� */
	SELECT COUNT(*)
	INTO nCnt
	FROM
	(
	SELECT t_day, t_time
	FROM teach
	WHERE t_year=nYear and t_semester = nSemester and
	c_id = sCourseId and c_id_no = nCourseIdNo
	INTERSECT
	SELECT t_day, t.t_time
	FROM teach t, enroll e
	WHERE e.s_id=sStudentId and e.e_year=nYear and e.e_semester = nSemester
	and t.t_year=nYear and t.t_semester = nSemester and	e.c_id=t.c_id and e.c_id_no=t.c_id_no);
	IF (nCnt > 0) THEN
		RAISE duplicate_time;
	END IF;
	
	/* ���� ��û ��� */	
	INSERT INTO enroll(s_id, c_id, c_id_no, e_year, e_semester) 
	VALUES (sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);
	COMMIT;
	result := '������û ����� �Ϸ�Ǿ����ϴ�.';
	EXCEPTION
	WHEN too_many_sumCourseUnit THEN
		result := '�ִ������� �ʰ��Ͽ����ϴ�';
	WHEN duplicate_courses THEN
		result := '�̹� ��ϵ� ������ ��û�Ͽ����ϴ�';
	WHEN too_many_students THEN
		result := '������û �ο��� �ʰ��Ǿ� ����� �Ұ����մϴ�';
	WHEN duplicate_time THEN
		result := '�̹� ��ϵ� ���� �� �ߺ��Ǵ� �ð��� �����մϴ�';
	WHEN OTHERS THEN
		ROLLBACK;
	result := SQLCODE;
END;
/