%K: Boat capacity. 
%AM: The number of missionaries on bank A.
%AC: The number of cannibals on bank A. 
%BM: The number of missionaries on bank B.
%BC: The number of cannibals on bank B. 
%W: The location of the weapon. 
%B: The location of the boat.
%L: The state list, from the initial state to the goal state.

ferry(M,C,K):- state(K,M,C,0,0,1,1,[]).

state(K,AM,AC,BM,BC,W,B,L):- not(member([[AM,AC,BM,BC,W,B]],L)),
						append([[AM,AC,BM,BC,W,B]], L, L2),
						between(0,K,TM),
						between(0,K,TC),
						AM2 is AM-TM, AC2 is AC-TC, BM2 is BM+TM, BC2 is BC+TC,
						tempState(K, AM2, AC2, BM2, BC2, W, B, L2).


state(_,0,0,BM,BC,-1,-1,L).

tempState(K,AM,AC,BM,BC,W,B, L):- 
							legal(AM,AC,W, K), 
							legal(BM,BC,W, K), 
							moveWeapon(AM,AC,BM,BC, W, W2), 
							B2 is B*(-1),
							state(K, AM, AC, BM, BC, W2, B2,L2).

							
%tempState(_,0,0,BM,BC,-1,-1,L).					
							

legal(M,C,W, K):- ((M >= C, M >= 0, C >= 0) ; 
					(M==0, C >= 0) ; 
					(M > 0, C >= 0, W >0)), 
					legalBoat(M,C,K).

legalBoat(M,C,K):- (M >= C, M >= 0, C >= 0, M + C =< K) ; 
					(M==0, C > 0, K >= C).


moveWeapon(AM,AC,BM,BC, W, W2):- ((BM < BC, AM > AC) ; 
								(AM < AC, BM > BC)), 
								W2 is W*(-1).
