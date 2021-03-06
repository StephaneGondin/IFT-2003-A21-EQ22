% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Fais
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % jeton(rouge).
% % jeton(jaune).

% %États de départ et état final
% etat_initial([[],[],[],[],[],[],[]]).
% etat_final(). %???

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Prédicats
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Place un jeton dans la colonne s'il y a une place disponible.
% placer_jeton(Colonne, CouleurJeton, [ CouleurJeton | Colonne]):- valider_place_disponible(Colonne).

% %Valider s'il reste de la place dans une colonne pour placer une pièce.
% valider_place_disponible(Colonne):- length(Colonne, N), N < 7.

% valider_horizontale().
% valider_diagonale().

% % @Stephane Ma nouvelle fonction valider_verticale.
% % valider_verticale(Colonne, CouleurJeton, ValeurHeuristique)
% % où Colonne est la colonne à valider verticalement,
% % CouleurJeton est la couleur du jeton à valider
% % et ValeurHeuristique est la valeur de l'heuristique à l'emplacement vide dans la colonne.
% valider_verticale([], _, 1).
% valider_verticale([X| _], Couleur, 1):- not(X == Couleur), !.
% valider_verticale([X| Colonne], Couleur, ValeurHeuristique):- X == Couleur, valider_verticale(Colonne, Couleur, Val1), ValeurHeuristique is Val1 + 1.

% % Valider horizontale
% % vh([[],[rouge],[rouge],[rouge],[],[],[]], [], rouge, H).
% % vh(Matrice, Colonne, Couleur, ValeurHeuristique).

% piece(1,1,rouge).
% piece(2,1,rouge).
% piece(3,1,rouge).
% piece(4,1,rouge).



% traverse(C,R,IncC,IncR,Res):-
%     NewC is C + IncC,
%     NewR is R + IncR,
%     piece(C,R,C1),
%     piece(NewC,NewR,C2),
%     C1 == C2,
%     traverse(NewC,NewR,IncC,IncR,Res1),
%     Res is Res1 + 1,!.
% traverse(_,_,_,_,Res):-
%  Res is 1.
% %Horzintal Check
% check(X,Y):-
%  traverse(X,Y,1,0,R1),
%  traverse(X,Y,-1,0,R2),
%  R is R1 + R2 - 1  ,
%  R >= 4,!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- dynamic jeton/3. %Permet de définir dynamiquement des jetons

% Placer un jeton.
% Permet de le placer en mémoire comme "fait" et non dans une matrice.
%TODO: Mettre une limite pour colonne (entre 1 à 7).
placer(Colonne, Couleur):- hauteur_colonne(Colonne, Hauteur), assert(jeton(Colonne, Hauteur, Couleur)).

hauteur_colonne(Colonne, Hauteur):- findall(_, jeton(Colonne, _, _), Res), length(Res, Hauteur).

rst():- retractall(jeton(_,_,_)).

%Permet de parcourir en ligne droite (selon les directions en paramètre) les jeton de même couleur et de retourner le nombre de jeton de la même couleur parcouru.
parcourir(Colonne, Ligne, DirectionColonne, DirectionLigne, Nb):-
    ProchaineColonne is Colonne + DirectionColonne,
    ProchaineLigne is Ligne + DirectionLigne,
    jeton(Colonne,Ligne, Couleur1),
    jeton(ProchaineColonne, ProchaineLigne, Couleur2),
    Couleur1 == Couleur2,
    parcourir(ProchaineColonne, ProchaineLigne, DirectionColonne, DirectionLigne, Nb1),
    Nb is Nb1 + 1, !.
parcourir(_,_,_,_,Nb):-
	Nb is 1.

%Valider si gagnant
% TODO: Regarder comment le faire par couleur de jeton. Oubtenir la couleur du jeton gagnant.
% Horizontale
valider(Colonne, Ligne):-
    parcourir(Colonne, Ligne, 1, 0, Nb1),
    parcourir(Colonne, Ligne, -1, 0, Nb2),
    Nb is Nb1 + Nb2 -1,
    Nb >= 4, !.
