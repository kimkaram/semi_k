package groupPay.model.vo;

public class GroupPay implements java.io.Serializable{
	private static final long SerialVersionUID = 64L;
	
	private String groupNo;
	private String account;
	private int price;
	private String selDay;
	private int memberCount;
	
	public GroupPay() {}

	public GroupPay(String groupNo, String account, int price, String selDay, int memberCount) {
		super();
		this.groupNo = groupNo;
		this.account = account;
		this.price = price;
		this.selDay = selDay;
		this.memberCount = memberCount;
	}

	public String getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(String groupNo) {
		this.groupNo = groupNo;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getSelDay() {
		return selDay;
	}

	public void setSelDay(String selDay) {
		this.selDay = selDay;
	}

	public int getMemberCount() {
		return memberCount;
	}

	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}

	public static long getSerialversionuid() {
		return SerialVersionUID;
	}

	@Override
	public String toString() {
		return groupNo + ", " + account + ", " + price + ", " + selDay + ", " + memberCount;
	}
	
	
	
}
