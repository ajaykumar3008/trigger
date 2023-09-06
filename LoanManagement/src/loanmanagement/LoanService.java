package loanmanagement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoanService {

	LoanDAOContractor loanDAO;

	@Autowired
	LoanService(LoanDAOContractor loan) {

		this.loanDAO = loan;
	}

	public void addCustomer(LoanCustomer lc) {
		loanDAO.persist(lc);
	}

}
