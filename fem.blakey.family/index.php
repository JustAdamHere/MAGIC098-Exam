<!DOCTYPE html>
<html lang="en">
<head>
	<title>Blakey FEM | DG Refinement</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>

	<?php 
	if (!isset($_GET["f"]))
	{
	?>
		<div class="container-contact100">
			<div class="wrap-contact100">
				<form class="contact100-form validate-form">
					<span class="contact100-form-title">
						Blakey FEM
					</span>

					<img style="padding: 0 80px;" width="100%" src="./equation.png" />	

					<br>
					<br>
					Welcome to Blakey FEM! This is a test solver that will solve 5 iterations of hp-refinement on your favourite* ODE. The domain is fixed with omega on [0, 1] in 1 dimension. Please choose options below for the equation to solve. You have some multiple choices for f and c, and can specify any positive real number for epsilon, and a positive integer greater than 1 for N (the <strong>starting</strong> number of elements). This code is all available on this repository: <a target="_blank" href="https://github.com/JustAdamHere/MAGIC098-Exam">https://github.com/JustAdamHere/MAGIC098-Exam</a>
					<br>
					<br>
					* As long as your favourite ODE takes a very, very specific form.
					<br>
					<br>
					If you're unsure on what to do, then try some of these examples:
					<ul>
						<li><a href="https://fem.blakey.family/?f=one&epsilon=0.000001&c=one&N=20">Boundary layer</a></li>
						<li><a href="https://fem.blakey.family/?f=pi2sin&epsilon=1&c=zero&N=10">Poisson</a></li>
					</ul>

					<div class="wrap-input100 input100-select">
					<span class="label-input100">Forcing function, f</span>
					<div>
						<select class="selection-2" name="f">
							<option disabled selected>Select f</option>
							<option value="sin">f(x) = sin(x)</option>
							<option value="cos">f(x) = cos(x)</option>
							<option value="zero">f(x) = 0</option>
							<option value="one">f(x) = 1</option>
							<option value="pi2sin">f(x) = pi^2 sin(pi x)</option>
						</select>
					</div>
					<!-- <br /> -->

					<div class="wrap-input100 validate-input" data-validate = "Be sensible!">
						<span class="label-input100">u'' coefficient, epsilon</span>
						<input class="input100" type="number" name="epsilon" min="0.000001" max="1000" step="0.000001" placeholder="Second derivative coefficient">
						<span class="focus-input100"></span>
					</div>

					<div class="wrap-input100 input100-select">
					<span class="label-input100">u coefficient function, c</span>
					<div>
						<select class="selection-2" name="c">
							<option disabled selected>Select c</option>
							<option value="sin">c(x) = sin(x)</option>
							<option value="cos">c(x) = cos(x)</option>
							<option value="zero">c(x) = 0</option>
							<option value="one">c(x) = 1</option>
							<option value="pi2sin">c(x) = pi^2 sin(pi x)</option>
						</select>
					</div>
					<!-- <br /> -->

					<div class="wrap-input100 validate-input" data-validate = "Be sensible!">
						<span class="label-input100">Number of elements</span>
						<input class="input100" type="number" name="N" min="2" max="10000" step="1" placeholder="Number of elements">
						<span class="focus-input100"></span>
					</div>

					<div class="container-contact100-form-btn">
						<div class="wrap-contact100-form-btn">
							<div class="contact100-form-bgbtn"></div>
							<button class="contact100-form-btn">
								<span>
									Run
									<i class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></i>
								</span>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>

	<?php
	}	
	else
	{
	?>
		<div class="container-contact100">
			<div class="wrap-contact100">
				<span class="contact100-form-title">
					Blakey FEM
				</span>

				<a href="https://fem.blakey.family">Click to Restart</a>

				<img style="padding: 0 80px;" width="100%" src="./equation.png" />

				<?php
				$date = date('Y-m-d H:i:s');
				$random_hash = sha1($date.strval(rand(1, 100)));
				$filename = $random_hash;

				$f = $_GET["f"];
				$epsilon = $_GET["epsilon"];
				$c = $_GET["c"];
				$N = $_GET["N"];

				echo "You chose:";
				echo "<ul>";
				echo "<li>f: ".$f."</li>";
				echo "<li>epsilon: ".$epsilon."</li>";
				echo "<li>c: ".$c."</li>";
				echo "<li>N: ".$N."</li>";
				echo "</ul>";
				echo "<br>";
				echo "Try with <strong><a href='?f=".$f."&epsilon=".$epsilon."&c=".$c."&N=".($N+10)."'>more</a></strong> elements";
				echo "<br>";
				if ($N > 11)
				{
					echo "Try with <strong><a href='?f=".$f."&epsilon=".$epsilon."&c=".$c."&N=".($N-10)."'>less</a></strong> elements";
				}
				echo "<br>";
				echo "<br>";

				echo "See below for a plot of the solution and the mesh after 5 hp-adaptive refinements.";
				echo "<br>";
				echo "If something has gone drastically wrong, then please email <a href='mailto:adam.blakey@nott.ac.uk'>Adam</a>.";

				exec('./driver_linux.out '.$f.' '.$epsilon.' '.$c.' '.$N.' ./data/'.$filename.'-solution.dat ./data/'.$filename.'-mesh.dat', $cppoutput, $pyreturn);
				//exec('python ./plot_convergence.py ./data/'.$filename.'-convergence.dat '.$filename, $pyoutput_conv, $pyreturn);
				exec('python ./plot_mesh.py ./data/'.$filename.'-mesh.dat '.$filename, $pyoutput_mesh, $pyreturn);
				exec('python ./plot_solution.py ./data/'.$filename.'-solution.dat '.$filename, $pyoutput_soln, $pyreturn);
				?>

				<img width="100%" src="./outputs/<?=$filename;?>-mesh.png" />
				<img width="100%" src="./outputs/<?=$filename;?>-solution.png" />

				<!-- <span>C++ Output:</span> -->
				<?php
				foreach ($cppoutput as $line)
				{
					//echo $line."<br>";
				}
				?>

				<!-- <span>Python Output:</span> -->
				<?php
				foreach ($pyoutput as $line)
				{
					//echo $line."<br>";
				}
				?>
			</div>
		</div>
	<?php
	}
	?>


	<div id="dropDownSelect1"></div>

