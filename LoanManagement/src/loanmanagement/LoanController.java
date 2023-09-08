package loanmanagement;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
		ln.setAnnualincome(loan.getAnnualincome());
		ln.setDisposalincome(loan.getDisposalincome());
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

		if (!loanServ.verifyCredentials(cred.getUser(), cred.getPassword())) {

			System.out.println("!");
			return "adminlogin";
		} else {
			System.out.println("!else");
			if ("admin".equals(loanServ.verifyuser(cred.getUser(), cred.getPassword()))) {
				return "loanmanagement";
			} else {

				return "userloanmangement";
			}

		}

	}

	@RequestMapping(value = "/applications", method = RequestMethod.GET)
	public String applicants(Model mod) {

		mod.addAttribute("applications", loanServ.getAllApplication());
		return "applications";
	}

	@RequestMapping(value = "/oneapplicant", method = RequestMethod.GET)
	public String applicationToView(@RequestParam("applicant") String appid, Model mod) {

		int id = Integer.parseInt(appid);
		mod.addAttribute("applicant", loanServ.getLoanApplicant(id));
		return "oneapplicant";
	}

	@RequestMapping(value = "/updateapplication", method = RequestMethod.GET)
	public String updateApplication(@RequestParam("status") String status, @RequestParam("applicantid") int id,
			Model mod) {

		loanServ.updateApplication(status, id);
		mod.addAttribute("applications", loanServ.getAllApplication());
		return "applications";
	}

	@RequestMapping(value = "/generateexcel", method = RequestMethod.GET)
	public void ExcelDownload(HttpServletResponse response) throws Exception {

		Workbook workbook = ExcelGenerator.createExcel(loanServ.getAllApplication());

		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=loan_applicants.xlsx");
		workbook.write(response.getOutputStream());
		workbook.close();
	}

	@RequestMapping(value = "/namefilter", method = RequestMethod.GET)
	public String namefilter(@RequestParam("status") String status, @RequestParam("applicantid") int id, Model mod) {

		loanServ.updateApplication(status, id);
		mod.addAttribute("applications", loanServ.getAllApplication());
		return "applications";
	}

}
