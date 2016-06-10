CREATE OR REPLACE PROCEDURE DeleteTeach(professorId IN VARCHAR2,
	courseId IN VARCHAR2, courseIdNo IN NUMBER, result OUT VARCHAR2)
IS
	student_already EXCEPTION;
	nYear NUMBER;
	nSemester NUMBER;
	student_count NUMBER;
BEGIN
	result := '';
	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(professorId || '교수님이 과목번호 ' || courseId ||
	', 분반 ' || TO_CHAR(courseIdNo) || '의 강좌 삭제를 요청하였습니다.');
	
	/* 년도, 학기 알아내기 */
	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);

	/* 등록한 학생이 이미 존재 */
	SELECT COUNT(*)
	INTO student_count
	FROM enroll
	WHERE c_id = courseId and c_id_no = courseIdNo  and
	 e_year = nYear and e_semester = nSemester;

	 IF (student_count > 0)
	THEN
		RAISE student_already;
	END IF;
	
	/* 강좌 삭제 */ 
	DBMS_OUTPUT.put_line('c_id: '||courseId || 'c_id: '||courseId 
	|| 'c_id_no: '||courseIdNo||'t_year: '||nYear||'t_semes: '||nSemester);
	
	Delete from teach where c_id = courseId and c_id_no = courseIdNo  and
	 t_year = nYear and t_semester = nSemester;
	COMMIT;
	result := '강좌가 삭제되었습니다.';

	EXCEPTION
	WHEN student_already THEN
		result := '강좌를 등록한 학생이 있어 삭제할 수 없습니다';
	WHEN OTHERS THEN
		ROLLBACK;
	result := SQLCODE;
END;
/

