package loanmanagement;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public class LoanDAO implements LoanDAOContractor {

	@PersistenceContext
	private EntityManager emt;

	public void addCustomer(LoanCustomer loanc) {
		emt.persist(loanc);
	}

	public List<Loan> findAll() {
		return emt.createQuery("SELECT e FROM Loan e").getResultList();
	}

	@Override
	public void addApplication(LoanApplication loanc) {

		emt.persist(loanc);
	}

	@Override
	public void addNominee(Nominee nomine) {
		emt.persist(nomine);
	}

	@Override
	public List<Credentials> getAllCredentials() {

		return emt.createQuery("select user from Credentials user").getResultList();
	}

	@Override
	public void addLoan(Loan ln) {
		emt.persist(ln);

	}

	@Override
	public List<LoanCustomer> getAllCustomers() {

		return emt.createQuery("select cust from LoanCustomer cust").getResultList();
	}

}
