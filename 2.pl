%K: Boat capacity. 
%AM: The number of missionaries on bank A.
%AC: The number of cannibals on bank A. 
%BM: The number of missionaries on bank B.
%BC: The number of cannibals on bank B. 
%W: The location of the weapon. 
%B: The location of the boat.
%L: The state list, from the initial state to the goal state.

ferry(M,C,K):- state(K,M,C,0,0,1,1,[]).
state(_,0,0,BM,BC,-1,-1,L):- append([[0,0,BM,BC,-1,-1]], L, L2),
							printHeadList(L2).
state(K,AM,AC,BM,BC,W,B,L):- not(member([AM,AC,BM,BC,W,B],L)),
						append([[AM,AC,BM,BC,W,B]], L, L2),
						between(0,K,TM),
						between(0,K,TC),
						AM2 is AM-TM, AC2 is AC-TC, BM2 is BM+TM, BC2 is BC+TC, 
						tempState(K, AM2, AC2, BM2, BC2, W, B, L2, S).




tempState(K,AM,AC,BM,BC,W,B, L, S):- 
							M is AM + BM, C is AC + BC,
							legal(AM,AC,W), 
							legal(BM,BC,W), 
							legalBoat(M,C,K, B, B2),
							(moveWeapon(AM,AC,BM,BC, W, W2) ; leaveWeapon(AM,AC,BM,BC, W, W2) ; getWeapon(AM,AC,BM,BC, W, W2)) , 
							printHeadList(L),
							state(K, AM, AC, BM, BC, W2, B2,L).
							

							
%tempState(_,0,0,BM,BC,-1,-1,L).					
							

legal(M,C,W):- ((M >= C, M >= 0, C >= 0) ; 
					(M==0, C >= 0) ; 
					(M > 0, C >= 0, W >0) ).

legalBoat(M,C,K, B, B2):- ((M >= C, M >= 0, C >= 0, M+C > 0, M + C =< K) ; 
					(M==0, C > 0, K >= C)), B2 is B*(-1).


moveWeapon(AM,AC,BM,BC, W, W2):- ((BM < BC, AM > AC) ; 
								(AM < AC, BM > BC)),
								W2 is W*(-1).
								
leaveWeapon(AM,AC,BM,BC, W, W2):- ((BC < BM, AC > AM) ; 
								(AC < AM, BC > BM); (AM = 0, AC = 0, W = -1)),
								W2 is W.

getWeapon(AM,AC,BM,BC, W, W2):- ((W == 1 , AM = 0, AC > 1) ; (W == 1 , BM = 0, BC > 1)), W2 is W*(-1).

printHeadList([H|L]):- print(H).

