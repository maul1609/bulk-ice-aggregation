# Steady-state ice-ice aggregation
A steady-state ice-ice aggregation model, using bulk-microphysics, written in FORTRAN

## Compilation:
gfortran should be installed on your system, then:

	Type 'make' to compile.

## Running code:
run the code by typing the following:

	single processor: ./main.exe namelist.in

## Governing equation

We start with Equation 1, which describes the evolution of the ice crystal number density function (e.g. Passarelli, 1978, Equation 1)

\begin{multline} \frac{\partial}{\partial t}n\left(m,t,z \right) =-\frac{\partial}{\partial m}\left[\dot{m}n\left(m,t,z \right) \right]-\frac{\partial}{\partial z}\left{\left[ w-v_T\left(m\right)\right]n\left(m,t,z \right)\right}+ \\
\frac{1}{2}\int _0^m n\left(m-m',t,z\right)n\left(m',t,z\right)k\left(m-m',m'\right)dm' - n\left(m,t,z \right)\int_0^\infty n\left(m',t,z\right)k\left(m,m' \right) dm' \label{EQ:N_EVOL}\end{multline}

The 1st term on the RHS of Equation 1 represents the change in the size distribution due to vapour growth and derives from the 1-d continuity equation along the mass axis:

\begin{equation*}
\frac{\partial }{\partial t}\psi+\frac{\partial}{\partial m}\dot{m}\psi = 0 
\end{equation*}

where $\dot{m}$ is the rate-of-change along the mass axis (like a velocity).

The 2nd term on the RHS of Equation 1 represents the vertical transport (and sedimentation) of ice crystals. 

The 3rd term on the RHS of Equation 1 occurs due to aggregation. Firstly, there is a gain integral, which is due to the aggregation of particles of size $m'$ with $m-m'$ to yield particles of mass $m$ (the factor of $\frac{1}{2}$ is to prevent double-counting). Secondly, there is a loss integral, which accounts for the aggregation of particles, mass $m$, with all other particles.

## Conservation of Power Moments
Passarelli (1978) used the 1st and 2nd "mass moments" of the ice particle distribution to describe a steady-state model where ice particles sediment through the atmosphere. They used these moments because they are weighted by the larger ice particles, which can be approximated by negative exponential functions.

### Effect of Aggregation on Power Moments
The effect of aggregation on any moment of the distribution can be described according to Drake (1972, their Equation 3.3).

They found that, for aggregation only, the rate-of-change of a power moment is given by:

\begin{equation*}
\frac{dM_N\left(t\right)}{dt}=\frac{1}{2}\sum _{i=1}^{N-1}\left( \begin{matrix}N\\i\end{matrix}\right)\int_0^\infty\int_0^\infty m^i m'^{N-i}k\left(m,m'\right)n\left(m,t \right)n\left(m',t \right)dm dm'
\end{equation*} 

where $\begin{matrix}N\\i\end{matrix}$ are binomial coefficients. 

Passarelli (1978) considers prognostic equations for the steady-state vertical profile of two power moments: the mass power moment and the Reflectivity factor Power Moment).

### Mass Power Moment
An equation describing the evolution of the mass power moment is derived from Equation 1 by multiplying by $m$ and integrating over all positive $m$.

Doing this for the LHS and the 2nd term on the RHS is fairly straightforward.

Doing this for the aggregation integral requires the application for Drake's Equation 3.3 (above), which is equal to zero for $N=1$.

For the first term on the RHS of Equation 1 we obtain

\begin{equation*}
-\int_0 ^\infty m\frac{\partial}{\partial m}\left[\dot{m}n\left(m,t,z \right) \right] dm
\end{equation*}

Integrating by parts yields
\begin{equation*}
\int_0 ^\infty \dot{m}n\left(m,t,z \right) dm
\end{equation*}

So the equation describing the mass power moment is
\begin{equation*}
\frac{\partial}{\partial t}X\left(t,z \right) =  \int_0 ^\infty \dot{m}n\left(m,t,z \right) dm - \frac{\partial}{\partial z}\left(wX\left(t,z\right) - X_f \right)
\end{equation*}

where $X$ is the mass power moment and $X_f$ is the mass flux.

### Reflectivity factor Power Moment
The second equation is for the evolution of the the mass-squared, or reflectivity factor power moment is derived from Equation 1 by multiplying by $m^2$ and integrating over all positive $m$.

Its derivation is similar to above. The aggregation integral requires the application for Drake's Equation 3.3 (above), which is equal to 

\begin{equation*}
\frac{dZ\left(t\right)}{dt}=\int_0^\infty\int_0^\infty m m'k\left(m,m'\right)n\left(m,t \right)n\left(m',t \right)dm dm'
\end{equation*}

For the first term on the RHS of Equation 1 we obtain

\begin{equation*}
-\int_0 ^\infty m^2\frac{\partial}{\partial m}\left[\dot{m}n\left(m,t,z \right) \right] dm
\end{equation*}

Integrating by parts yields
\begin{equation*}
\int_0 ^\infty 2m\dot{m}n\left(m,t,z \right) dm
\end{equation*}

So the equation describing the reflectivity factor power moment is
\begin{equation*}
\frac{\partial}{\partial t}Z\left(t,z \right) =  \int_0 ^\infty 2m\dot{m}n\left(m,t,z \right) dm - \frac{\partial}{\partial z}\left(wZ\left(t,z\right) - Z_f \right) + \int_0^\infty\int_0^\infty m m'k\left(m,m'\right)n\left(m,t \right)n\left(m',t \right)dm dm'
\end{equation*}

where $X$ is the mass power moment and $X_f$ is the mass flux.

## Application to modified gamma distributions


## References
Drake, Ronald L. 1972. “The Scalar Transport Equation of Coalescence Theory: Moments and Kernels.” Journal of the Atmospheric Sciences 29 (3): 537–47. doi:10.1175/1520-0469(1972)029<0537:TSTEOC>2.0.CO;2.

Schoenberg Ferrier, Brad. 1994. “A Double-Moment Multiple-Phase Four-Class Bulk Ice Scheme. Part I: Description.” Journal of the Atmospheric Sciences 51 (2): 249–80. doi:10.1175/1520-0469(1994)051<0249:ADMMPF>2.0.CO;2.

Mitchell, David L. 1988. “Evolution of Snow-Size Spectra in Cyclonic Storms. Part I: Snow Growth by Vapor Deposition and Aggregation.” Journal of the Atmospheric Sciences 45 (22): 3431–51. doi:10.1175/1520-0469(1988)045<3431:EOSSSI>2.0.CO;2.

Passarelli, Richard E. 1978. “An Approximate Analytical Model of the Vapor Deposition and Aggregation Growth of Snowflakes.” Journal of the Atmospheric Sciences 35 (1): 118–24. doi:10.1175/1520-0469(1978)035<0118:AAAMOT>2.0.CO;2.



