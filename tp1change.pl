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
% Appel Du Jeux dans la fonction jeux . Le jeux se passe les colone et
% appelle les fonction du joeur a l'AI. Les condition de validation sont
% �galemen appel� dans la mouvement.
%
%
%%%

jeux:- etat_initial(Un,Deux,Trois,Quatre,Cinq,Six,Sept),
           voirboard(Un,Deux,Trois,Quatre,Cinq,Six,Sept),
           valider_place_disponible(Un).





voirboard(Un,Deux,Trois,Quatre,Cinq,Six,Sept):-voir(Un,'A'),voir(Deux,'B'),voir(Trois,'C'),voir(Quatre,'D'),voir(Cinq,'E'),voir(Six,'F'),voir(Sept,'G').

voir(X,Lettre):- write(X),write(Lettre),nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prédicats
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Place un jeton dans la colonne s'il y a une place disponible.
placer_jeton(Colonne, CouleurJeton, [ CouleurJeton | Colonne]):- valider_place_disponible(Colonne).

%Valider s'il reste de la place dans une colonne pour placer une pièce.
valider_place_disponible(Colonne):- length(Colonne, N), N < 7,write(N).


valider_verticale().
valider_horizontale().
valider_diagonale().

min().
max().
