%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fais
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jeton(rouge).
jeton(jaune).
tableau(([[],[],[],[],[],[],[]])).

%États de départ et état final
etat_initial([[],[],[],[],[],[],[]]).
etat_final(). %???

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% colone X row    ( 7 x 6 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

etat_initialdeux(([['1','|','|','|','|','|'],
                        ['2','|','|','|','|','|'],
                        ['3','|','|','|','|','|'],
                        ['4','|','|','|','|','|'],
                        ['5','|','|','|','|','|'],
                        ['6','|','|','|','|','|'],
                        ['7','|','|','|','|','|']])).

%%%
%Appel
%
%%% etat_initialdeux(X).
%%%
%
montrer(tableau(X)):- voir(X).
montrer2(tableau(X)):- write('test de montrer').

voir(N):- write([N]),write(' : espace pour confimer le test').

readligne([],_).
readligne([X],N,X2):- write(N), write('fin '),readligne([X],X2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prédicats
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Place un jeton dans la colonne s'il y a une place disponible.
placer_jeton(Colonne, CouleurJeton, [ CouleurJeton | Colonne]):- valider_place_disponible(Colonne).

%Valider s'il reste de la place dans une colonne pour placer une pièce.
valider_place_disponible(Colonne):- length(Colonne, N), N < 7.


valider_verticale().
valider_horizontale().
valider_diagonale().

min().
max().
