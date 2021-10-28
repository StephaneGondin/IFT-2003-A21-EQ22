%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fais
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
jeton(rouge).
jeton(jaune).
tableau(([[],[],[],[],[],[],[]])).

%Ã‰tats de dÃ©part et Ã©tat final
etat_initial([],[],[],[],[],[],[]).
etat_final(). %???

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% colone X row    ( 7 x 6 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


%%%
% Appel Du Jeux dans la fonction jeux . Le jeux se passe les parametres
% colonne et appelle les fonctions du joueur a l'IA. Les conditions de
% validation sont également appelées dans le mouvement.
%
% paramètre a envoyer : 7 colonnes
%%%

jeux:- etat_initial(Un,Deux,Trois,Quatre,Cinq,Six,Sept),write('     PROLOG     '),
                                                    nl,nl,write('    EQUIPE 22     '),nl,nl,write('   ____________    '),
                                                    nl,nl,jeux_recurrent(Un,Deux,Trois,Quatre,Cinq,Six,Sept).

      %     voirboard(Un,Deux,Trois,Quatre,Cinq,Six,Sept),
       %    question_utilisateur(Reponse),
       %    swap(Un,Deux,Trois,Quatre,Cinq,Six,Sept,Reponse,Retour),
       %    voir(Retour,' retour 1 fois'),
       %    valider_place_disponible(Retour),
       %    placer_jeton(Retour,jeton(rouge),Resultat),
       %    write(Resultat).




jeux_recurrent(C1,C2,C3,C4,C5,C6,C7):-%voirboard(C1,C2,C3,C4,C5,C6,C7),
                                                  %fonction tour utilisateur
                                                    question_utilisateur(Reponse),

                                                    swap(C1,C2,C3,C4,C5,C6,C7,Reponse,Retour),%write(Retour),
                                                    placer_jeton(Retour,['R'],Envoie_A_AI),
                                                    transfert_AI(C1,C2,C3,C4,C5,C6,C7,Reponse,Envoie_A_AI).
                                                    %jeux_recurrent(Envoie_A_AI,C2,C3,C4,C5,C6,C7).

                                                  %fonction Ai
                                                    %valider_place_disponible(Retour),

                                                    %placer_jeton(Retour,jeton(rouge),Resultat),
                                                    %write(Retour),write(Resultat),write(Reponse),
                                                    %replace_list(Deux,Resultat),
                                                    %write(Retour),write(Resultat).
                                                    %replace_list(Resultat,Retour),
                                                    %voir(Resultat,'resultat insertion'),
                                                    %voir(Resultat,'retour ').

                                                   %jeux_recurrent(Un,Deux,Trois,Quatre,Cinq,Six,Sept).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Interface visuelle de base
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

voirboard(Un,Deux,Trois,Quatre,Cinq,Six,Sept):-voir(Un,'1'),voir(Deux,'2'),voir(Trois,'3'),voir(Quatre,'4'),
                                                    voir(Cinq,'5'),voir(Six,'6'),voir(Sept,'7').

voir(X,Lettre):- write(X),write(Lettre),nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Swap semble long comme fonction, mais elle est bien simple. Elle
% recoit les colonnes en parametres. Elle recoit le parametre Y, qui
% proviens de l'utilisateur (un '1','2',etc) et retourne la colone dans
% Retour. On fait afficher la ligne grace a voir pour avoir un visuel.
% ex: Si Y==1 , Retour sera l'équivalent de la Liste C1
% ==== Elle nous permet a partir de chiffre de selectionner les
% colonne, le ! arrete la fonction apres avoir trouvé le Y, sans
% continuer dans la recherche vu que c'est des ou=
%
swap(C1,C2,C3,C4,C5,C6,C7,Y,Retour):- Y==1,replace_list(C1,Retour),!;Y==2,replace_list(C2,Retour),!;Y==3,
                                                    replace_list(C3,Retour),!;Y==4,replace_list(C4,Retour),!;Y==5,
                                                    replace_list(C5,Retour),!;Y==6,replace_list(C6,Retour),!;Y==7,
                                                    replace_list(C7,Retour),!.


%%%%%%%%%%%%%%%%%%%
%ZONE AI
%
%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transfert_Ai est similaire a swap, elle transfert à l'AI la matrice
% modifié plutot que le parametre C% original. Ca permet la recursivite
% de continuer. Retour est envoye a différent endroit selon le parametre
% Y. ! arrete la recherche.
transfert_AI(C1,C2,C3,C4,C5,C6,C7,Y,Retour):- Y==1,jeux_AI(Retour,C2,C3,C4,C5,C6,C7),!;Y==2,jeux_AI(C1,Retour,C3,C4,C5,C6,C7),!;Y==3,
                                                    jeux_AI(C1,C2,Retour,C4,C5,C6,C7),!;Y==4,jeux_AI(C1,C2,C3,Retour,C5,C6,C7),!;Y==5,
                                                    jeux_AI(C1,C2,C3,C4,Retour,C6,C7),!;Y==6,jeux_AI(C1,C2,C3,C4,C5,Retour,C7),!;Y==7,
                                                    jeux_AI(C1,C2,C3,C4,C5,C6,Retour),!.


%%%%%%%%%%%%
%Fonction du tour è l'ordinateur
%
%
%%%%%%

jeux_AI(C1,C2,C3,C4,C5,C6,C7):-voirboard(C1,C2,C3,C4,C5,C6,C7),
                               min(C1,C2,C3,C4,C5,C6,C7,Test,'J',ListeResultat),
                               replace_list(C1,Liste_Jeux_AI),%choix emplacement Ai, foncion minmax choisi ici
                               placer_jeton(Liste_Jeux_AI,['J'],Temporaire),  %Temporaire est une liste contenant le choix de l'AI par min max
                               append([],[Temporaire,C2,C3,C4,C5,C6,C7],Matrice),   % a modifier, mais cette ligne devra envoyer dans
                                                                                   % la matrice le choix selon la colone choisie
                               nl,voir(Matrice,'La matrice :  '),nl,   % vision, a enlever
                               %compter_verticale('J',Temporaire,Zero),Zeros is Zero,write(Zeros),   %fonction inclus de min max, sera enlever
                               vgagne('R',Matrice),  %validation de qui gagne
                               vgagne('J',Matrice),   %validation
                               %write(Temporaire),  % a enlever
                               jeux_recurrent(Temporaire,C2,C3,C4,C5,C6,C7).  % on va envoyer selon ce que l'ai a choisi


vgagne(Couleur,Mat):-
                              append(_, [Colonne|_], Mat),
                              append(_,[Couleur,Couleur,Couleur,Couleur|_],Colonne),write('Ce joeur a gagne:'),
                              nl,write(Couleur),nl,write('Félicitations'),nl,abort.

vgagne(Couleur,Mat):-
                              append(_,[Colonne1,Colonne2,Colonne3,Colonne4|_],Mat),
                              append(Vide1,[Couleur|_],Colonne1),
                              append(Vide2,[Couleur|_],Colonne2),
                              append(Vide3,[Couleur|_],Colonne3),
                              append(Vide4,[Couleur|_],Colonne4),
                              (length(Vide1,N), length(Vide2,N), length(Vide3,N), length(Vide4,N)),write('Ce joeur a gagne:'),
                              nl,write(Couleur),nl,write('Félicitations'),nl,nl,abort;nl.



vgagne(Couleur,Mat):-
                 append(_,[Colonne1,Colonne2,Colonne3,Colonne4|_],Mat),
                 append(Vide1,[Couleur|_],Colonne1),write('vid1'),

                 append(Vide2,[Couleur|_],Colonne2),write('vid1'),
                 append(Vide3,[Couleur|_],Colonne3),write('vid1'),
                 append(Vide4,[Couleur|_],Colonne4),write('vid1'),
                 length(Vide1,Mat1), length(Vide2,Mat2),
                 length(Vide3,Mat3), length(Vide4,Mat4),
                 Mat2 is Mat1+1, Mat3 is Mat2+1, Mat4 is Mat3+1,write('victoire');
                 Mat2 is Mat1-1, Mat3 is Mat2-1, Mat4 is Mat3-1,write('victoire').





                 %
                 %
                 %
%%%%%%%%%%%%%%%%%%%%%%%%
%Questioner l'utilisateur sur son emplacement a mettre
% Parametre a prendre en charges: reponse utilisateur, retourne la
% colone. 1 a 7 seulement considere.
% La fonction verifier reponse s'assurer que la reponse correspond au
% bon parametre et ensuite affiche la reponse au client. Si ce n'est pas
% le cas, elle echoue et on obtient un false.
% %%%%%%%%%%%%%%%%%%%%%%%%%%

question_utilisateur(Reponse):-write('Placer votre pièce: reponse sous forme 1. 2. 3. 4. 5. 6. 7.'),nl,
                                                    write(' Tout autre reponse arrete le jeu:'),nl,read(Reponse),verifier_reponse(Reponse).

verifier_reponse(Reponse):-((Reponse=1);(Reponse=2);(Reponse=3);
                           (Reponse=4);(Reponse=5);(Reponse=6);(Reponse=7)),
                           write('votre reponse:'),write(Reponse),nl,nl;abort.



%%%%%%%%%%%%%%%%%%%
%Fonction de remplacement de liste et de concenation de listes
%Remplace une liste par une autre et concatene une liste
%%%%%%%
replace_list([], []).
replace_list([n|X], [a|Y]) :- replace_list(X, Y).
replace_list([H|X], [H|Y]) :- H \= n, replace_list(X, Y).

conc([], L, L).
conc([X|R1], L2, [X|R3]):- conc(R1, L2, R3).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Placer_Jeton fonction qui place un jeton si il reste de la place sinon
% retourne false pour le moment.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Place un jeton dans la colonne s'il y a une place disponible.
placer_jeton(Colonne,Jeton,Resultat):-conc(Colonne,Jeton,Resultat),valider_place_disponible(Colonne).

%Valider s'il reste de la place dans une colonne pour placer une piÃ¨ce.
%retourne true ou false
valider_place_disponible(Colonne):- length(Colonne, N), N < 7.%write('pieces dans la colone avant ajout: '),write(N),nl,nl.



valider_verticale(Colonne, CouleurJeton):- compter_verticale(Colonne,
                                           CouleurJeton, Valeur), Valeur == 4, write("Win:" + CouleurJeton).


% @Stephane Ma nouvelle fonction valider_verticale.
% valider_verticale(Colonne, CouleurJeton, ValeurHeuristique)
% où Colonne est la colonne à valider verticalement,
% CouleurJeton est la couleur du jeton à valider
% et ValeurHeuristique est la valeur de l'heuristique à l'emplacement vide dans la colonne.
valider_horizontale().
valider_diagonale().

compter_verticale(_,[],0).
% compter_verticale(Joueur,[_|ValeurTrouve],1):- not(ValeurTrouve ==
% Joueur).
compter_verticale(Joueur,[_|ValeurTrouve],Valeur):- %compter_verticale(Joueur,Colonne,ValeurS),
			  Valeur is ValeurS+1,write(ValeurS).

%  Fonction membre de la liste, retourne vrai se il y a une membre dans
%  la liste.
%
%membre2(X,[X|R]).
%membre2(X,[Y|R]):- not(X=Y), membre2(X,R).

%Fonction inverse la liste. Vu que l'on doit lire parfois le dernier
%  entré dans la liste, c'est pratique.
%   Appel : inverse([a,b,c],X,[]).  Body sera le resultat.

inverse([],[],[]).
inverse([],Body,Body).
inverse([Head|Tail],Body,Acc) :- inverse(Tail,Body,[Head|Acc]).


% compter_verticale(Joueur,[Joueur|Colonne],Valeur):-
% compter_verticale(Joueur,Colonne,ValeurS),
			 % Valeur is ValeurS+1.

min(M1,M2,M3,M4,M5,M6,M7,Value,Couleur,ListeResultat):-
                            inverse(M1,X,[]),valider_verticale(X,Couleur,Val1),nl,append([],['C1',Val1],ListeResultat),nl,write(Val1),
                                      append([],[Val1],Mat1), !,
                            inverse(M2,X2,[]),valider_verticale(X2,Couleur,Val2),nl,append(['C2',Val2],ListeResultat,ListeResultat2),write(Val2),
                                      append([Val2],Mat1,Mat2),!,
                            inverse(M3,X3,[]),valider_verticale(X3,Couleur,Val3),nl,append(['C3',Val3],ListeResultat2,ListeResultat3),write(Val3),
                                       append([Val3],Mat2,Mat3),!,
                            inverse(M4,X4,[]),valider_verticale(X4,Couleur,Val4),nl,append(['C4',Val4],ListeResultat3,ListeResultat4),write(Val4),
                                       append([Val4],Mat3,Mat4),!,
                            inverse(M5,X5,[]),valider_verticale(X5,Couleur,Val5),nl,append(['C5',Val5],ListeResultat4,ListeResultat5),write(Val5),
                                       append([Val5],Mat4,Mat5),!,
                            inverse(M6,X6,[]),valider_verticale(X6,Couleur,Val6),nl,append(['C6',Val6],ListeResultat5,ListeResultat6),write(Val6),
                                       append([Val6],Mat5,Mat6),!,
                                       inverse(M7,X7,[]),valider_verticale(X7,Couleur,Val7),nl,append(['C7',Val7],ListeResultat6,ListeResultat7),                                          append([Val7],Mat6,Mat7) ,write(ListeResultat7),nl,write(Mat7),
                             largest(Mat7,0,Retour),write(Retour).

%

largest([X|Xs], Retour) :- largest(Xs, X, Retour).

largest([], Retour, Retour).
largest([X|Xs], Mat, Retour) :-
    Mat1 is max(X, Mat),
    largest(Xs, Mat1, Retour).


            %posverticale(Couleur,M1,0,Sorties);nl,nl,write('valeur de position:'),nl,write(Sorties),nl.
max().



% valider_verticale(X,Colone,Valeur) retourne le nombre d'instance en
% debut de liste identique pour l'heuristique selon la couleur X.
% La Valeur est l'heuristique.
% Cette fonction est joint a la fonction d'inversion de liste pour
% avoir les entres en debut.
%
%



valider_verticale([], _, 1).
valider_verticale([X| _], Couleur, 1):- not(X == Couleur), !.
valider_verticale([X| Colonne], Couleur, ValeurHeuristique):- X == Couleur, valider_verticale(Colonne, Couleur, Val1), ValeurHeuristique is Val1 + 1.
