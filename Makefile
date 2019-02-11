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


main.exe :  agg_lib.a main.$(OBJ) hygfx.$(OBJ)
	$(FOR2) $(FFLAGS2)main.exe main.$(OBJ) -lm agg_lib.a
agg_lib.a	:   hygfx.$(OBJ) d1mach.$(OBJ) vode.$(OBJ) dlinpk.$(OBJ) acdc.$(OBJ) \
                    colmod.$(OBJ) opkdmain.$(OBJ) opkda1.$(OBJ) opkda2.$(OBJ)
	$(AR) rc agg_lib.a hygfx.$(OBJ) d1mach.$(OBJ) vode.$(OBJ) dlinpk.$(OBJ) \
	                acdc.$(OBJ) colmod.$(OBJ) opkdmain.$(OBJ) opkda1.$(OBJ) opkda2.$(OBJ) 
main.$(OBJ): main.f90  hygfx.$(OBJ)
	$(FOR)  main.f90 $(FFLAGS2)main.$(OBJ) 
hygfx.$(OBJ) :  hygfx.for 
	$(FOR) hygfx.for $(FFLAGS2)hygfx.$(OBJ) 
d1mach.$(OBJ) 	: netlib/d1mach.f 
	$(FOR) netlib/d1mach.f $(FFLAGS)d1mach.$(OBJ)  
opkdmain.$(OBJ) : netlib/opkdmain.f 
	$(FOR) netlib/opkdmain.f $(FFLAGS)opkdmain.$(OBJ)
opkda1.$(OBJ) : netlib/opkda1.f 
	$(FOR) netlib/opkda1.f -w $(FFLAGS)opkda1.$(OBJ)
opkda2.$(OBJ) : netlib/opkda2.f 
	$(FOR) netlib/opkda2.f -w $(FFLAGS)opkda2.$(OBJ)
vode.$(OBJ) : netlib/vode.f 
	$(FOR) 	netlib/vode.f $(FFLAGS)vode.$(OBJ)
acdc.$(OBJ) : netlib/acdc.f 
	$(FOR) 	netlib/acdc.f $(FFLAGS)acdc.$(OBJ)
dlinpk.$(OBJ) : netlib/dlinpk.f 
	$(FOR) 	netlib/dlinpk.f -w $(FFLAGS)dlinpk.$(OBJ)
colmod.$(OBJ) : netlib/colmod.f 
	$(FOR) 	netlib/colmod.f -Wno-all $(FFLAGS)colmod.$(OBJ)
clean :
	rm *.exe  *.o *.mod *~ *.a

