// This script is designed for the app at https://fem.blakey.family.

#include "../src/common.hpp"
#include "../src/element.hpp"
#include "../src/matrix.hpp"
#include "../src/mesh.hpp"
#include "../src/refinement.hpp"
#include "../src/solution.hpp"
#include "../src/solution_linear.hpp"
#include "../src/solution_dg_linear.hpp"
#include <algorithm>
#include <cassert>
#include <cmath>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>

double zero(double x)
{
	return 0;
}

double one(double x)
{
	return 1;
}

double m_one(double x)
{
	return -1;
}

double pi2sin(double x)
{
	return pow(M_PI, 2) * sin(M_PI * x);
}

double exact(double x)
{
	return sin(M_PI * x);
}

double exact_(double x)
{
	return M_PI * cos(M_PI * x);
}

double expx2(double x)
{
	return exp(-pow(x, 2));
}

int main(int argc, char *argv[])
{
	std::cout << "f: " << argv[1] << std::endl;
	std::cout << "epsilon: " << argv[2] << std::endl;
	std::cout << "c: " << argv[3] << std::endl;
	std::cout << "N: " << argv[4] << std::endl;

	f_double f;
	if (std::string(argv[1]) == "sin")
		f = sin;
	else if (std::string(argv[1]) == "cos")
		f = cos;
	else if (std::string(argv[1]) == "one")
		f = one;
	else if (std::string(argv[1]) == "zero")
		f = zero;
	else if (std::string(argv[1]) == "pi2sin")
		f = pi2sin;
	else
		f = zero;

	double epsilon = std::stod(argv[2]);

	f_double c;
	if (std::string(argv[3]) == "sin")
		c = sin;
	else if (std::string(argv[3]) == "cos")
		c = cos;
	else if (std::string(argv[3]) == "one")
		c = one;
	else if (std::string(argv[3]) == "zero")
		c = zero;
	else if (std::string(argv[3]) == "pi2sin")
		c = pi2sin;
	else
		c = zero;

	int N = std::stoi(argv[4]);

	// Elements* myElements = new Elements(N);
	// Mesh*     myMesh     = new Mesh(myElements);
	// Solution* mySolution = new Solution_dg_linear(myMesh, f, epsilon, c);

	// mySolution->Solve(1e-15);
	// mySolution->outputToFile(std::string(argv[6]));

	// std::cout << "DONE!" << std::endl;

	// delete mySolution;
	// delete myMesh;
	// delete myElements;

	// Sets up problem.
	Mesh*               myMesh     = new Mesh(N);
	Solution_dg_linear* mySolution = new Solution_dg_linear(myMesh, f, epsilon, c);

	// Refinement variables.
	Mesh*               myNewMesh;
	Solution_dg_linear* myNewSolution_type;
	Solution*           myNewSolution = myNewSolution_type;

	refinement::refinement(myMesh, &myNewMesh, mySolution, &myNewSolution, 1e-15, 0, 5, true, true, true);

	// Solves the new problem, and then outputs solution and mesh to files.
	myNewSolution->output_solution(zero, std::string(argv[5]));
	myNewSolution->Solve(1e-15);
	myNewSolution->output_mesh(std::string(argv[6]));

	//delete myNewSolution; // DEFFO a memory leak somewhere.
	delete mySolution;
	//delete myNewMesh;
	delete myMesh;

	return 0;
}