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

		List<User> ls = loanDAO.getAllCredentials();
		System.out.println(ls.get(3).getPassword());
		boolean check = false;
		for (User c : ls) {
			if (c.getUsername().equals(user) && password.equals(c.getPassword())) {
				check = true;
				break;
			}
		}

		return check;
	}

	@Transactional
	public String verifyuser(String user, String password) {

		List<User> ls = loanDAO.getAllCredentials();
		String type = "";
		int id;
		for (User c : ls) {
			if (c.getUsername().equals(user) && password.equals(c.getPassword())) {
				id = c.getUserid();
				if ("admin".equals(c.getUsertype())) {
					type = "admin";
				} else {
					type = "user";
				}
				break;
			}
		}

		return type;
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

		return ls.size();
	}

	public Loan getLoanApplicant(int appid) {

		List<Loan> ls = loanDAO.findAll();
		Loan loan = new Loan();

		for (Loan ln : ls) {

			if (ln.getApplicantid() == appid) {
				loan = ln;
				break;
			}
		}
		return loan;
	}

	@Transactional
	public void updateApplication(String status, int id) {

		loanDAO.updateApplication(status, id);

	}
}
