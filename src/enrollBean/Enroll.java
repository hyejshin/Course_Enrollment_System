package enrollBean;

public class Enroll {
	String c_id="", c_id_no="", c_name="", c_major="", p_id="", p_name="";
	String t_day="", t_time="", t_room="";
	int t_max=0, c_unit=0, studentNum=0;
	public static int totalEnrolledClass = 0;
	public static int totalEnrolledUnit = 0;
	 
	public Enroll(){
		
	}

	public String getC_id() {
		return c_id;
	}

	public void setC_id(String c_id) {
		this.c_id = c_id;
	}

	public String getC_id_no() {
		return c_id_no;
	}

	public void setC_id_no(String c_id_no) {
		this.c_id_no = c_id_no;
	}

	public String getC_name() {
		return c_name;
	}

	public void setC_name(String c_name) {
		this.c_name = c_name;
	}

	public String getC_major() {
		return c_major;
	}

	public void setC_major(String c_major) {
		this.c_major = c_major;
	}

	public String getP_id() {
		return p_id;
	}

	public void setP_id(String p_id) {
		this.p_id = p_id;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getT_day() {
		return t_day;
	}

	public void setT_day(String t_day) {
		this.t_day = t_day;
	}

	public String getT_time() {
		return t_time;
	}

	public void setT_time(String t_time) {
		this.t_time = t_time;
	}

	public String getT_room() {
		return t_room;
	}

	public void setT_room(String t_room) {
		this.t_room = t_room;
	}

	public int getT_max() {
		return t_max;
	}

	public void setT_max(int t_max) {
		this.t_max = t_max;
	}

	public int getC_unit() {
		return c_unit;
	}

	public void setC_unit(int c_unit) {
		this.c_unit = c_unit;
	}

	public int getStudentNum() {
		return studentNum;
	}

	public void setStudentNum(int studentNum) {
		this.studentNum = studentNum;
	}

}
