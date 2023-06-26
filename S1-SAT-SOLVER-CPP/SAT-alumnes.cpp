#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
#include <utility>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model;
vector<int> modelStack;
uint indexOfNextLitToPropagate;
// nextDecision will serve as an index to vector V
uint decisionLevel;

vector<vector<int>> pos; // V[x] is a vector that contains all clauses where literal +x appears
vector<vector<int>> neg; // V[x] is a vector that contains all clauses where literal -x appears

// V[Symbol] = priority
vector<int> V;
void readClauses( ){
  // Skip comments
  char c = cin.get();
  while (c == 'c') {
    while (c != '\n') c = cin.get();
    c = cin.get();
  }  
  // Read "cnf numVars numClauses"
  string aux;
  cin >> aux >> numVars >> numClauses;

  V.resize(numVars);
  pos.resize(numVars);
  neg.resize(numVars);
  clauses.resize(numClauses);

  // Initializing values of vector V
  for (int i = 1; i <= numVars; ++i){
	V[i-1] = 0;
  }  
  // Read clauses
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    while (cin >> lit and lit != 0){
		clauses[i].push_back(lit);
		
		if (lit < 0) neg[-lit - 1].push_back(i);
		else pos[lit - 1].push_back(i);

		if (lit < 0) lit *= -1;
		V[lit - 1]++;

	} 
  }
}



int currentValueInModel(int lit){
  if (lit >= 0) return model[lit];
  else {
    if (model[-lit] == UNDEF) return UNDEF;
    else return 1 - model[-lit];
  }
}


void setLiteralToTrue(int lit){
  modelStack.push_back(lit);
  if (lit > 0) model[lit] = TRUE;
  else model[-lit] = FALSE;		
}


bool propagateGivesConflict ( ) {
  while ( indexOfNextLitToPropagate < modelStack.size() ) {
    ++indexOfNextLitToPropagate;


	int lit = modelStack[indexOfNextLitToPropagate-1];

	vector<int> clauseVect;
	clauseVect = lit > 0 ? neg[lit-1] : pos[-lit-1];

	// This searches all clauses. We'll only search clauses that get affected
    for (uint j = 0; j < clauseVect.size(); ++j) {
	  int i = clauseVect[j];
      bool someLitTrue = false;
      int numUndefs = 0;
      int lastLitUndef = 0;
      for (uint k = 0; not someLitTrue and k < clauses[i].size(); ++k){
        int val = currentValueInModel(clauses[i][k]);
        if (val == TRUE) someLitTrue = true;
        else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[i][k]; }
      }
      if (not someLitTrue and numUndefs == 0){
        for (uint k = 0; k < clauses[i].size(); ++k){
          int auglit = clauses[i][k];
          if (auglit < 0) auglit *= -1;
          // Augment priority of those who have been contradicted
          V[auglit-1]++;
        }
        return true;
      } // conflict! all lits false
      else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);	
    }    
  }
  return false;
}


void backtrack(){
  uint i = modelStack.size() -1;
  int lit = 0;
  while (modelStack[i] != 0){ // 0 is the DL mark
    lit = modelStack[i];
    model[abs(lit)] = UNDEF;
    modelStack.pop_back();
    --i;
  }
  // at this point, lit is the last decision
  modelStack.pop_back(); // remove the DL mark
  --decisionLevel;
  indexOfNextLitToPropagate = modelStack.size();
  setLiteralToTrue(-lit);  // reverse last decision
}


// Heuristic for finding the next decision literal:
int getNextDecisionLiteral(){

  int maxpriority = -1;
  int lit = 0;

  for (uint i = 0; i < V.size(); ++i){
    if (V[i] > maxpriority && model[i+1] == UNDEF){
      maxpriority = V[i];
      lit = neg[i] > pos[i] ? -i- 1 : +i+1;
    }
  }
  
  if (maxpriority == -1) return 0;
  else return lit;
}

void checkmodel(){
  for (uint i = 0; i < numClauses; ++i){
    bool someTrue = false;
    for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
      someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
    if (not someTrue) {
      cout << "Error in model, clause is not satisfied:";
      for (uint j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
      cout << endl;
      exit(1);
    }
  }  
}

int main(){ 
  readClauses(); // reads numVars, numClauses and clauses
  model.resize(numVars+1,UNDEF);
  indexOfNextLitToPropagate = 0;  
  decisionLevel = 0;

  // Take care of initial unit clauses, if any
  for (uint i = 0; i < numClauses; ++i)
    if (clauses[i].size() == 1) {
      int lit = clauses[i][0];
      int val = currentValueInModel(lit);
      if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
      else if (val == UNDEF) setLiteralToTrue(lit);
    }

  // DPLL algorithm
  while (true) {
    while ( propagateGivesConflict() ) {
      if ( decisionLevel == 0) { cout << "UNSATISFIABLE" << endl; return 10; }
      backtrack();
	  // In the case there's a backtrack, we shall set nextDecision to the first UNDEF symbol possible
	  //while (nextDecision >= 0 && model[V[nextDecision].first] == UNDEF) --nextDecision;
    }
    int decisionLit = getNextDecisionLiteral();
    if (decisionLit == 0) { checkmodel(); cout << "SATISFIABLE" << endl; return 20; }
    // start new decision level:
    modelStack.push_back(0);  // push mark indicating new DL
    ++indexOfNextLitToPropagate;
    ++decisionLevel;
    setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
  }
}  
