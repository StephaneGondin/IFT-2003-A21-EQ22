%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fais
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jeton(rouge).
jeton(jaune).

%États de départ et état final
etat_initial([[],[],[],[],[],[],[]]).
etat_final(). %???

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prédicats
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Place un jeton dans la colonne s'il y a une place disponible.
placer_jeton(Colonne, CouleurJeton, [ CouleurJeton | Colonne]):- valider_place_disponible(Colonne).

%Valider s'il reste de la place dans une colonne pour placer une pièce.
valider_place_disponible(Colonne):- length(Colonne, N), N < 7.


valider_verticale(Colonne, CouleurJeton):- compter_verticale(Colonne, CouleurJeton, Valeur), Valeur == 4, write("Win:" + CouleurJeton).
valider_horizontale().
valider_diagonale().

compter_verticale([], _, Val):- writeln(Val).
compter_verticale([X| Colonne], CouleurJeton, Valeur):- X == CouleurJeton, Val1 is Valeur + 1, compter_verticale(Colonne, CouleurJeton, Val1).
compter_verticale([X| Colonne], CouleurJeton, Valeur):- not(X == CouleurJeton), writeln(Valeur), compter_verticale(Colonne, CouleurJeton, 0).

% Algo Alpha-Beta
% Voir https://silp.iiita.ac.in/wp-content/uploads/PROLOG.pdf
%Page 384

% alpha is the minimal value that MAX is already guaranteed to achieve
% From MAX percepective:
% beta is the maximal value that MAX can hope to achieve.
% From MIN percepctive:
% beta is the worst value for MIN that MIN is guaranteed to achieve.

alphabeta(Pos, Alpha, Beta, GoodPos, Val) :- 
    moves(Pos, PosList),
    !,
    boundedbest(PosList, Alpha, Beta, GoodPos, Val);
    staticval(Pos, Val).                                                  % Pos has no successors

boundedbest([Pos | PosList], Alpha, Beta, GoodPos, GoodVal) :-
    alphabeta(Pos, Alpha, Beta, _, Val),
    goodenough(PosList, Alpha, Beta, Pos, Val, GoodPos, GoodVal).

goodenough([], _, _, Pos, Val, Pos, Val) :- !.                             % No other candidate
goodenough(_, Alpha, Beta, Pos, Val, Pos, Val) :-
    min_to_move(Pos), Val > Beta, !;                                        % Maximizer attained upper bound
    max_to_move(Pos), Val < Alpha, !.                                       % Minimizer attained lower bound
goodenough(PosList, Alpha, Beta, Pos, Val, GoodPos, GoodVal) :-
    newbounds(Alpha, Beta, Pos, Val, NewAlpha, NewBeta),                   % Refine bounds
    boundedbest(PosList, NewAlpha, NewBeta, Pos1, Val1),
    betterof(Pos, Val, Pos1, Val1, GoodPos, GoodVal).

newbounds(Alpha, Beta, Pos, Val, Val, Beta) :-
    min_to_move(Pos), Val > Alpha, !.                                      % Maximizer increased lower bound
newbounds(Alpha, Beta, Pos, Val, Alpha, Val) :-
    max_to_move(Pos), Val < Beta, !.                                       % Minimizer decreased upper bound
newbounds(Alpha, Beta, _, _, Alpha, Beta).

betterof(Pos, Val, Pos1, Val1, Pos, Val) :-
    min_to_move(Pos), Val > Val1, !;
    max_to_move(Pos), Val < Val1, !.
betterof(_, _, Pos1, Val1, Pos1, Val1).

% % Corresponds to the legal-move rules of the game: PosList is the list of legal successor positions of Pos.
% % Assumed to fail if Pos is a terminal search position (a leaf of the search tree).
% moves(Pos, PosList).  
% min_to_move(Pos).
% max_to_move(Pos).
