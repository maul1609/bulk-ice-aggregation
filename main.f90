	!> @mainpage
	!>@author
	!>Paul J. Connolly, The University of Manchester
	!>@copyright 2018
	!>@brief
	!>Solves equations for aggregation of modified gamma distribution
	!> <br><br>
	!> compile using the Makefile (note requires netcdf) and then run using: <br>
	!> ./main.exe namelist.in
	!> <br><br>
	!> (namelist used for initialisation).
	!> <br><br>


	!>@author
	!>Paul J. Connolly, The University of Manchester
	!>@brief
	!>main programme reads in information, allocates arrays, then calls the model driver

    program main
        use hypergeo, only : hygfx
        implicit none
        integer, parameter :: &
                sp = kind(1.0), &
                dp = kind(1.d0), &
                i4b = selected_int_kind(9)
        real, parameter :: pi = 4._dp*atan(1._dp)
        integer(i4b) :: k
        real(dp) :: iice,a_i,alpha_i,b_i,c_i,d_i,a,b,f1,f2, z_start,z_end, z,&
                    dz,chi_start,lam_start,lambda,ea, &
                    n00,mass_start,chi,n0
        logical :: integrate,passarelli
        real(dp), dimension(3) :: c=(/1._dp,2._dp,1._dp/)

        character (len=200) :: nmlfile = ' '

        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ! namelists                                                            !
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        namelist /input_spec/ integrate,passarelli,z_start,z_end,dz,&
            lam_start,chi_start,ea,alpha_i,a_i,b_i,c_i,d_i
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ! read in namelists													   !
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        call getarg(1,nmlfile)
        open(8,file=nmlfile,status='old', recl=80, delim='apostrophe')
        read(8,nml=input_spec)
        close(8)





        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ! Seems like integrals in Passarelli and Ferrier are different: Passarelli is for!
        ! how aggregation affects reflectivity factor, Ferrier is for how aggregation    !
        ! affects number                                                                 !
        ! therefore it is not correct to use Ferrier integration with the Mitchell theory!
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        if(passarelli) then
            ! gauss hypergeometric equations aggregation of ice with ice 
            ! See Passarelli (1978, JAS, equation 23)
            a=1._dp
            b=4._dp+2._dp*(alpha_i+d_i)+b_i
            iice=0._dp
            do k=1,3
                ! Passarelli (1978), see equation 23
!                 call hygfx(a, b, 8._dp-real(k,dp),0.5_dp,f1)
                call hygfx(a, b, real(k,dp)+d_i+alpha_i+1.0_dp,0.5_dp,f1)
                call hygfx(a, b, 1._dp+d_i+alpha_i+b_i+real(k,dp), 0.5_dp,f2)
!                iice=iice+c(k)*(f1/(7._dp-real(k,dp))-f2/(d_i+alpha_i+b_i+real(k,dp)))
                iice=iice+c(k)*(f1/(real(k,dp)+alpha_i+d_i)-f2/(real(k,dp)+alpha_i+d_i+b_i))
            enddo
            iice=gamma(b)*(2._dp**(1._dp-b)) * iice
        else 
            ! gauss hypergeometric equations aggregation of ice with ice 
            ! See Ferrier (1994, JAS part 1, equation B.21)
            a=1._dp
            b=4._dp+2._dp*alpha_i+b_i
            iice=0._dp
            do k=1,3
                ! Ferrier (1994), see equation b21
                call hygfx(a, b, real(k,dp)+alpha_i+1.0_dp,0.5_dp,f1)
                call hygfx(a, b, real(k,dp)+alpha_i+b_i+1.0_dp, 0.5_dp,f2)
                iice=iice+c(k)*(f1/(real(k,dp)+alpha_i)-f2/(real(k,dp)+alpha_i+b_i))
            enddo
!            iice=pi*gamma(b)/(2._dp**(6._dp+2._dp*alpha_i+b_i)) * iice
            iice=gamma(b)/(2._dp**(3._dp+2._dp*alpha_i+b_i)) * iice ! get rid of pi/8.
        endif
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!





        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
        ! calculate the initial n0 (intercept) given chi_start                           !
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
        n00=chi_start*lam_start**(d_i+b_i+alpha_i+1._dp)/(a_i*c_i)/ &
                gamma(d_i+b_i+alpha_i+1._dp)
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
  
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
        ! calculate the initial mass - assume conserved                                  !
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
        mass_start=c_i*n00*gamma(d_i+1._dp) / lam_start**(d_i+1._dp)
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
  
  
  
        
        
        if(integrate) then
            z=z_start
            lambda=lam_start
            chi=chi_start
            do while (z >= z_end)
                print *,z,lambda,chi
                ! equation 16 from Mitchell 1988, without vapour growth (1st term on rhs)
                lambda=max(lambda &
                   -dz*(pi*ea*iice*chi*lambda**(d_i+b_i-1._dp)) / &
                    (4._dp*d_i*a_i*c_i*gamma(d_i+b_i+1._dp)*gamma(2._dp*d_i+b_i+1._dp)),&
                    1._sp)
                    
                ! update n0 from new lambda and initial mass (conserved)
                n0=mass_start*lambda**(d_i+1._dp)/(c_i*gamma(d_i+1._dp))
                ! update chi from new lambda and n0
                chi=a_i*c_i*n0*gamma(d_i+b_i+alpha_i+1._dp) / &
                    lambda**(d_i+b_i+alpha_i+1._dp)
                    
                z = z - dz
            end do
        else
            print *,iice
        endif    
        
        

    end program main



