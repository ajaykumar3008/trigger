package loanmanagement;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoanService {

	LoanDAOContractor loanDAO;

	@Autowired
	LoanService(LoanDAOContractor loan) {

		this.loanDAO = loan;
	}

	@Transactional
	public void addCustomer(LoanCustomer lc) {
		loanDAO.addCustomer(lc);
	}

	@Transactional
	public void addApplication(LoanApplication loan) {
		loanDAO.addApplication(loan);
	}

	@Transactional
	public void addNominee(Nominee nomine) {
		loanDAO.addNominee(nomine);
	}

	@Transactional
	public boolean verifyCredentials(String user, String password) {

		List<Credentials> ls = loanDAO.getAllCredentials();
		boolean check = false;
		for (Credentials c : ls) {
			if (c.getUser().equals(user) && c.getPassword().equals(password)) {
				check = true;
				break;
			}
		}

		return check;
	}

	public List<Loan> getAllApplication() {

		return loanDAO.findAll();
	}

	@Transactional
	public void addLoan(Loan ln) {
		loanDAO.addLoan(ln);
	}

	public int getAllCustomers() {

		List<LoanCustomer> ls = loanDAO.getAllCustomers();

		return ls.size() - 1;
	}
}
