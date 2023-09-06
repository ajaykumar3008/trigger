package loanmanagement;

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

	@RequestMapping(value = "/loan", method = RequestMethod.GET)
	public String applyLoan(LoanCustomer cust, Model mod) {

		mod.addAttribute("customer", cust);
		System.out.println(cust.getCust_address());
		return "loan";
	}

	@RequestMapping(value = "/nominee", method = RequestMethod.GET)
	public String nominee(LoanApplication la) {

		System.out.println(la);
		// mod.addAttribute("customer", cust);

		return "preview";
	}
}
