<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
@media ( min-width : 1025px) {
	.h-custom {
		height: 100vh !important;
	}
}

.card-registration .select-input.form-control[readonly]:not([disabled])
	{
	font-size: 1rem;
	line-height: 2.15;
	padding-left: .75em;
	padding-right: .75em;
}

.card-registration .select-arrow {
	top: 13px;
}

.gradient-custom-2 {
	background: #3c455c;
	background: #fff;
	background: white;
}

.bg-indigo {
	background-color: #3c455c;
}

@media ( min-width : 992px) {
	.card-registration-2 .bg-indigo {
		border-top-right-radius: 15px;
		border-bottom-right-radius: 15px;
	}
}

@media ( max-width : 991px) {
	.card-registration-2 .bg-indigo {
		border-bottom-left-radius: 15px;
		border-bottom-right-radius: 15px;
	}
}

textarea {
	width: 100%;
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}
</style>
</head>
<body>
	<section class="h-100 h-custom gradient-custom-2">
		<div class="container py-5 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-12">
					<div class="card card-registration card-registration-2"
						style="border-radius: 15px;">
						<div class="card-body p-0">
							<div class="row g-0">
								<div class="col-lg-6">
									<div class="p-5">
										<h3 class="fw-normal mb-5" style="color: #3c455c;">General
											Information</h3>

										<form action="LandingPage" method="post">
											<input type="hidden" name="action" value="register">
											<div class="row">
												<div class="col-md-6 mb-4 pb-2">
													<div data-mdb-input-init class="form-outline">
														<label class="form-label" for="form3Examplev2">First
															name</label> <input type="text" name="firstName"
															id="form3Examplev2" class="form-control form-control-lg"
															required />

													</div>
												</div>
												<div class="col-md-6 mb-4 pb-2">
													<div data-mdb-input-init class="form-outline">
														<label class="form-label" for="form3Examplev3">Last
															name</label> <input type="text" id="form3Examplev3"
															name="lastName" class="form-control form-control-lg"
															required />

													</div>
												</div>
											</div>
											<div class="mb-4 pb-2">
												<div data-mdb-input-init class="form-outline">
													<label class="form-label" for="form3Examplev4">email</label>
													<input type="email" id="form3Examplev4" name="email"
														class="form-control form-control-lg" required />

												</div>
											</div>
											<div class="row">
												<div class="col-md-6 mb-4 pb-2 mb-md-0 pb-md-0">
													<div data-mdb-input-init class="form-outline">
														<label class="form-label" for="form3Examplev5">Phone
															Number</label> <input type="text" id="form3Examplev5"
															name="phoneNumber" class="form-control form-control-lg"
															required />

													</div>
												</div>
											</div>
											<br>
											<br>
											<div class="mb-4 pb-2">
												<div data-mdb-input-init class="form-outline">
													<label class="form-label" for="form3Examplev4">Password</label>
													<input type="password" id="form3Examplev4" name="password"
														class="form-control form-control-lg" required />

												</div>
											</div>
											<%
											String errorMessage = (String) request.getAttribute("message");
											if (errorMessage != null && !errorMessage.isEmpty()) {
											%>
											<div class="alert alert-danger">
												<%=errorMessage%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
													id="loginBtn" type="submit"
													onclick="location.href='LoginPage.jsp'" value="LogIN">
											</div>
											<%
											}
											%>
										
									</div>
								</div>
								<div class="col-lg-6 bg-indigo text-white">
									<div class="p-5">
										<h3 class="fw-normal mb-5">Bank Account Details</h3>
										<div class="mb-4 pb-2">
											<div data-mdb-input-init class="form-outline form-white">
												<label class="form-label" for="form3Examplea2">Date
													Of Birth</label> <input type="date" id="form3Examplea2"
													name="dateOfBirth" class="form-control form-control-lg"
													max="15-06-2006" required />

											</div>
										</div>
										<div class="mb-4 pb-2">
											<div data-mdb-input-init class="form-outline form-white">
												<label class="form-label" for="form3Examplea3">Aadhaar
													Number</label> <input type="text" id="form3Examplea3"
													name="aadhaarNumber" class="form-control form-control-lg"
													pattern="[0-9]{12}" required />

											</div>
										</div>
										<div class="row">
											<div class="col-md-5 mb-4 pb-2">
												<div data-mdb-input-init class="form-outline form-white">
													<label class="form-label" for="form3Examplea4">Pan
														Number</label> <input type="text" id="pan" name="panNumber"
														class="form-control form-control-lg"
														pattern="[A-Z]{5}[0-9]{4}[A-Z]" required />

												</div>
											</div>
										</div>
										<div class="mb-4 pb-2">
											<div data-mdb-input-init class="form-outline form-white">
												<label for="residentialAddress">Residential Address:</label>
												<textarea id="residentialAddress" name="residentialAddress"
													rows="4" required></textarea>
											</div>
										</div>

										<div class="form-check d-flex justify-content-start mb-4 pb-3">
											<input class="form-check-input me-3" type="checkbox" value=""
												id="form2Example3c" /> <label
												class="form-check-label text-white" for="form2Example3">
												I do accept the <a href="#!" class="text-white"><u>Terms
														and Conditions</u></a> of your site.
											</label>
										</div>
										<button type="submit" data-mdb-button-init
											data-mdb-ripple-init class="btn btn-light btn-lg"
											data-mdb-ripple-color="dark">Register</button>
									</div>

									</form>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

</body>

</html>
