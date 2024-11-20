package com.hit.srv;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/OtpVerifyServlet")
public class OtpVerifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public OtpVerifyServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String inputOtp = request.getParameter("otp").trim();  // OTP entered by the user
		Integer sessionOtp = (Integer) session.getAttribute("otp");  // OTP stored in session

		// Verify if the OTP matches the one stored in session
		if (sessionOtp != null && inputOtp.equals(sessionOtp.toString())) {
			// OTP is correct, redirect to vendorHome.jsp
			RequestDispatcher rd = request.getRequestDispatcher("vendorHome.jsp");
			rd.forward(request, response);
		} else {
			// OTP is incorrect, show error message and redirect to otpInput.jsp
			request.setAttribute("errorMessage", "Invalid OTP! Please try again.");
			RequestDispatcher rd = request.getRequestDispatcher("otpInput.jsp");
			rd.forward(request, response);
		}
	}
}
