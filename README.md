# Steady-state ice-ice aggregation model
>A steady-state ice-ice aggregation model, using bulk-microphysics, written in FORTRAN

## Compilation:
gfortran should be installed on your system, then:

	Type 'make' to compile.

## Running code:
First

	Edit the namelist.in 

run the code by typing the following:

	single processor: ./main.exe namelist.in

## Governing equation

We start with Equation 1, which describes the evolution of the ice crystal number density function (e.g. Passarelli, 1978, Equation 1)

<p align="center"><img src="/tex/95a5685631ad25ba52bb418ae0ac5bf6.svg?invert_in_darkmode&sanitize=true" align=middle width=681.8630873999999pt height=98.19144225pt/></p>

The 1st term on the RHS of Equation 1 represents the change in the size distribution due to vapour growth and derives from the 1-d continuity equation along the mass axis:

<p align="center"><img src="/tex/adfcb12b2557cc8959ba97ee64216ac8.svg?invert_in_darkmode&sanitize=true" align=middle width=132.8240859pt height=33.81208709999999pt/></p>

where <img src="/tex/49f2f3f276a77f05ce894bf032b41e80.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=21.95701200000001pt/> is the rate-of-change along the mass axis (like a velocity).

The 2nd term on the RHS of Equation 1 represents the vertical transport (and sedimentation) of ice crystals. 

The 3rd term on the RHS of Equation 1 occurs due to aggregation. Firstly, there is a gain integral, which is due to the aggregation of particles of size <img src="/tex/6a0d5b419381f23bef964dd9f443238f.svg?invert_in_darkmode&sanitize=true" align=middle width=18.223061999999988pt height=24.7161288pt/> with <img src="/tex/d4288477ecfc880dc7c34959e53a674d.svg?invert_in_darkmode&sanitize=true" align=middle width=52.74735344999999pt height=24.7161288pt/> to yield particles of mass <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/> (the factor of <img src="/tex/47d54de4e337a06266c0e1d22c9b417b.svg?invert_in_darkmode&sanitize=true" align=middle width=6.552545999999997pt height=27.77565449999998pt/> is to prevent double-counting). Secondly, there is a loss integral, which accounts for the aggregation of particles, mass <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/>, with all other particles.

## Conservation of Power Moments
>Passarelli (1978) used the 1st and 2nd "mass moments" of the ice particle distribution to describe a steady-state model where ice particles sediment through the atmosphere. They used these moments because they are weighted by the larger ice particles, which can be approximated by negative exponential functions.

### Effect of Aggregation on Power Moments
>The effect of aggregation on any moment of the distribution can be described according to Drake (1972, their Equation 3.3).

They found that, for aggregation only, the rate-of-change of a power moment is given by:

<p align="center"><img src="/tex/1e58c6f915ea1ead1fa500c4e97b169c.svg?invert_in_darkmode&sanitize=true" align=middle width=536.2292397pt height=47.806078649999996pt/></p> 

where <img src="/tex/f55af2ba7087ae065bd9a49dd5ec815c.svg?invert_in_darkmode&sanitize=true" align=middle width=39.200973899999994pt height=47.6716218pt/> are binomial coefficients. 

>Passarelli (1978), and Mitchell (1988) considered prognostic equations for the steady-state vertical profile of two power moments: the mass power moment and the Reflectivity factor Power Moment).

### Mass Power Moment
An equation describing the evolution of the mass power moment is derived from Equation 1 by multiplying by <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/> and integrating over all positive <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/>.

Doing this for the LHS and the 2nd term on the RHS is fairly straightforward.

Doing this for the aggregation integral requires the application for Drake's Equation 3.3 (above), which is equal to zero for <img src="/tex/0676c4ef9983b3ec25648a935e040f70.svg?invert_in_darkmode&sanitize=true" align=middle width=45.13680929999999pt height=22.465723500000017pt/>.

For the first term on the RHS of Equation 1 we obtain

<p align="center"><img src="/tex/83e29f3d535ab8e4c8e3fed142ef9fa4.svg?invert_in_darkmode&sanitize=true" align=middle width=211.85636669999997pt height=38.242408049999995pt/></p>

Integrating by parts yields
<p align="center"><img src="/tex/350975a6aefa77fb7457ca40ccdaba6e.svg?invert_in_darkmode&sanitize=true" align=middle width=142.00736715pt height=38.242408049999995pt/></p>

