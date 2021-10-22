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
           voirboard(Un,Deux,Trois,Quatre,Cinq,Six,Sept),
           question_utilisateur(Reponse),
           swap(Un,Deux,Trois,Quatre,Cinq,Six,Sept,Reponse,Retour),
           voir(Retour,' retour 1 fois'),
           voir(Retour,'retour 2 fois'),
           valider_place_disponible(Retour),
           placer_jeton(Retour,'a',Retour).






%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Interface visuelle de base
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

voirboard(Un,Deux,Trois,Quatre,Cinq,Six,Sept):-voir(Un,'1'),voir(Deux,'2'),voir(Trois,'3'),voir(Quatre,'4'),voir(Cinq,'5'),voir(Six,'6'),voir(Sept,'7').

voir(X,Lettre):- write(X),write(Lettre),nl.

swap(Un,Deux,Trois,Quatre,Cinq,Six,Sept,Y,Retour):- (Y==1,voir(Un,'1'),Retour=Un;Y==2,voir(Deux,'2'),Retour=Deux;Y==3,voir(Trois,'3'),Retour=Trois;Y==4,voir(Quatre,'4'),Retour=Quatre;Y==5,voir(Cinq,'5'),Retour=Cinq;Y==6,voir(Six,'1'),Retour=Six;Y==7,voir(Sept,'7'),Retour=Sept).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Questioner l'utilisateur sur son emplacement a mettre
% Parametre a prendre en charges: reponse utilisateur, retourne la
% colone. 1 a 7 seulement considere.
% %%%%%%%%%%%%%%%%%%%%%%%%%%

question_utilisateur(Reponse):-write('quelle colone desirez-vous jouer: (reponse sous forme 1. 2. 3. 4. 5. 6. 7.)'),read(Reponse),verifier_reponse(Reponse).
verifier_reponse(Reponse):-((Reponse=1);(Reponse=2);(Reponse=3);(Reponse=4);(Reponse=5);(Reponse=6);(Reponse=7)),write('votre reponse:'),write(Reponse),nl.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prédicats
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Place un jeton dans la colonne s'il y a une place disponible.
placer_jeton(Colonne, CouleurJeton, [ CouleurJeton | Colonne]):- valider_place_disponible(Colonne).

%Valider s'il reste de la place dans une colonne pour placer une pièce.
%retourne true ou false
valider_place_disponible(Colonne):- length(Colonne, N), N < 7,write('place disponible dans la colone: '),write(N).


valider_verticale().
valider_horizontale().
valider_diagonale().

min().
max().
