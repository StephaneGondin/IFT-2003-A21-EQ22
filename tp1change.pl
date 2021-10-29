%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fais Équipe 22, projet prolog
%LEVIG3
%STGRO17
%VIPLO8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Etat initial
%
% colone X row    ( 7 x 6 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%



etat_initial([],[],[],[],[],[],[]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Etat final
% Un joeur a gagné ou le jeux s'arrête
%
%


etat_final():-nl,write('Arret du jeux'),abort.
etat_final(Joueur):- write('Le joueur suivant a gagné'),nl,nl,write(Joueur).


%%%
% Appel Du Jeux dans la fonction jeux . Le jeux se passe les parametres
% colonne et appelle les fonctions du joueur a l'IA. Les conditions de
% validation sont également appelées dans le mouvement.
%
% paramètre a envoyer : 7 colonnes
%
% Ce prédicat est ESSENTIEL, car il démarre le jeux.
%
%
% Appel du Jeux :    jeux.
%
% Les
%
%%%

jeux:- etat_initial(Un,Deux,Trois,Quatre,Cinq,Six,Sept),
       write('     PROLOG     '),
       nl,nl,
       write('    EQUIPE 22   '),
       nl,nl,
       write('  ____________ '),
       nl,nl,
       jeux_recurrent(Un,Deux,Trois,Quatre,Cinq,Six,Sept).



jeux_recurrent(C1,C2,C3,C4,C5,C6,C7):-            voirboard(C1,C2,C3,C4,C5,C6,C7),
                                                  %fonction tour utilisateur
                                                    question_utilisateur(Reponse),

                                                    swap(C1,C2,C3,C4,C5,C6,C7,Reponse,Retour),%write(Retour),
                                                    placer_jeton(Retour,['R'],Envoie_A_AI),
                                                    transfert_AI(C1,C2,C3,C4,C5,C6,C7,Reponse,Envoie_A_AI).
                                                    %jeux_recurrent(Envoie_A_AI,C2,C3,C4,C5,C6,C7).


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
                               %heuristique(C1,C2,C3,C4,C5,C6,C7,ValeurHeuristiqueMin,'J',ColoneFinaleMin),
                               %nl,nl,write(ValeurHeuristiqueMin),nl,write(ColoneFinaleMin),
                               %heuristique(C1,C2,C3,C4,C5,C6,C7,ValeurHeuristiqueMax,'R',ColoneFinaleMax),
                               %nl,nl,write(ValeurHeuristiqueMax),nl,write(ColoneFinaleMax),
                               choixdeminmax(C1,C2,C3,C4,C5,C6,C7,ColonneFinale),
                               nl,write('choix'),nl,write(ColonneFinale),
                               %replace_list(C1,Liste_Jeux_AI),%choix emplacement Ai, foncion minmax choisi ici
                               swap(C1,C2,C3,C4,C5,C6,C7,ColonneFinale,Liste_Jeux_AI),
                               placer_jeton(Liste_Jeux_AI,['J'],Temporaire),!,  %Temporaire est une liste contenant le choix de l'AI par min max
                               transfert_A_Matrice(C1,C2,C3,C4,C5,C6,C7,ColonneFinale,Temporaire),




                               append([],[Temporaire,C2,C3,C4,C5,C6,C7],Matrice),   % a modifier, mais cette ligne devra envoyer dans
                                                                                   % la matrice le choix selon la colone choisie
                               nl,voir(Matrice,'La matrice :  '),nl,   % vision, a enlever
                               %compter_verticale('J',Temporaire,Zero),Zeros is Zero,write(Zeros),   %fonction inclus de min max, sera enlever
                               vgagne('R',Matrice),  %validation de qui gagne
                               vgagne('J',Matrice),   %validation
                               write(Temporaire),  % a enlever
                               jeux_recurrent(C1,C2,C3,C4,C5,C6,C7).  % on va envoyer selon ce que l'ai a choisi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transfert_A_matrice est similaire a prepale le tranfert, elle
% transfert à l'AI la matrice modifié plutot que le parametre C%
% original. Ca permet la recursivite de continuer. Retour est envoye a
% différent endroit selon le parametre Y. ! arrete la recherche.
transfert_A_Matrice(C1,C2,C3,C4,C5,C6,C7,Y,Retour):-
                                       Y==1,
                                       append([],[Retour,C2,C3,C4,C5,C6,C7],Matrice),vgagne('R',Matrice),vgagne('J',Matrice),
                                       jeux_recurrent(Retour,C2,C3,C4,C5,C6,C7),!;
                                       Y==2,
                                       append([],[C1,Retour,C3,C4,C5,C6,C7],Matrice),vgagne('R',Matrice),vgagne('J',Matrice),
                                       jeux_recurrent(C1,Retour,C3,C4,C5,C6,C7),!;
                                       Y==3,
                                       append([],[C1,C2,Retour,C4,C5,C6,C7],Matrice),vgagne('R',Matrice),vgagne('J',Matrice),
                                       jeux_recurrent(C1,C2,Retour,C4,C5,C6,C7),!;
                                       Y==4,
                                       append([],[C1,C2,C3,Retour,C5,C6,C7],Matrice),vgagne('R',Matrice),vgagne('J',Matrice),
                                       jeux_recurrent(C1,C2,C3,Retour,C5,C6,C7),!;
                                       Y==5,
                                       append([],[C1,C2,C3,C4,Retour,C6,C7],Matrice),vgagne('R',Matrice),vgagne('J',Matrice),
                                       jeux_recurrent(C1,C2,C3,C4,Retour,C6,C7),!;
                                       Y==6,
                                       append([],[C1,Retour,C3,C4,C5,Retour,C7],Matrice),vgagne('R',Matrice),vgagne('J',Matrice),
                                       jeux_recurrent(C1,C2,C3,C4,C5,Retour,C7),!;
                                       Y==7,
                                       append([],[C1,C2,C3,C4,C5,C6,Retour],Matrice),vgagne('R',Matrice),vgagne('J',Matrice),
                                       jeux_recurrent(C1,C2,C3,C4,C5,C6,Retour),!.








%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vgagné est la verification de nos conditions de victoire.
%
% Nous avons comme parametre d'entrée une matrice dans le programme append([],[Temporaire,C2,C3,C4,C5,C6,C7],Matrice),
%
% Vgagné prend cette matrice, et verifie les verticale et les diagonale.
%
% En parametre d'entre nous avons la Couleur, et la Matrice.
% Nous avons 3 verificaitons de vgagne /3. Une horizontal, une verticale
% et une en diagonale.
%
% Nous nous basons sur la longueur des liste généré pour trouver si les
% circonstances sont remplies.
%
% en cas de victoire, nous arretons le programme.
%


vgagne(Couleur,Mat):-
                              append(_, [Colonne|_], Mat),
                              append(_,[Couleur,Couleur,Couleur,Couleur|_],Colonne),
                              write('Ce joeur a gagne:'),
                              nl,write(Couleur),nl,write('Félicitations'),nl,abort.

vgagne(Couleur,Mat):-
                              append(_,[Colonne1,Colonne2,Colonne3,Colonne4|_],Mat),
                              append(Vide1,[Couleur|_],Colonne1),
                              append(Vide2,[Couleur|_],Colonne2),
                              append(Vide3,[Couleur|_],Colonne3),
                              append(Vide4,[Couleur|_],Colonne4),
                              (length(Vide1,N), length(Vide2,N), length(Vide3,N), length(Vide4,N)),
                              write('Ce joeur a gagne:'),
                              nl,write(Couleur),nl,write('Félicitations'),nl,nl,abort;nl.



vgagne(Couleur,Mat):-
                              append(_,[Colonne1,Colonne2,Colonne3,Colonne4|_],Mat),
                              append(Vide1,[Couleur|_],Colonne1),

                              append(Vide2,[Couleur|_],Colonne2),
                              append(Vide3,[Couleur|_],Colonne3),
                              append(Vide4,[Couleur|_],Colonne4),
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
%
% C'est essentiellement un lecture au clavier, avec une verification si
% l'utilisateur a bien entrée les bonnes réponses.
% %%%%%%%%%%%%%%%%%%%%%%%%%%

question_utilisateur(Reponse):-write('Placer votre pièce: reponse sous forme 1. 2. 3. 4. 5. 6. 7.'),nl,
                                                    write(' Tout autre reponse arrete le jeu:'),nl,read(Reponse),verifier_reponse(Reponse).

verifier_reponse(Reponse):-((Reponse=1);(Reponse=2);(Reponse=3);
                           (Reponse=4);(Reponse=5);(Reponse=6);(Reponse=7)),
                           write('votre reponse:'),write(Reponse),nl,nl;etat_final().



%%%%%%%%%%%%%%%%%%%
%Fonction de remplacement de liste et de concenation de listes
%Remplace une liste par une autre et concatene une liste
%
%paramètre d'entré: une liste
%paramètre de sortie : une liste remplacée
%%%%%%%
replace_list([], []).
replace_list([n|X], [a|Y]) :- replace_list(X, Y).
replace_list([H|X], [H|Y]) :- H \= n, replace_list(X, Y).



%%%%%%%%%%%%%%%%%%%
%Fonction de concaténation de liste
%Remplace une liste par une autre et concatene une liste
%%%%%%%


conc([], L, L).
conc([X|R1], L2, [X|R3]):- conc(R1, L2, R3).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Placer_Jeton fonction qui place un jeton si il reste de la place sinon
% retourne false pour le moment.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Place un jeton dans la colonne s'il y a une place disponible.
%
% Paramètre d'entré : Colonne et Jeton
% Paramètre de sortie : une Liste resultat à jour avec l'entrée ajoutée.
placer_jeton(Colonne,Jeton,Resultat):-conc(Colonne,Jeton,Resultat),valider_place_disponible(Colonne);nl,
                                                             write('Impossible d ''ajouter une pièce, le tour est perdu.'),true.

%!%%%
%Validation
%%%% Valider s'il reste de la place dans une colonne pour placer une
% pièce. retourne true ou false
valider_place_disponible(Colonne):- length(Colonne, N), N < 7.%write('pieces dans la colone avant ajout: '),write(N),nl,nl.



% valider_verticale(Colonne, CouleurJeton):- compter_verticale(Colonne,
  %                                         CouleurJeton, Valeur), Valeur == 4, write("Win:" + CouleurJeton).


% @Stephane Ma nouvelle fonction valider_verticale.
% valider_verticale(Colonne, CouleurJeton, ValeurHeuristique)
% où Colonne est la colonne à valider verticalement,
% CouleurJeton est la couleur du jeton à valider
% et ValeurHeuristique est la valeur de l'heuristique à l'emplacement vide dans la colonne.
valider_horizontale().
valider_diagonale().

%Fonction inverse la liste. Vu que l'on doit lire parfois le dernier
%  entré dans la liste, c'est pratique.
%   Appel : inverse([a,b,c],X,[]).  Body sera le resultat.

inverse([],[],[]).
inverse([],Body,Body).
inverse([Head|Tail],Body,Acc) :- inverse(Tail,Body,[Head|Acc]).


% Fonction qui calcule notre valeur heuristique de chaque colonnes
% Nous avons besoin des 7 colonnes en entrées, le parametres
% Valeurheuristique est retournées au client et la couleurs est un
% parametre d'entrée. ColonneFinale sera retourné aussi.
%
% Les parametres de retour sont  : Valeurheuristique et ColonneFinale.
%
% Les parametre d'entrées sont : 7 Liste (M1,M2,M3,M4,M5,M6,M7,) et la
% Couleur.
%
% Cette fonction est automatiquement appelé par le programme jeux.
%




heuristique(M1,M2,M3,M4,M5,M6,M7,Valeurheuristique,Couleur,ColoneFinale):-
                            inverse(M1,X,[]),valider_verticale(X,Couleur,Val1),
                                      append([[1,Val1]],[],LR),
                                      append([],[Val1],Mat1), !,
                            inverse(M2,X2,[]),valider_verticale(X2,Couleur,Val2),
                                      append([[2,Val2]],LR,LR2),
                                      append([Val2],Mat1,Mat2),!,
                            inverse(M3,X3,[]),valider_verticale(X3,Couleur,Val3),
                                       append([[3,Val3]],LR2,LR3),
                                       append([Val3],Mat2,Mat3),!,
                            inverse(M4,X4,[]),valider_verticale(X4,Couleur,Val4),
                                       append([[4,Val4]],LR3,LR4),
                                       append([Val4],Mat3,Mat4),!,
                            inverse(M5,X5,[]),valider_verticale(X5,Couleur,Val5),
                                       append([[5,Val5]],LR4,LR5),
                                       append([Val5],Mat4,Mat5),!,
                            inverse(M6,X6,[]),valider_verticale(X6,Couleur,Val6),
                                       append([[6,Val6]],LR5,LR6),
                                       append([Val6],Mat5,Mat6),!,
                            inverse(M7,X7,[]),valider_verticale(X7,Couleur,Val7),
                                       append([[7,Val7]],LR6,LR7),
                                        append([Val7],Mat6,Mat7),!,
                            largest(Mat7,0,Retour),member([EmplacementMin,Retour],LR7),Valeurheuristique=Retour,ColoneFinale=EmplacementMin.



% Fonction prend les listes de colonnes
% Nous avons besoin des 7 colonnes en entrées et la couleurs est un
% parametre d'entrée.le parametres
% ColonneFinale est retournées au client . ValeurHeuristique sera retourné
% aussi.
%
% Les parametres de retour sont  : ColonneFinale.
%
% Les parametre d'entrées sont : 7 Liste (M1,M2,M3,M4,M5,M6,M7,)
%
% Cette fonction est automatiquement appelé par le programme jeux.
%



choixdeminmax(C1,C2,C3,C4,C5,C6,C7,ColonneFinale):-
                               heuristique(C1,C2,C3,C4,C5,C6,C7,ValeurHeuristiqueMin,'R',ColoneFinaleMin),!,
                               nl,nl,write('Heuristie Valeur Min gagnante:  '),write(ValeurHeuristiqueMin),nl,write(ColoneFinaleMin),!,
                               heuristique(C1,C2,C3,C4,C5,C6,C7,ValeurHeuristiqueMax,'J',ColoneFinaleMax),!,
                               nl,nl,write('Heuristie Valeur Max gagnante:  '),write(ValeurHeuristiqueMax),nl,write(ColoneFinaleMax),!,
                              % ValeurHeuristiqueMax - ValeurHeuristiqueMin >= 0,
                                    %Max gagne
%                                    ColonneFinale = ColoneFinaleMax ;
                                    %Min gagne
                                    ColonneFinale =ColoneFinaleMin.


%  Fonction qui prend une liste et de chiffre et retourne la valeur
%  maximale de cette liste
%
%   Parametre entre : Liste  ,
%   Parametre sortie : Retour.
%   Elle se rapelle au besoin. Si la liste est vide,
%   elle retourne ce qu'elle contenait.
%
%
%

largest([X|Xs], Retour) :- largest(Xs, X, Retour).

largest([], Retour, Retour).

largest([X|Xs], Mat, Retour) :-
    Mat1 is max(X, Mat),
    largest(Xs, Mat1, Retour).



% valider_verticale(X,Colone,Valeur)

% retourne le nombre d'instance en
% debut de liste identique pour l'heuristique selon la couleur X.
% La valeur finaleur retourné de  Valeur est l'heuristique.
% Cette fonction est joint a la fonction d'inversion de liste pour
% avoir les entres en debut.
%   paramètre d'entré  :  Colone , Couleur
%   Parametre de sortie , la valeur
%

valider_verticale([], _, 1).
valider_verticale([X| _], Couleur, 1):- not(X == Couleur), !.
valider_verticale([X| Colonne], Couleur, ValeurHeuristique):- X == Couleur, valider_verticale(Colonne, Couleur, Val1), ValeurHeuristique is Val1 + 1.




%%%%%%%%%%%%%%%%%%
% Jeux d'essais pour faciliter tests.
%%%%%%%%%%%%%%%%%%
%
%
%
%
placer_ligneV1():- placer_jeton(Mat1,['R'],Colonne),placer_jeton(Mat1,['J'],Colonne).

placer_ligneV2():- placer_jeton(Mat1,['R'],Colonne),placer_jeton(Deux,['J'],Colonne).