So the equation describing the mass power moment is
	<p align="center"><img src="/tex/8b5a0adc4b4b7346c6432b9e8ae283e0.svg?invert_in_darkmode&sanitize=true" align=middle width=397.5727437pt height=38.242408049999995pt/></p>

where <img src="/tex/cbfb1b2a33b28eab8a3e59464768e810.svg?invert_in_darkmode&sanitize=true" align=middle width=14.908688849999992pt height=22.465723500000017pt/> is the mass power moment and <img src="/tex/06946a0d85dc86d3ff6e8027e8e7afa7.svg?invert_in_darkmode&sanitize=true" align=middle width=21.318618749999988pt height=22.465723500000017pt/> is the mass flux.

### Reflectivity factor Power Moment
The second equation is for the evolution of the the mass-squared, or reflectivity factor power moment is derived from Equation 1 by multiplying by <img src="/tex/89ef0b1086da48459dd5f47ed088933b.svg?invert_in_darkmode&sanitize=true" align=middle width=20.985647099999987pt height=26.76175259999998pt/> and integrating over all positive <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/>.

Its derivation is similar to above. The aggregation integral requires the application for Drake's Equation 3.3 (above), which is equal to 

<p align="center"><img src="/tex/23e34f3bd8a0e4160e47cf8d5bb09046.svg?invert_in_darkmode&sanitize=true" align=middle width=399.19686839999997pt height=38.426788949999995pt/></p>

For the first term on the RHS of Equation 1 we obtain

<p align="center"><img src="/tex/6ca167249ae82620bb0beaba3957ddeb.svg?invert_in_darkmode&sanitize=true" align=middle width=219.23082719999996pt height=38.242408049999995pt/></p>

Integrating by parts yields
<p align="center"><img src="/tex/afe17fb94a8867544fb4c25df1640e77.svg?invert_in_darkmode&sanitize=true" align=middle width=164.6596776pt height=38.242408049999995pt/></p>

So the equation describing the reflectivity factor power moment is
	<p align="center"><img src="/tex/8bd734019deb632b18cdb0cad37d43fb.svg?invert_in_darkmode&sanitize=true" align=middle width=752.09021085pt height=38.242408049999995pt/></p>

where <img src="/tex/5b51bd2e6f329245d425b8002d7cf942.svg?invert_in_darkmode&sanitize=true" align=middle width=12.397274999999992pt height=22.465723500000017pt/> is the reflectivity factor power moment and <img src="/tex/5bc42ce9cabce66c66542c6fb09deba6.svg?invert_in_darkmode&sanitize=true" align=middle width=18.92134859999999pt height=22.465723500000017pt/> is the reflectivity factor flux.

## Application to modified gamma distributions
The LHS of the two prognostic equations above are set to zero in order to model the steady-state vertical profile of the power moments.

We assume that the ice particle size distribution is given by

<p align="center"><img src="/tex/5abb53feb43b3c0c69feb4c563d77c2f.svg?invert_in_darkmode&sanitize=true" align=middle width=174.76263419999998pt height=33.81208709999999pt/></p>

In addition mass and terminal fall-speeds are given by a mass-diameter relation, <img src="/tex/3463b29f51979645bdd009d021d08bff.svg?invert_in_darkmode&sanitize=true" align=middle width=98.62991654999999pt height=27.91243950000002pt/>, and a velocity-diameter relation, <img src="/tex/135693b7e2dc28abb37ba408c01cb01b.svg?invert_in_darkmode&sanitize=true" align=middle width=88.60299359999999pt height=27.91243950000002pt/>, respectively.

The other useful relation is the mass growth rate of a particle, diameter <img src="/tex/78ec2b7008296ce0561cf83393cb746d.svg?invert_in_darkmode&sanitize=true" align=middle width=14.06623184999999pt height=22.465723500000017pt/>, given by <img src="/tex/4e1892eefe57fd6ff74c304a47092cc2.svg?invert_in_darkmode&sanitize=true" align=middle width=106.50084389999998pt height=27.91243950000002pt/>

The ice particle size distribution can be transformed into a ice particle mass distribution by multiplying by <img src="/tex/788de61705dafb50b8de712ce988e4ad.svg?invert_in_darkmode&sanitize=true" align=middle width=19.392601799999998pt height=28.92634470000001pt/>

With these assumptions the RHS of the mass power moment equation becomes

<p align="center"><img src="/tex/1feb39de246d5034b01cada3bd96d0bd.svg?invert_in_darkmode&sanitize=true" align=middle width=312.51205424999995pt height=38.242408049999995pt/></p>