<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
	<script>
		$(".selection-2").select2({
			minimumResultsForSearch: 20,
			dropdownParent: $('#dropDownSelect1')
		});
	</script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>



	<!-- <div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form">
				<span class="contact100-form-title">
					Blakey FEM
				</span>

				<div class="wrap-input100 validate-input" data-validate="Be sensible!">
					<span class="label-input100">f</span>
					<input class="input100" type="text" name="f" placeholder="Forcing function">
					<span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input" data-validate = "Be sensible!">
					<span class="label-input100">epsilon</span>
					<input class="input100" type="number" name="epsilon" placeholder="Second derivative coefficient">
					<span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input" data-validate = "Be sensible!">
					<span class="label-input100">c</span>
					<input class="input100" type="text" name="c" placeholder="c function">
					<span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input" data-validate = "Be sensible!">
					<span class="label-input100">Number of elements</span>
					<input class="input100" type="text" name="N" placeholder="Number of elements">
					<span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 input100-select">
					<span class="label-input100">Needed Services</span>
					<div>
						<select class="selection-2" name="service">
							<option>Choose Services</option>
							<option>Online Store</option>
							<option>eCommerce Bussiness</option>
							<option>UI/UX Design</option>
							<option>Online Services</option>
						</select>
					</div>
					<span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 input100-select">
					<span class="label-input100">Budget</span>
					<div>
						<select class="selection-2" name="budget">
							<option>Select Budget</option>
							<option>1500 $</option>
							<option>2000 $</option>
							<option>2500 $</option>
						</select>
					</div>
					<span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input" data-validate = "Message is required">
					<span class="label-input100">Message</span>
					<textarea class="input100" name="message" placeholder="Your message here..."></textarea>
					<span class="focus-input100"></span>
				</div>

				<div class="container-contact100-form-btn">
					<div class="wrap-contact100-form-btn">
						<div class="contact100-form-bgbtn"></div>
						<button class="contact100-form-btn">
							<span>
								Submit
								<i class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></i>
							</span>
						</button>
					</div>
				</div>
			</form>
		</div>
	</div> -->