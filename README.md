# Steady-state ice-ice aggregation
A steady-state ice-ice aggregation model, using bulk-microphysics, written in FORTRAN

## Compilation:
gfortran should be installed on your system, then:

* Type 'make' to compile.

## Running code:
run the code by typing the following:

* single processor: ./main.exe namelist.in

## Governing equations

We start with an equation that describes the evolution of the ice crystal number density function (e.g. Passarelli, 1978, Equation 1)

<p align="center"><img src="/tex/b0ee485cd56f8ae03b970d2b300cca33.svg?invert_in_darkmode&sanitize=true" align=middle width=681.8630873999999pt height=98.19144225pt/></p>


The effect of aggregation on any moment of the distribution can be described according to Drake (1972, Equation 3.3)

## References
Drake, Ronald L. 1972. “The Scalar Transport Equation of Coalescence Theory: Moments and Kernels.” Journal of the Atmospheric Sciences 29 (3): 537–47. doi:10.1175/1520-0469(1972)029<0537:TSTEOC>2.0.CO;2.

Schoenberg Ferrier, Brad. 1994. “A Double-Moment Multiple-Phase Four-Class Bulk Ice Scheme. Part I: Description.” Journal of the Atmospheric Sciences 51 (2): 249–80. doi:10.1175/1520-0469(1994)051<0249:ADMMPF>2.0.CO;2.

Mitchell, David L. 1988. “Evolution of Snow-Size Spectra in Cyclonic Storms. Part I: Snow Growth by Vapor Deposition and Aggregation.” Journal of the Atmospheric Sciences 45 (22): 3431–51. doi:10.1175/1520-0469(1988)045<3431:EOSSSI>2.0.CO;2.

Passarelli, Richard E. 1978. “An Approximate Analytical Model of the Vapor Deposition and Aggregation Growth of Snowflakes.” Journal of the Atmospheric Sciences 35 (1): 118–24. doi:10.1175/1520-0469(1978)035<0118:AAAMOT>2.0.CO;2.



