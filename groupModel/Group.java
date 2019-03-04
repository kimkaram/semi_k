package group.model.vo;

import java.sql.Date;

public class GroupMgt implements java.io.Serializable{

	private static final long SerialVersionUID = 999L;

	private String userId;
	private String groupNo;
	private Date groupEnrolltime;
	private String searchField; //검색 조건
	private String searchValue; //검색어

	public GroupMgt() {}

	public GroupMgt(String userId, String groupNo, Date groupEnrolltime) {
		super();
		this.userId = userId;
		this.groupNo = groupNo;
		this.groupEnrolltime = groupEnrolltime;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(String groupNo) {
		this.groupNo = groupNo;
	}

	public String getSearchField() {
		return searchField;
	}

	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public Date getGroupEnrolltime() {
		return groupEnrolltime;
	}

	public void setGroupEnrolltime(Date groupEnrolltime) {
		this.groupEnrolltime = groupEnrolltime;
	}

	public static long getSerialversionuid() {
		return SerialVersionUID;
	}

	@Override
	public String toString() {
		return userId + ", " + groupNo + ", " + groupEnrolltime;
	}


}