which on integration yields

<p align="center"><img src="/tex/d7351a2976593cbbc1517f171c85c8e3.svg?invert_in_darkmode&sanitize=true" align=middle width=233.0419707pt height=34.7253258pt/></p>

For the reflectivity factor power moment the RHS is

<p align="center"><img src="/tex/6beedb3aa83b663a5fd044eff9caed9b.svg?invert_in_darkmode&sanitize=true" align=middle width=471.03561944999996pt height=43.19345085pt/></p>

where <img src="/tex/84df98c65d88c6adf15d4645ffa25e47.svg?invert_in_darkmode&sanitize=true" align=middle width=13.08219659999999pt height=22.465723500000017pt/> is the aggregation efficiency and <img src="/tex/d906cd9791e4b48a3b848558acda5899.svg?invert_in_darkmode&sanitize=true" align=middle width=13.77859724999999pt height=22.465723500000017pt/> is a double integral involving Gauss hypergeometric functions (this integral is slightly different to the integral in Equation B21 of Ferrier et al. 1994).

## Steady-state dependence of lambda on altitude
Set the time derivative of the power moments, and the vertical wind to zero, and change the sign of the height derivatives so downward is positive, resulting in:

<p align="center"><img src="/tex/604a21914d0a0fdef22339178904f622.svg?invert_in_darkmode&sanitize=true" align=middle width=689.3477745pt height=79.562637pt/></p>

>rearrange Equation 1 for <img src="/tex/190083ef7a1625fbc75f243cffb9c96d.svg?invert_in_darkmode&sanitize=true" align=middle width=9.81741584999999pt height=22.831056599999986pt/>, and substitute into Equation 2. Eliminate <img src="/tex/0ba57fd9f8ab88844631a2d9be8c6c29.svg?invert_in_darkmode&sanitize=true" align=middle width=16.41942389999999pt height=14.15524440000002pt/> from the last term (the special integral) by substituting <img src="/tex/06946a0d85dc86d3ff6e8027e8e7afa7.svg?invert_in_darkmode&sanitize=true" align=middle width=21.318618749999988pt height=22.465723500000017pt/> and <img src="/tex/cbfb1b2a33b28eab8a3e59464768e810.svg?invert_in_darkmode&sanitize=true" align=middle width=14.908688849999992pt height=22.465723500000017pt/> into this term.

>Next, write <img src="/tex/5bc42ce9cabce66c66542c6fb09deba6.svg?invert_in_darkmode&sanitize=true" align=middle width=18.92134859999999pt height=22.465723500000017pt/> in terms of <img src="/tex/06946a0d85dc86d3ff6e8027e8e7afa7.svg?invert_in_darkmode&sanitize=true" align=middle width=21.318618749999988pt height=22.465723500000017pt/> and find the derivative wrt height (using product rule). Substitute this expression into the LHS.


After a little bit of algebra, the final result is:
<p align="center"><img src="/tex/d931ec01ab7a71e6d8772e8664b8053d.svg?invert_in_darkmode&sanitize=true" align=middle width=695.8426134pt height=44.77515405pt/></p> 

which is the equation used here.



## References
Drake, Ronald L. 1972. “The Scalar Transport Equation of Coalescence Theory: Moments and Kernels.” Journal of the Atmospheric Sciences 29 (3): 537–47. doi:10.1175/1520-0469(1972)029<0537:TSTEOC>2.0.CO;2.

Schoenberg Ferrier, Brad. 1994. “A Double-Moment Multiple-Phase Four-Class Bulk Ice Scheme. Part I: Description.” Journal of the Atmospheric Sciences 51 (2): 249–80. doi:10.1175/1520-0469(1994)051<0249:ADMMPF>2.0.CO;2.

Mitchell, David L. 1988. “Evolution of Snow-Size Spectra in Cyclonic Storms. Part I: Snow Growth by Vapor Deposition and Aggregation.” Journal of the Atmospheric Sciences 45 (22): 3431–51. doi:10.1175/1520-0469(1988)045<3431:EOSSSI>2.0.CO;2.

Passarelli, Richard E. 1978. “An Approximate Analytical Model of the Vapor Deposition and Aggregation Growth of Snowflakes.” Journal of the Atmospheric Sciences 35 (1): 118–24. doi:10.1175/1520-0469(1978)035<0118:AAAMOT>2.0.CO;2.



