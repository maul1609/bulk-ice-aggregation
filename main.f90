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
                    dz,chi_start,lam_start,lambda,ea
        logical :: integrate
        real(dp), dimension(3) :: c=(/1._dp,2._dp,1._dp/)

        character (len=200) :: nmlfile = ' '

        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ! namelists                                                            !
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        namelist /input_spec/ integrate,z_start,z_end,dz,&
            lam_start,chi_start,ea,alpha_i,a_i,b_i,c_i,d_i
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ! read in namelists													   !
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        call getarg(1,nmlfile)
        open(8,file=nmlfile,status='old', recl=80, delim='apostrophe')
        read(8,nml=input_spec)
        close(8)


        ! gauss hypergeometric equations aggregation of ice with ice 
        ! See Ferrier (1994, JAS part 1, equation B.21)
        a=1._dp
        b=4._dp+2._dp*alpha_i+b_i
        iice=0._dp
        do k=1,3
            call hygfx(a, b, real(k,dp)+alpha_i+1.0_dp,0.5_dp,f1)
            call hygfx(a, b, real(k,dp)+alpha_i+b_i+1.0_dp, 0.5_dp,f2)
            iice=iice+c(k)*(f1/(real(k,dp)+alpha_i)+f2/(real(k,dp)+alpha_i+b_i))
        enddo
        iice=pi*gamma(b)/(2._dp**(6._dp+2._dp*alpha_i+b_i)) * iice

        
        if(integrate) then
            z=z_start
            lambda=lam_start
            do while (z >= z_end)
                print *,z,lambda
                ! equation 16 from Mitchell 1988, without vapour growth (1st term on rhs)
                lambda=lambda-dz*(pi*ea*iice*chi_start*lambda**(d_i+b_i-1)) / &
                    (4._dp*d_i*a_i*c_i*gamma(d_i+b_i+1._dp)*gamma(2._dp*d_i+b_i+1._dp))
                z = z - dz
            end do
        else
            print *,iice
        endif    
        
        

    end program main



