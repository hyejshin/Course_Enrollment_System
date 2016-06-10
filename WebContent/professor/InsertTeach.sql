CREATE OR REPLACE PROCEDURE InsertTeach(professorId IN VARCHAR2,
	courseId IN VARCHAR2, courseIdNo IN NUMBER, tDay IN VARCHAR2, tTime IN VARCHAR2,
	tRoom IN VARCHAR2, tMax IN NUMBER, result OUT VARCHAR2)
IS
	course_already EXCEPTION;
	room_already EXCEPTION;
	nYear NUMBER;
	nSemester NUMBER;
	already_course_count NUMBER;
	already_room_count NUMBER;
BEGIN
	result := '';
	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(professorId || '교수님이 과목번호 ' || courseId ||
	', 분반 ' || TO_CHAR(courseIdNo) || '의 강좌 개설을 요청하였습니다.');
	
	/* 년도, 학기 알아내기 */
	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);

	/* 해당 분반 과목 이미 존재 */
	SELECT COUNT(*)
	INTO already_course_count
	FROM teach
	WHERE c_id = courseId and c_id_no = courseIdNo  and
	 t_year = nYear and t_semester = nSemester;

	 /* 해당 강의실 이미 수업 있음 */
	SELECT COUNT(*)
	INTO already_room_count
	FROM teach
	WHERE t_day = tDay and t_room = tRoom  and t_time = tTime and
	 t_year = nYear and t_semester = nSemester;

	 IF (already_course_count > 0)
	THEN
		RAISE course_already;
	END IF;

	IF (already_room_count > 0)
	THEN
		RAISE room_already;
	END IF;
	
	DBMS_OUTPUT.put_line('c_id: '||courseId || 'c_id: '||courseId 
	|| 'c_id_no: '||courseIdNo||'t_year: '||nYear||'t_semes: '||nSemester)

	/* 강좌 개설 */	
	INSERT INTO teach(p_id, c_id, c_id_no, t_year, t_semester, t_day, t_time, t_room, t_max) 
	VALUES (professorId, courseId, courseIdNo, nYear, nSemester, tDay, tTime, tRoom, tMax);
	COMMIT;
	result := '강좌 개설이 완료되었습니다.';

	EXCEPTION
	WHEN course_already THEN
		result := '해당 강좌가 이미 개설되어 있습니다';
	WHEN room_already THEN
		result := '해당 강의실에 이미 수업이 있습니다';
	WHEN OTHERS THEN
		ROLLBACK;
	result := SQLCODE;
END;
/

