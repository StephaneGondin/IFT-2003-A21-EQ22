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
% Appel Du Jeux dans la fonction jeux . Le jeux se passe les parametres
% colonne et appelle les fonctions du joueur a l'IA. Les conditions de
% validation sont �galement appel�es dans le mouvement.
%
% param�tre a envoyer : 7 colonnes
%%%

jeux:- etat_initial(Un,Deux,Trois,Quatre,Cinq,Six,Sept),
            jeux_recurrent(Un,Deux,Trois,Quatre,Cinq,Six,Sept).
           % replace_list(Deux,Test),write(Test),write(Deux),conc(Un,Deux,Test),conc(Test,['1|'],Sad),write(Sad),conc(Test,['1|'],Sad),write(Sad),
           % nl,nl,voirboard(Un,Deux,Trois,Sad,Cinq,Six,Sept).
%voirboard(Un,Deux,Trois,Quatre,Cinq,Six,Sept).


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

                                                    swap(C1,C2,C3,C4,C5,C6,C7,Reponse,Retour),write(Retour),
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

voirboard(Un,Deux,Trois,Quatre,Cinq,Six,Sept):-voir(Un,'1'),voir(Deux,'2'),voir(Trois,'3'),voir(Quatre,'4'),voir(Cinq,'5'),voir(Six,'6'),voir(Sept,'7').

voir(X,Lettre):- write(X),write(Lettre),nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Swap semble long comme fonction, mais elle est bien simple. Elle
% recoit les colonnes en parametres. Elle recoit le parametre Y, qui
% proviens de l'utilisateur (un '1','2',etc) et retourne la colone dans
% Retour. On fait afficher la ligne grace a voir pour avoir un visuel.
% ex: Si Y==1 va a voir(Un,'1') et le retour de la colone  est Retour=Un
% ==== Elle nous permet a partir de chiffre de selectionner les colonne
% avec des noms dans la variable Retour===

% swap(Un,Deux,Trois,Quatre,Cinq,Six,Sept,Y,Retour):-
% (Y==1,voir(Un,'1'),Retour=Un;Y==2,voir(Deux,'2'),Retour=Deux;Y==3,voir(Trois,'3'),Retour=Trois;Y==4,voir(Quatre,'4'),Retour=Quatre;Y==5,voir(Cinq,'5'),Retour=Cinq;Y==6,voir(Six,'1'),Retour=Six;Y==7,voir(Sept,'7'),Retour=Sept).
%
swap(C1,C2,C3,C4,C5,C6,C7,Y,Retour):- Y==1,replace_list(C1,Retour),!;Y==2,replace_list(C2,Retour),!;Y==3,replace_list(C3,Retour),!;Y==4,replace_list(C4,Retour),!;Y==5,replace_list(C5,Retour),!;Y==6,replace_list(C6,Retour),!;Y==7,replace_list(C7,Retour),!.


transfert_AI(C1,C2,C3,C4,C5,C6,C7,Y,Retour):- Y==1,jeux_AI(Retour,C2,C3,C4,C5,C6,C7),!;Y==2,jeux_AI(C1,Retour,C3,C4,C5,C6,C7),!;Y==3,jeux_AI(C1,C2,Retour,C4,C5,C6,C7),!;Y==4,jeux_AI(C1,C2,C3,Retour,C5,C6,C7),!;Y==5,jeux_AI(C1,C2,C3,C4,Retour,C6,C7),!;Y==6,jeux_AI(C1,C2,C3,C4,C5,Retour,C7),!;Y==7,jeux_AI(C1,C2,C3,C4,C5,C6,Retour),!.



% transfert_AI(Un,Deux,Trois,Quatre,Cinq,Six,Sept,Y,Retour):-
% Y==1,replace_list(Retour,Un);Y==2,replace_list(Retour,Deux);Y==3,replace_list(Retour,Trois);Y==4,replace_list(Retour,Quatre);Y==5,replace_list(Retour,Cinq);Y==6,replace_list(Retour,Six);Y==7,replace_list(Retour,Sept),!.
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Questioner l'utilisateur sur son emplacement a mettre
% Parametre a prendre en charges: reponse utilisateur, retourne la
% colone. 1 a 7 seulement considere.
% La fonction verifier reponse s'assurer que la reponse correspond au
% bon parametre et ensuite affiche la reponse au client. Si ce n'est pas
% le cas, elle echoue et on obtient un false.
% %%%%%%%%%%%%%%%%%%%%%%%%%%

question_utilisateur(Reponse):-write('quelle colone desirez-vous jouer: reponse sous forme 1. 2. 3. 4. 5. 6. 7.'),write(' une autre reponse arrete le jeu:'),nl,read(Reponse),verifier_reponse(Reponse).
verifier_reponse(Reponse):-((Reponse=1);(Reponse=2);(Reponse=3);(Reponse=4);(Reponse=5);(Reponse=6);(Reponse=7)),write('votre reponse:'),write(Reponse),nl.



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
%Prédicats
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Place un jeton dans la colonne s'il y a une place disponible.
placer_jeton(Colonne,Jeton,Resultat):-conc(Colonne,Jeton,Resultat),valider_place_disponible(Colonne).

%Valider s'il reste de la place dans une colonne pour placer une pièce.
%retourne true ou false
valider_place_disponible(Colonne):- length(Colonne, N), N < 7,write('longeur dans la colone: '),write(N).



%%%%%%%%%%%%
%Fonction du tour � l'ordinateur
%
%
%%%%%%

jeux_AI(C1,C2,C3,C4,C5,C6,C7):-voirboard(C1,C2,C3,C4,C5,C6,C7),jeux_recurrent(C1,C2,C3,C4,C5,C6,C7).

valider_verticale().
valider_horizontale().
valider_diagonale().

min().
max().
