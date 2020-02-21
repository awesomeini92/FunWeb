package comment;

import java.sql.Date;

public class commentBean {
	private int cmmnt_num;
	private int gllr_num;
	private String id;
	private String comment;
	private Date date;
	
	public int getCmmnt_num() {
		return cmmnt_num;
	}
	public void setCmmnt_num(int cmmt_num) {
		this.cmmnt_num = cmmt_num;
	}
	public int getGllr_num() {
		return gllr_num;
	}
	public void setGllr_num(int gllr_num) {
		this.gllr_num = gllr_num;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
}
