DEBUG = -fbounds-check -g
MPI    =#-DMPI1
OPT    =-O3


FOR = gfortran -c  
FOR2 = gfortran  

AR = ar 
RANLIB = ranlib 
OBJ = o
FFLAGS = $(OPT)  $(DEBUG)  -o 
FFLAGS2 =  $(DEBUG) -O0 -o 


main.exe :  main.$(OBJ) hygfx.$(OBJ)
	$(FOR2) $(FFLAGS2)main.exe main.$(OBJ) hygfx.$(OBJ)
main.$(OBJ): main.f90  hygfx.$(OBJ)
	$(FOR)  main.f90 $(FFLAGS2)main.$(OBJ) 
hygfx.$(OBJ) :  hygfx.for 
	$(FOR) hygfx.for $(FFLAGS2)hygfx.$(OBJ) 
clean :
	rm *.exe  *.o *.mod *~ 

