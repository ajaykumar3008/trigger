package loanmanagement;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "loancustomers")
@Entity
public class LoanCustomer {

	@Id
	String cust_firstname;
	String cust_lastname;
	String cust_dob;
	String cust_panno;
	int cust_mobile;
	String cust_address;
	String cust_gname;

	public LoanCustomer() {

	}

	public LoanCustomer(String cust_firstname, String cust_lastname, String cust_dob, String cust_panno,
			int cust_mobile, String cust_address, String cust_gname) {
		this.cust_firstname = cust_firstname;
		this.cust_lastname = cust_lastname;
		this.cust_dob = cust_dob;
		this.cust_panno = cust_panno;
		this.cust_mobile = cust_mobile;
		this.cust_address = cust_address;
		this.cust_gname = cust_gname;
	}

	public String getCust_firstname() {
		return cust_firstname;
	}

	public String getCust_lastname() {
		return cust_lastname;
	}

	public String getCust_dob() {
		return cust_dob;
	}

	public String getCust_panno() {
		return cust_panno;
	}

	public int getCust_mobile() {
		return cust_mobile;
	}

	public String getCust_address() {
		return cust_address;
	}

	public String getCust_gname() {
		return cust_gname;
	}

	public void setCust_firstname(String cust_firstname) {
		this.cust_firstname = cust_firstname;
	}

	public void setCust_lastname(String cust_lastname) {
		this.cust_lastname = cust_lastname;
	}

	public void setCust_dob(String cust_dob) {
		this.cust_dob = cust_dob;
	}

	public void setCust_panno(String cust_panno) {
		this.cust_panno = cust_panno;
	}

	public void setCust_mobile(int cust_mobile) {
		this.cust_mobile = cust_mobile;
	}

	public void setCust_address(String cust_address) {
		this.cust_address = cust_address;
	}

	public void setCust_gname(String cust_gname) {
		this.cust_gname = cust_gname;
	}

}