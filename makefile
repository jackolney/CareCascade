ODIR = ./src

OBJ = main.cpp wp19Update.cpp wp19.cpp update.cpp toolbox.cpp rlib.cpp \
population.cpp person.cpp outputUpdate.cpp output.cpp interventions.cpp \
interventionUpdate.cpp interventionEvents.cpp impact.cpp events.cpp eventQ.cpp \
event.cpp discount.cpp cost.cpp cohort.cpp cascadeUpdate.cpp cascadeEvents.cpp calibration.cpp

OBJECTS = $(patsubst %,$(ODIR)/%,$(OBJ))

OUT = main.so

cascade: $(OBJECTS)
	@echo 'Compiling...'
	R CMD SHLIB -o $(OUT) $(OBJECTS)
	@echo 'Done.'
	@read -p "Would you like to clean *.o files: " CLEAN \
	echo $$CLEAN

ifeq ($$CLEAN,y)
	@echo 'Cleaning...' \
	rm -f $(ODIR)/*.o \
	@echo 'Finished.'
else
	@echo 'Finished.'
endif

.PHONY: clean

clean:
	@echo 'Cleaning...'
	rm -f $(ODIR)/*.o
	@echo 'Done.'

cleanall:
	@echo 'Cleaning all...'
	rm -f $(ODIR)/*.o
	rm -f *.so
	@echo 'Done.'