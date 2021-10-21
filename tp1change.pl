%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fais
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jeton(rouge).
jeton(jaune).
tableau(([[],[],[],[],[],[],[]])).

%États de départ et état final
etat_initial([],[],[],[],[],[],[]).
etat_final(). %???

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% colone X row    ( 7 x 6 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

etat_initialdeux(['1','|','|','|','|','|'],
                        ['2','|','|','|','|','|'],
                        ['3','|','|','|','|','|'],
                        ['4','|','|','|','|','|'],
                        ['5','|','|','|','|','|'],
                        ['6','|','|','|','|','|'],
                        ['7','|','|','|','|','|']).

%%%
%Appel
%
%%% etat_initialdeux(X).
%%%
%
%
%
jeux:- etat_initialdeux(Un,Deux,Trois,Quatre,Cinq,Six,Sept),
           voirboard(Un,Deux,Trois,Quatre,Cinq,Six,Sept),
           valider_place_disponible(Un).

voirboard(Un,Deux,Trois,Quatre,Cinq,Six,Sept):-voir(Un),voir(Deux),voir(Trois),voir(Quatre),voir(Cinq),voir(Six),voir(Sept).

voir(X):- write(X),nl.
voir(N,Colone):- voir([N|Colone]),nl,write('non').

%voir(N,Colone):- realligne([X, 1]),nl,write('non').



readligne([],_).
readligne([X|Emplacement],[Colone|Info]):- write(X),nl, write('fin '),readligne(Emplacement,Info).

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
