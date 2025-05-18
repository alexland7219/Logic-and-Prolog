FILES = miSudoku teams events newBusCompany voley olympiad roads tsp tents-trees

%: %.pl
	swipl -q -O -g main --stand_alone=true -o $@ -c $<

.PHONY: clean realclean $(FILES)

clean:
	-rm -f clauses header infile.cnf model

realclean: clean
	-rm -f $(FILES)