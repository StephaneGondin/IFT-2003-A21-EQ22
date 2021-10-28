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

valider_horizontale().
valider_diagonale().

% @Stephane Ma nouvelle fonction valider_verticale.
% valider_verticale(Colonne, CouleurJeton, ValeurHeuristique) 
% où Colonne est la colonne à valider verticalement, 
% CouleurJeton est la couleur du jeton à valider 
% et ValeurHeuristique est la valeur de l'heuristique à l'emplacement vide dans la colonne.
valider_verticale([], _, 1).
valider_verticale([X| _], Couleur, 1):- not(X == Couleur), !.
valider_verticale([X| Colonne], Couleur, ValeurHeuristique):- X == Couleur, valider_verticale(Colonne, Couleur, Val1), ValeurHeuristique is Val1 + 1.