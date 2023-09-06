package loanmanagement;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public class LoanDAO implements LoanDAOContractor {

	@PersistenceContext
	private EntityManager emt;

	public void persist(LoanCustomer loanc) {
		emt.persist(loanc);
	}

	public List<LoanCustomer> findAll() {
		return emt.createQuery("SELECT e FROM Employee e").getResultList();
	}
}
