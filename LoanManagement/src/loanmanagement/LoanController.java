package loanmanagement;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoanController {

	LoanService loanServ;

	@Autowired
	LoanController(LoanService loanServ) {
		this.loanServ = loanServ;
	}

	@RequestMapping(value = "/customer", method = RequestMethod.GET)
	public String customer() {

		return "customer";
	}

	@RequestMapping(value = "/applicant", method = RequestMethod.GET)
	public String nominee(LoanCustomer customer, HttpSession ses) {

		ses.setAttribute("customer", customer);

		return "customer";
	}

	@RequestMapping(value = "/loan", method = RequestMethod.GET)
	public String loan(LoanApplication loanForm, HttpSession ses) {

		ses.setAttribute("loan", loanForm);

		return "customer";
	}

	@RequestMapping(value = "/nominee", method = RequestMethod.GET)
	public String nominee(Nominee nomine, HttpSession ses) {

		LoanCustomer application = (LoanCustomer) ses.getAttribute("customer");
		LoanApplication loan = (LoanApplication) ses.getAttribute("loan");
		loanServ.addCustomer(application);
		Loan ln = new Loan();
		ln.setCustomerid(loanServ.getAllCustomers());
		ln.setApplicationdate(loan.getApplicationDate().toString());
		ln.setLoantype(loan.getLoanTypeID());
		ln.setAmountreq(loan.getAmountRequired());
		ln.setMonthsreq(loan.getMonthsRequired());
		loanServ.addLoan(ln);
		loanServ.addNominee(nomine);
		return "home";

	}

	@RequestMapping(value = "/adminlogin", method = RequestMethod.GET)
	public String adminlogin() {

		return "adminlogin";
	}

	@RequestMapping(value = "/verify", method = RequestMethod.GET)
	public String verify(Credentials cred) {

		if (loanServ.verifyCredentials(cred.getUser(), cred.getPassword())) {

			return "loanmanagement";
		}

		return "adminlogin";
	}

	@RequestMapping(value = "/applications", method = RequestMethod.GET)
	public String applicants(Model mod) {

		System.out.println("ghdas");
		mod.addAttribute("applications", loanServ.getAllApplication());
		return "applications";
	}

}
