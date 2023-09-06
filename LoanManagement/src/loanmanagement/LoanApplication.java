package loanmanagement;

public class LoanApplication {

	int customerID;
	String applicationDate;
	int loanTypeID;
	double amountRequired;
	int monthsRequired;

	public LoanApplication() {

	}

	public LoanApplication(int customerID, String applicationDate, int loanTypeID, double amountRequired,
			int monthsRequired) {

		this.customerID = customerID;
		this.applicationDate = applicationDate;
		this.loanTypeID = loanTypeID;
		this.amountRequired = amountRequired;

		this.monthsRequired = monthsRequired;
	}

	public int getCustomerID() {
		return customerID;
	}

	public String getApplicationDate() {
		return applicationDate;
	}

	public int getLoanTypeID() {
		return loanTypeID;
	}

	public double getAmountRequired() {
		return amountRequired;
	}

	public int getMonthsRequired() {
		return monthsRequired;
	}

	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}

	public void setApplicationDate(String applicationDate) {
		this.applicationDate = applicationDate;
	}

	public void setLoanTypeID(int loanTypeID) {
		this.loanTypeID = loanTypeID;
	}

	public void setAmountRequired(double amountRequired) {
		this.amountRequired = amountRequired;
	}

	public void setMonthsRequired(int monthsRequired) {
		this.monthsRequired = monthsRequired;
	}

}
