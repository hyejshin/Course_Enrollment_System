CREATE OR REPLACE PROCEDURE SelectTimeTable(sStudentId IN VARCHAR2, 
nYear IN NUMBER, nSemester IN NUMBER)
IS
CURSOR enroll_classes IS SELECT c_id, c_id_no FROM enroll 
where s_id = sStudentId and e_year = nYear and e_semester = nSemester;
time teach.t_time%TYPE;
name course.c_name%TYPE;
unit course.c_unit%TYPE;
room course.c_room%TYPE;
BEGIN
FOR class IN enroll_classes LOOP
SELECT c_name, c_unit, c_room INTO name, unit, room FROM course 
WHERE c_id = class.c_id and c_id_no = class.c_id_no;
SELECT t_time INTO time FROM teach WHERE c_id = class.c_id 
and c_id_no = class.c_id_no;
DBMS_OUTPUT.PUT_LINE(time || '교시, 과목번호:' || class.c_id || ', ' 
|| name || class.c_id_no || ', ' || unit || '학점, '|| room);
END LOOP;
END;
/