% Verticale
valider(Colonne, Ligne):-
    parcourir(Colonne, Ligne, 0, 1, Nb1),
    parcourir(Colonne, Ligne, 0, -1, Nb2),
    Nb is Nb1 + Nb2 -1,
    Nb >= 4, !.
% Diagonale 1
valider(Colonne, Ligne):-
    parcourir(Colonne, Ligne, 1, 1, Nb1),
    parcourir(Colonne, Ligne, -1, -1, Nb2),
    Nb is Nb1 + Nb2 -1,
    Nb >= 4, !.
% Diagonale 2
valider(Colonne, Ligne):-
    parcourir(Colonne, Ligne, 1, -1, Nb1),
    parcourir(Colonne, Ligne, -1, 1, Nb2),
    Nb is Nb1 + Nb2 -1,
    Nb >= 4, !.

% Calculer valeur heuristique
% TODO: Regarder comment le faire par couleur de jeton.
% TODO: Reste quelques petit bug à régler.
calculer(Colonne, ValeurHeuristique):-
    %Verticale
    %TODO: Doit regarder ligne en dessous.
    hauteur_colonne(Colonne, Ligne),
    parcourir(Colonne, Ligne, 0, -1, ValeurHeuristiqueVerticaleTmp),
    ValeurHeuristiqueVerticale is ValeurHeuristiqueVerticaleTmp + 1,
    %Horizontale
    parcourir(Colonne, Ligne, 1 ,0, ValeurHeuristiqueHorizontaleDroite),
    parcourir(Colonne, Ligne, -1 ,0, ValeurHeuristiqueHorizontaleGauche),
    ValeurHeuristiqueHorizontale is ValeurHeuristiqueHorizontaleDroite + ValeurHeuristiqueHorizontaleGauche -1,
    %Diagonale 1
    parcourir(Colonne, Ligne, 1,1, ValHeuristiqueDiagonale1Droite),
    parcourir(Colonne, Ligne, -1,-1, ValHeuristiqueDiagonale1Gauche),
    ValHeuristiqueDiagonale1 is ValHeuristiqueDiagonale1Droite + ValHeuristiqueDiagonale1Gauche -1,
    %Diagonale 2
    parcourir(Colonne, Ligne, 1,-1, ValHeuristiqueDiagonale2Droite),
    parcourir(Colonne, Ligne, -1,1, ValHeuristiqueDiagonale2Gauche),
    ValHeuristiqueDiagonale2 is ValHeuristiqueDiagonale2Droite + ValHeuristiqueDiagonale2Gauche -1,
    %Obtenir la plus grande valeur
    max_list([ValeurHeuristiqueVerticale, ValeurHeuristiqueHorizontale, ValHeuristiqueDiagonale1, ValHeuristiqueDiagonale2], ValeurHeuristique).


%%%%%%%%%%%%%%%%%%
% Jeux d'essais pour faciliter tests.
%%%%%%%%%%%%%%%%%%
placer_ligneV2(Colonne):-
    placer(Colonne,r),
    placer(Colonne,r).

placer_ligneV3(Colonne):-
    placer(Colonne,r),
    placer(Colonne,r),
    placer(Colonne,r).

placer_ligneV4(Colonne):-
    placer(Colonne,r),
    placer(Colonne,r),
    placer(Colonne,r),
    placer(Colonne,r).

placer_ligneH2():-
    placer(1,r),
    placer(2,r).

placer_ligneH3():-
    placer(1,r),
    placer(2,r),
    placer(3,r).

placer_ligneH4():-
    placer(1,r),
    placer(2,r),
    placer(3,r),
    placer(4,r).

placer_diag2():-
    placer(1,r),
    placer(2,j),
    placer(2,r).

placer_diag3():-
    placer(1,r),
    placer(2,j),
    placer(2,r),
    placer(3,j),
    placer(3,j),
    placer(3,r).

placer_diag4():-
    placer(1,r),
    placer(2,j),
    placer(2,r),
    placer(3,j),
    placer(3,j),
    placer(3,r),
    placer(4,j),
    placer(4,j),
    placer(4,j),
    placer(4,r).
