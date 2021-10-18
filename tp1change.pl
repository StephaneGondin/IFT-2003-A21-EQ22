%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fais
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jeton(rouge).
jeton(jaune).

%États de départ et état final
etat_initial([[],[],[],[],[],[],[]]).
etat_final(). %???

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% colone X row    ( 7 x 6 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

etat_initialdeux(board([['|','|','|','|','|','|'],
                        ['|','|','|','|','|','|'],
                        ['|','|','|','|','|','|'],
                        ['|','|','|','|','|','|'],
                        ['|','|','|','|','|','|'],
                        ['|','|','|','|','|','|'],
                        ['|','|','|','|','|','|']])).



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
