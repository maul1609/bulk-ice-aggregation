# Steady-state ice-ice aggregation
A steady-state ice-ice aggregation model, using bulk-microphysics, written in FORTRAN

## Compilation:
gfortran should be installed on your system, then:

* Type 'make' to compile.

## Running code:
run the code by typing the following:

* single processor: ./main.exe namelist.in

## Governing equation

We start with Equation 1, which describes the evolution of the ice crystal number density function (e.g. Passarelli, 1978, Equation 1)

<p align="center"><img src="/tex/95a5685631ad25ba52bb418ae0ac5bf6.svg?invert_in_darkmode&sanitize=true" align=middle width=681.8630873999999pt height=98.19144225pt/></p>

The 1st term on the RHS of Equation 1 represents the change in the size distribution due to vapour growth and derives from the 1-d continuity equation along the mass axis:

<p align="center"><img src="/tex/adfcb12b2557cc8959ba97ee64216ac8.svg?invert_in_darkmode&sanitize=true" align=middle width=132.8240859pt height=33.81208709999999pt/></p>

where <img src="/tex/49f2f3f276a77f05ce894bf032b41e80.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=21.95701200000001pt/> is the rate-of-change along the mass axis (like a velocity).

The 2nd term on the RHS of Equation 1 represents the vertical transport (and sedimentation) of ice crystals. 

The 3rd term on the RHS of Equation 1 occurs due to aggregation. Firstly, there is a gain integral, which is due to the aggregation of particles of size <img src="/tex/6a0d5b419381f23bef964dd9f443238f.svg?invert_in_darkmode&sanitize=true" align=middle width=18.223061999999988pt height=24.7161288pt/> with <img src="/tex/d4288477ecfc880dc7c34959e53a674d.svg?invert_in_darkmode&sanitize=true" align=middle width=52.74735344999999pt height=24.7161288pt/> to yield particles of mass <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/> (the factor of <img src="/tex/47d54de4e337a06266c0e1d22c9b417b.svg?invert_in_darkmode&sanitize=true" align=middle width=6.552545999999997pt height=27.77565449999998pt/> is to prevent double-counting). Secondly, there is a loss integral, which accounts for the aggregation of particles, mass <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/>, with all other particles.

## Conservation of Power Moments
Passarelli (1978) used the 1st and 2nd "mass moments" of the ice particle distribution to describe a steady-state model where ice particles sediment through the atmosphere. They used these moments because they are weighted by the larger ice particles, which can be approximated by negative exponential functions.

### Effect of Aggregation on Power Moments
The effect of aggregation on any moment of the distribution can be described according to Drake (1972, their Equation 3.3).

They found that, for aggregation only, the rate-of-change of a power moment is given by:

<p align="center"><img src="/tex/1e58c6f915ea1ead1fa500c4e97b169c.svg?invert_in_darkmode&sanitize=true" align=middle width=536.2292397pt height=47.806078649999996pt/></p> 

where <img src="/tex/32c85c1611cd917a61eb439464bf6f63.svg?invert_in_darkmode&sanitize=true" align=middle width=14.99998994999999pt height=42.52063860000002pt/> are binomial coefficients. 

Passarelli (1978) considers prognostic equations for the steady-state vertical profile of two power moments: the mass power moment and the Reflectivity factor Power Moment).

### Mass Power Moment
An equation describing the evolution of the mass power moment is derived from Equation 1 by multiplying by <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/> and integrating over all positive <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/>.

Doing this for the LHS and the 2nd term on the RHS is fairly straightforward.

Doing this for the aggregation integral requires the application for Drake's Equation 3.3 (above), which is equal to zero for <img src="/tex/0676c4ef9983b3ec25648a935e040f70.svg?invert_in_darkmode&sanitize=true" align=middle width=45.13680929999999pt height=22.465723500000017pt/>.

For the first term on the RHS of Equation 1 we obtain

<p align="center"><img src="/tex/83e29f3d535ab8e4c8e3fed142ef9fa4.svg?invert_in_darkmode&sanitize=true" align=middle width=211.85636669999997pt height=38.242408049999995pt/></p>

Integrating by parts yields
<p align="center"><img src="/tex/350975a6aefa77fb7457ca40ccdaba6e.svg?invert_in_darkmode&sanitize=true" align=middle width=142.00736715pt height=38.242408049999995pt/></p>

So the equation describing the mass power moment is
<p align="center"><img src="/tex/cd37364fc75e0891b174bc3fa8a35cba.svg?invert_in_darkmode&sanitize=true" align=middle width=665.4247809pt height=38.242408049999995pt/></p>


### Reflectivity factor Power Moment


## Application to modified gamma distributions


## References
Drake, Ronald L. 1972. “The Scalar Transport Equation of Coalescence Theory: Moments and Kernels.” Journal of the Atmospheric Sciences 29 (3): 537–47. doi:10.1175/1520-0469(1972)029<0537:TSTEOC>2.0.CO;2.

Schoenberg Ferrier, Brad. 1994. “A Double-Moment Multiple-Phase Four-Class Bulk Ice Scheme. Part I: Description.” Journal of the Atmospheric Sciences 51 (2): 249–80. doi:10.1175/1520-0469(1994)051<0249:ADMMPF>2.0.CO;2.

Mitchell, David L. 1988. “Evolution of Snow-Size Spectra in Cyclonic Storms. Part I: Snow Growth by Vapor Deposition and Aggregation.” Journal of the Atmospheric Sciences 45 (22): 3431–51. doi:10.1175/1520-0469(1988)045<3431:EOSSSI>2.0.CO;2.

Passarelli, Richard E. 1978. “An Approximate Analytical Model of the Vapor Deposition and Aggregation Growth of Snowflakes.” Journal of the Atmospheric Sciences 35 (1): 118–24. doi:10.1175/1520-0469(1978)035<0118:AAAMOT>2.0.CO;2.



