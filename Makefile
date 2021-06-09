
ifeq ($(strip $(CC)),)
CC := gcc
endif
CC += -Wall -MP -MD 
INCMLFLG := -D INC_ML_CMPL
TESTFLG := -D TEST
DIR := src/c

SPECCMPL := 

SOURCES := $(wildcard $(DIR)/*.c)
OBJECTS := $(patsubst $(DIR)/%.c,  $(DIR)/%.o, $(SOURCES))

.PHONY: ml inc constraint_inc clean
ml: SPECCMPL = -D INC_ML_CMPL
inc: SPECCMPL = -D INC_CMPL 
constraint_inc: SPECCMPL = -D CINC_CMPL
constraint_inc_d: SPECCMPL = -D CINC_CMPL
constraint_inc_d: CC += -g

clean:
	rm -f $(DIR)/*.o
	rm -f $(DIR)/*.d
	rm -f ml
	rm -f inc
	rm -f constraint_inc
	rm -f constraint_inc_d

ml inc constraint_inc constraint_inc_d: clean $(OBJECTS)
	$(CC) $(SPECCMPL) $(filter-out $<,$^) -lm -o $@

$(DIR)/%.o: $(DIR)/%.c
	$(CC) $(SPECCMPL) -I$(DIR) -c $< -o $@

