SCREEN 13
_TITLE "CRAZY CARS X"
_ICON _LOADIMAGE("data/menu/icone.gif")

'********************************************************************
'********************************************************************
'*                                                                  *
'*               CRAZY CARS ---> CRAZY CARS X                       *
'*                                                                  *
'*                TITUS 1988 ---> LA GVIDILO                        *
'*                                                                  *
'********************************************************************
'*                                                                  *
'*                                                                  *
'*                   EDIT BY LA GVIDILO,October 2014                *
'*                       http://informabox.fr                       *
'*                                                                  *
'*                                                                  *
'*                remake of CPC version by FL in 2012               *
'*                    http://crazycarscpc.free.fr                   *
'*                                                                  *
'*                      Road code by Lou Gorenfeld                  *
'*                http://www.gorenfeld.net/lou/pseudo/              *
'*                                                                  *
'*                   run this BASIC prog only with QB64             *
'*                          http://www.qb64.net                     *
'*                                                                  *
'*                                                                  *
'********************************************************************
'********************************************************************

RANDOMIZE TIMER

pleinecran$ = "non"
gameover$ = "non"
credits$ = "non"


Haut$ = CHR$(0) + CHR$(72)
Bas$ = CHR$(0) + CHR$(80)
Gauche$ = CHR$(0) + CHR$(75)
Droite$ = CHR$(0) + CHR$(77)

' chargement des credits

DIM rank(16)
DIM score(16)
DIM nom$(16)

OPEN "hiscore.txt" FOR INPUT AS #1

FOR i = 1 TO 16
    INPUT #1, rank(i), score(i), nom$(i)
NEXT i

CLOSE #1

hiscore = score(1)


'                              affichage du titre
debut:

CLS
decor = _LOADIMAGE("data/menu/titre.gif")
_COPYPALETTE , decor
_PUTIMAGE (0, 0), decor

_DISPLAY

SLEEP 4


restart:

'                               ecran de fin
IF gameover$ = "oui" THEN


    SCREEN 13
    decor = _LOADIMAGE("data/menu/gameover.png")
    _COPYPALETTE , decor
    _PUTIMAGE (0, 0), decor
    _DISPLAY

    DO: LOOP UNTIL _KEYDOWN(13) OR _KEYDOWN(27)


    IF score < score(16) THEN GOTO menu


    SCREEN 7: CLS , 7
    PALETTE 15, 0: COLOR 15, 7



    IF score >= score(16) THEN

        LOCATE 3, 13: PRINT "congratulations"
        LOCATE 6, 13: PRINT "you are one of"
        LOCATE 7, 7: PRINT "the fastest man in the world !"


        FOR i = 1 TO 16
            IF score >= score(i) THEN LOCATE 11, 12: PRINT "your rank is"; i: GOTO suitescore

        NEXT i

        suitescore:

        IF i = 16 THEN score(16) = score

        IF i < 16 THEN score(16) = score(15): nom$(16) = nom$(15)
        IF i < 15 THEN score(15) = score(14): nom$(15) = nom$(14)
        IF i < 14 THEN score(14) = score(13): nom$(14) = nom$(13)
        IF i < 13 THEN score(13) = score(12): nom$(13) = nom$(12)
        IF i < 12 THEN score(12) = score(11): nom$(12) = nom$(11)
        IF i < 11 THEN score(11) = score(10): nom$(11) = nom$(10)


        IF i < 10 THEN score(10) = score(9): nom$(10) = nom$(9)
        IF i < 9 THEN score(9) = score(8): nom$(9) = nom$(8)
        IF i < 8 THEN score(8) = score(7): nom$(8) = nom$(7)
        IF i < 7 THEN score(7) = score(6): nom$(7) = nom$(6)
        IF i < 6 THEN score(6) = score(5): nom$(6) = nom$(5)
        IF i < 5 THEN score(5) = score(4): nom$(5) = nom$(4)
        IF i < 4 THEN score(4) = score(3): nom$(4) = nom$(3)
        IF i < 3 THEN score(3) = score(2): nom$(3) = nom$(2)
        IF i < 2 THEN score(2) = score(1): nom$(2) = nom$(1)

        score(i) = score



        LOCATE 13, 2: PRINT "please"
        LOCATE 14, 2: PRINT "enter your name"

        DO: LOOP UNTIL INKEY$ = ""
        LOCATE 14, 17: INPUT ; nom$(i)


        _DISPLAY


    END IF

    ' affichage des scores

    hiscore:
    SCREEN 7: CLS , 7
    PALETTE 15, 0: COLOR 15, 7

    LOCATE 3, 16: PRINT "hi score"

    FOR i = 1 TO 16
        COLOR 15, 7: LOCATE 5 + i, 2: PRINT rank(i);
        LOCATE 5 + i, 5: PRINT score(i);
        LOCATE 5 + i, 15: PRINT nom$(i);
        COLOR 7
        FOR b = 6 + i TO 24: LOCATE b, 1: PRINT STRING$(40, 219);
        NEXT b
    NEXT i


    ' sauvegarde des nouveaux scores
    OPEN "hiscore.txt" FOR OUTPUT AS #1

    FOR i = 1 TO 16: PRINT #1, rank(i), score(i), nom$(i): NEXT i

    CLOSE #1

    _DISPLAY
    SLEEP



END IF

'                                           MENU

menu:


DO: LOOP UNTIL INKEY$ = ""

SCREEN 13: CLS
decor = _LOADIMAGE("data/menu/logo.png")
_COPYPALETTE , decor
_PUTIMAGE (24, 46), decor

_DISPLAY
REM CHARGEMENT DU SON DU MENU
menu_son0& = _SNDOPEN ("data/sons/m0.ogg")



Cpos = 0
LimiteCpos:
SELECT CASE Cpos
    CASE IS < 0
        Cpos = 4
    CASE IS > 4
        Cpos = 0
END SELECT
DO

    COLOR 15: _PRINTMODE _FILLBACKGROUND
    LOCATE 18, 9: PRINT "        start        "
    REM LOCATE 18, 9: PRINT "                         "
    IF pleinecran$ = "non" THEN LOCATE 19, 9: PRINT "        fullscreen   "
    IF pleinecran$ = "oui" THEN LOCATE 19, 9: PRINT "        fullscreen off"
    LOCATE 20, 9: PRINT "        credits      "
    LOCATE 21, 9: PRINT "        hiscore      "
    LOCATE 22, 9: PRINT "        EXIT         "
    FOR T = 0 TO 4
        LOCATE (19) + T - 1, 13
        PRINT " ";
        IF T = Cpos THEN
            LOCATE (19) + Cpos - 1, 13
            PRINT ">>>>";
        END IF
        

    NEXT T
    _DISPLAY
    touche$ = INKEY$
    SELECT CASE touche$
        CASE IS = Haut$ 'haut
			_SNDPLAY menu_son0&
            Cpos = Cpos - 1
            GOTO LimiteCpos
        CASE IS = Bas$ 'bas
			_SNDPLAY menu_son0&
            Cpos = Cpos + 1
            GOTO LimiteCpos
        CASE IS = CHR$(13)
            SELECT CASE Cpos
                CASE IS = 0 'Start
					_SNDCLOSE menu_son0&
					_SNDPLAYFILE ("data/sons/m1.ogg")
					_DELAY 3
                    GOTO variables
                CASE IS = 1 'fullscreen on/off
                    IF pleinecran$ = "non" THEN _FULLSCREEN: pleinecran$ = "oui": GOTO debut
                    IF pleinecran$ = "oui" THEN _FULLSCREEN _OFF: pleinecran$ = "non": GOTO debut

                CASE IS = 2 'credits
                    GOTO credits
                CASE IS = 3 'Hi-score
                    GOTO hiscore
                CASE IS = 4 'EXIT
                    END
            END SELECT
    END SELECT

    'IF _KEYDOWN(49) OR _KEYDOWN(32) THEN GOTO variables
    'IF _KEYDOWN(50) THEN
    '    IF pleinecran$ = "non" THEN _FULLSCREEN: pleinecran$ = "oui": GOTO debut
    '    IF pleinecran$ = "oui" THEN _FULLSCREEN _OFF: pleinecran$ = "non": GOTO debut
    'END IF
    'IF _KEYDOWN(51) THEN GOTO credits
    'IF _KEYDOWN(52) THEN GOTO hiscore
    'IF _KEYDOWN(55) THEN END
    'IF _KEYDOWN(27) THEN END

LOOP


credits:


SCREEN 13: CLS
decor = _LOADIMAGE("data/menu/mercedes.png")
_PUTIMAGE (0, 0), decor

IF credits$ = "non" THEN _SNDPLAYFILE "data/sons/trantor.ogg":

COLOR 15

LOCATE 2, 24: PRINT "    CRAZY CARS";: COLOR 14: PRINT " X "
COLOR 12
LOCATE 3, 24: PRINT "    LA GVIDILO   "
COLOR 15
LOCATE 4, 24: PRINT "                 "
LOCATE 5, 24: PRINT " by Eric Caen and"
LOCATE 6, 24: PRINT " Olivier Corviole"
LOCATE 7, 24: PRINT "                 "
LOCATE 8, 24: PRINT "   CPC  version  "
LOCATE 9, 24: PRINT "   JC MEYRIGNAC "
LOCATE 10, 24: PRINT "   Gil  Espeche "
LOCATE 11, 24: PRINT "                 "
LOCATE 12, 24: PRINT "remake QB64 by FL"
LOCATE 13, 24: PRINT "  road code by   "
LOCATE 14, 24: PRINT "  Lou Gorenfeld  "
LOCATE 15, 24: PRINT "                 "
LOCATE 16, 24: PRINT " gameover picture"
LOCATE 17, 24: PRINT "  Eric Cubizolle "
LOCATE 18, 24: PRINT "                 "
LOCATE 19, 24: PRINT "  Trantor theme  "
LOCATE 20, 24: PRINT " David Whittaker "
LOCATE 21, 24: PRINT "                 "
LOCATE 22, 24: PRINT " special  thanks "
LOCATE 23, 24: PRINT "DrFloyd & FF_Clad"

LOCATE 24, 7: PRINT "http://crazycarscpc.free.fr";
COLOR 12
LOCATE 25, 7: PRINT "AND NOW";: COLOR 15: PRINT " http://informabox.fr";


_DISPLAY

SLEEP 5
IF _KEYDOWN(27) THEN _SNDPLAYFILE "data/sound/nothing.ogg": credits$ = "non": GOTO menu


decor = _LOADIMAGE("data/menu/porsche.png")
_PUTIMAGE (0, 0), decor

_DISPLAY
SLEEP 5
IF _KEYDOWN(27) THEN _SNDPLAYFILE "data/sound/nothing.ogg": credits$ = "non": GOTO menu

decor = _LOADIMAGE("data/menu/lamborghini.png")
_PUTIMAGE (0, 0), decor

_DISPLAY
SLEEP 5
IF _KEYDOWN(27) THEN _SNDPLAYFILE "data/sound/nothing.ogg": credits$ = "non": GOTO menu

decor = _LOADIMAGE("data/menu/ferrari.png")
_PUTIMAGE (0, 0), decor

_DISPLAY
SLEEP 5



IF _KEYDOWN(27) THEN
    _SNDPLAYFILE "data/sound/nothing.ogg"
    credits$ = "non"
    GOTO menu
ELSE credits$ = "oui": GOTO credits
END IF





'                       ******************************************
'                       ********        VARIABLES    ************
'                       ******************************************
variables:


ombre = _LOADIMAGE("data/sprites/ombre.gif")
ville = _LOADIMAGE("data/sprites/decor.gif")
lambo = _LOADIMAGE("data/sprites/lambo.gif")

ScreenLine = 169
RoadLines = 42
DIM X AS SINGLE
DIM DX AS SINGLE
DIM DDX AS SINGLE
DIM HalfWidth AS SINGLE
DIM SegY AS SINGLE
SegY = RoadLines
DX = 0
DDX = 0.3 ' angle du virage

temps = 0
reftemps = 0
chrono = 0
chronometre = 65
KMS = 0
Xcar = 32
Ycar = 160
Yombre = 161
Yplots = 140
vitesse = 0
vitessecompteur = 0
vitesseplots = 0
vitessecar = 0
volant$ = "milieu"
Xdecor1 = -95 ' -127+32
Xdecor2 = 161 ' 129+32
deport = 1
sonoccupe$ = "non"
refson = 0
montee$ = "non"
descente$ = "non"
vmax$ = "non"
touche$ = "non"
level = 1
stage = 1
score = 0
YlamboH = 130
YlamboB = 132
lambo$ = "non"
transition$ = "non"
decalage = 0
transitionvoiture$ = "non"
ferrari$ = "non"
saut$ = "non"
Ysaut = 130
voituresaute$ = "non"
refsaut = 0
soncrash$ = "non"
accident$ = "non"
gameover$ = "non"

bosses$ = "non"
bande1$ = "oui"
bande2$ = "non"
bande3$ = "non"
bande4$ = "non"
horizon = 134
Ybande1 = 134 '190
Ybande2 = 134 '172
Ybande3 = 134 '154
Ybande4 = 134 '136

hauteurdebut$ = "oui"
voiturebosse$ = "non"

YEAR = 1988

'                                   pr‚-affichage

LINE (32, 0)-(288, 129), 11, BF ' ciel bleu

'                                       son moteur
_SNDPLAYFILE "data/sons/ralenti.ogg": sonoccupe$ = "oui"



'                       ******************************************
'                       ******** boucle principale    ************
'                       ******************************************
DO

    temps = temps + 1

    accelere$ = "non"
    volant$ = "milieu"


    IF level = 1 THEN voiture = _LOADIMAGE("data/sprites/mercedes.gif"): objet = _LOADIMAGE("data/sprites/plot1.bmp")
    IF level = 2 THEN voiture = _LOADIMAGE("data/sprites/porsche.gif"): objet = _LOADIMAGE("data/sprites/plot2.bmp")
    IF level = 3 THEN voiture = _LOADIMAGE("data/sprites/ferrari.gif"): objet = _LOADIMAGE("data/sprites/plot3.bmp")


    ' affichages primaires

    ' herbe

    LINE (32, 130)-(288, 169), 10, BF

    ' bas de la route
    LINE (32, 167)-(288, 200), 8, BF ' ciel bleu




    HalfWidth = 140 '  largueur de la route
    WidthStep = 3.2 '  inclinaison de la route


    ' entr‚es clavier

    IF _KEYDOWN(19712) OR STICK(0) > 190 THEN volant$ = "gauche"


    IF _KEYDOWN(19200) OR STICK(0) < 65 THEN volant$ = "droite"
    IF _KEYDOWN(32) THEN volant$ = "futur"

    IF _KEYDOWN(18432) OR STICK(1) < 65 THEN
        IF touche$ = "non" AND accident$ = "non" THEN accelere$ = "oui"
    END IF



    '                       ******************************************
    '                       ********       ACTIONS        ************
    '                       ******************************************

    'vitesse du jeu et son du moteur

    IF accelere$ = "oui" THEN
        vitesse = vitesse + .225
        IF level = 1 THEN vitessecompteur = vitessecompteur + .450
        IF level = 2 THEN vitessecompteur = vitessecompteur + .5
        IF level = 3 THEN vitessecompteur = vitessecompteur + .55
        IF vmax$ = "non" THEN sonoccupe$ = "non"
        descente$ = "non"

        IF vitesse < 100 THEN
            IF montee$ = "non" THEN _SNDPLAYFILE "data/sons/montee.ogg": montee$ = "oui"
        END IF

    END IF




    IF accelere$ = "non" THEN
        vitesse = vitesse - 0.5
        IF level = 1 THEN vitessecompteur = vitessecompteur - 1.25
        IF level = 2 THEN vitessecompteur = vitessecompteur - 1.3
        IF level = 3 THEN vitessecompteur = vitessecompteur - 1.5
        montee$ = "non": vmax$ = "non"

        IF vitesse > 0 THEN
            IF descente$ = "non" THEN _SNDPLAYFILE "data/sons/descente.ogg": descente$ = "oui"
        END IF

    END IF

    IF level = 3 THEN IF vitessecompteur > 250 THEN vitessecompteur = 250
    IF level = 2 THEN IF vitessecompteur > 220 THEN vitessecompteur = 220
    IF level = 1 THEN IF vitessecompteur > 200 THEN vitessecompteur = 200
    IF vitessecompteur < 0 THEN vitessecompteur = 0

    IF vitesse > 100 THEN vitesse = 100
    IF vitesse < 0 THEN vitesse = 0





    '                   vitesse de direction de la voiture

    vitessecar = 0
    IF vitesse > 1 THEN vitessecar = 1
    IF vitesse > 25 THEN vitessecar = 2
    IF vitesse > 50 THEN vitessecar = 3
    IF vitesse > 75 THEN vitessecar = 4

    IF vitessecar > 0 THEN

        IF volant$ = "futur" THEN
            IF vitessecompteur > 248 THEN
                IF YEAR = 1988 THEN GOSUB TO2014
                GOTO affichage
            END IF
        END IF

        IF volant$ = "gauche" THEN
            IF voiturebosse$ = "non" THEN Xcar = Xcar + vitessecar
            IF voiturebosse$ = "oui" THEN Xcar = Xcar - vitessecar


            IF level = 1 THEN voiture = _LOADIMAGE("data/sprites/mercedesD.gif")
            IF level = 2 THEN voiture = _LOADIMAGE("data/sprites/porscheD.gif")
            IF level = 3 THEN voiture = _LOADIMAGE("data/sprites/ferrariD.gif")
        END IF

        IF volant$ = "droite" THEN
            IF voiturebosse$ = "non" THEN Xcar = Xcar - vitessecar
            IF voiturebosse$ = "oui" THEN Xcar = Xcar + vitessecar


            IF level = 1 THEN voiture = _LOADIMAGE("data/sprites/mercedesG.gif")
            IF level = 2 THEN voiture = _LOADIMAGE("data/sprites/porscheG.gif")
            IF level = 3 THEN voiture = _LOADIMAGE("data/sprites/ferrariG.gif")
        END IF

        IF SegY < RoadLines THEN

            'decor qui bouge
            IF DDX > 0 THEN
                Xdecor1 = Xdecor1 - 1: Xdecor2 = Xdecor2 - 1
            END IF

            IF DDX < 0 THEN
                Xdecor1 = Xdecor1 + 1: Xdecor2 = Xdecor2 + 1
            END IF


            ' deport de la voiture

            deport = 1

            IF vitessecar > 3 THEN
                IF DDX = 0.2 OR DDX = -0.2 THEN deport = 0.5

                IF DDX = 0.3 OR DDX = -0.3 THEN deport = -0.5

                IF DDX = 0.4 OR DDX = -0.4 THEN deport = -0.5
            END IF

            IF DDX > 0 THEN
                Xcar = Xcar - vitessecar + deport
            END IF

            IF DDX < 0 THEN
                Xcar = Xcar + vitessecar - deport
            END IF

        END IF

    END IF

    '                ralentissement de la voiture dans les virages exterieurs

    touche$ = "non"
    IF DDX > 0 AND SegY < RoadLines THEN
        IF Xcar <= 32 AND vitesse >= 11 THEN
            touche$ = "oui"
        END IF

    END IF

    IF DDX < 0 AND SegY < RoadLines THEN
        IF Xcar >= 250 AND vitesse >= 11 THEN
            touche$ = "oui"
        END IF
    END IF


    '                           avancement de la bande des plots
    vitesseplots = 0
    IF vitesse > 1 THEN vitesseplots = 1
    IF vitesse > 30 THEN vitesseplots = 3
    IF vitesse > 60 THEN vitesseplots = 5
    

    IF vitesseplots > 0 THEN
        Yplots = Yplots + (vitesseplots / 2)
    END IF

    '                               passage de la lamborghini


    IF vitesse = 0 AND accident$ = "non" THEN lambo$ = "non"

    IF lambo$ = "oui" THEN

        IF accelere$ = "oui" THEN
            vitesselambo = 1
        END IF

        IF accelere$ = "non" THEN
            vitesselambo = -1
        END IF

        YlamboH = YlamboH + (vitesselambo / 2)


    END IF


    '                           accident avec la lamborghini

    IF saut$ = "non" THEN
        IF YlamboH > 150 AND Xcar > 61 AND Xcar < 188 THEN
            accident$ = "oui": refsaut = temps
            sonoccupe$ = "non":
            IF soncrash$ = "non" THEN _SNDPLAYFILE "data/sons/crash.ogg": soncrash$ = "oui"
        END IF
    END IF


    '                            avancement de la ligne de saut

    IF saut$ = "oui" THEN
        IF vitesse > 8 THEN Ysaut = Ysaut + 1

        IF Ysaut = Ycar THEN voituresaute$ = "oui": refsaut = temps
    END IF

    '                           saut de la voiture

    IF voituresaute$ = "oui" THEN
        IF temps > refsaut + 60 THEN voituresaute$ = "non": Ycar = 160: GOTO limites
        IF temps > refsaut + 20 THEN Ycar = Ycar + 6: GOTO limites
        IF saut$ = "oui" THEN Ycar = Ycar - 5
    END IF

    IF accident$ = "oui" THEN
        accelere$ = "non": vitesse = 0: vitessecompteur = 0: sonoccupe$ = "non"
        IF temps > refsaut + 60 THEN
            accident$ = "non": Ycar = 160: soncrash$ = "non": lambo$ = "non"
            _SNDPLAYFILE "data/sons/ralenti.ogg": sonoccupe$ = "oui": refson = temps:
            GOTO limites
        END IF
        IF temps > refsaut + 20 THEN Ycar = Ycar + 6: GOTO limites
        Ycar = Ycar - 5
    END IF


    '                     bandes des bosses
    IF bosses$ = "oui" THEN

        vitessebande = 0
        IF vitesse > 1 THEN vitessebande = 1
        IF vitesse > 30 THEN vitessebande = 2


        IF vitesse > 0 THEN

            IF bande1$ = "oui" THEN Ybande1 = Ybande1 + vitessebande
            IF bande2$ = "oui" THEN Ybande2 = Ybande2 + vitessebande
            IF bande3$ = "oui" THEN Ybande3 = Ybande3 + vitessebande
            IF bande4$ = "oui" THEN Ybande4 = Ybande4 + vitessebande



            IF Ybande1 > horizon + 16 THEN bande2$ = "oui"
            IF Ybande2 > horizon + 16 THEN bande3$ = "oui"
            IF Ybande3 > horizon + 16 THEN bande4$ = "oui"
            IF Ybande4 > horizon + 16 THEN bande1$ = "oui"

        END IF

    END IF
    '                           saut sur les bosses
    IF bosses$ = "non" THEN

        voiturebosse$ = "non"

        Ybande1 = 134
        Ybande2 = 134
        Ybande3 = 134
        Ybande4 = 134
        bande1$ = "oui"
        bande2$ = "non"
        bande3$ = "non"
        bande4$ = "non"

    END IF

    IF bosses$ = "oui" THEN
        IF Ybande1 > Ycar AND Ybande1 < Ycar + 5 THEN voiturebosse$ = "oui": GOTO suite

        IF Ybande2 > Ycar AND Ybande2 < Ycar + 5 THEN voiturebosse$ = "oui": GOTO suite

        IF Ybande3 > Ycar AND Ybande3 < Ycar + 5 THEN voiturebosse$ = "oui": GOTO suite

        IF Ybande4 > Ycar AND Ybande4 < Ycar + 5 THEN
            voiturebosse$ = "oui": GOTO suite
        ELSE voiturebosse$ = "non"
        END IF

        suite:


    END IF


    '                       ******************************************
    '                       ********    LIMITES DES VARIABLES ********
    '                       ******************************************
    limites:

    IF SegY < 18 THEN SegY = 18
    IF SegY > RoadLines THEN SegY = RoadLines

    IF Xdecor1 > 32 THEN Xdecor1 = -223: Xdecor2 = 33
    IF Xdecor2 < 33 THEN Xdecor1 = 32: Xdecor2 = 288

    IF Xcar < 0 THEN Xcar = 0
    IF Xcar > 250 THEN Xcar = 250



    '                           sortie de la bande des plots
    IF Yplots > 170 THEN Yplots = 130




    '                           sortie de la lamborghini


    'lambo:
    IF YlamboH < 130 THEN YlamboH = 130
    IF YlamboB < 132 THEN YlamboB = 132

    IF YlamboH > 160 THEN lambo$ = "non"
    IF YlamboB > 190 THEN lambo$ = "non"


    IF lambo$ = "non" THEN YlamboB = 132: YlamboH = 130


    '                            sortie de la ligne de saut

    IF Ysaut > 200 THEN Ysaut = 130: saut$ = "non"


    '                           sortie des bandes

    IF bosses$ = "oui" THEN
        IF Ybande1 > 199 THEN Ybande1 = horizon: bande1$ = "non"

        IF Ybande2 > 199 THEN Ybande2 = horizon: bande2$ = "non"

        IF Ybande3 > 199 THEN Ybande3 = horizon: bande3$ = "non"

        IF Ybande4 > 199 THEN Ybande4 = horizon: bande4$ = "non"
    END IF


    '                            hauteur de la voiture et son ombre


    IF voiturebosse$ = "oui" THEN Ycar = Ycar - 3

    IF voiturebosse$ = "non" AND voituresaute$ = "non" AND accident$ = "non" THEN Ycar = Ycar + 5


    IF hauteurdebut$ = "oui" THEN IF Ycar >= 160 THEN Ycar = 160

    IF hauteurdebut$ = "non" THEN IF Ycar >= 155 THEN Ycar = 155





    IF Ycar < 50 THEN Ycar = 50


    IF voituresaute$ = "oui" THEN Yombre = 156
    IF accident$ = "oui" THEN Yombre = 156
    IF bosses$ = "oui" THEN Yombre = 156

    IF voituresaute$ = "non" AND accident$ = "non" AND bosses$ = "non" THEN Yombre = Ycar + 1



    '                       ******************************************
    '                       ******** gestion de la route  ************
    '                       ******************************************

    IF vitesse > 0 THEN

        KMS = KMS + 1
        score = score + 10
        'IF score > hiscore THEN hiscore = score

        IF KMS > 4400 THEN
            transition$ = "non"
            IF level < 3 THEN stage = 1
            IF level = 3 THEN stage = stage + 1
            IF level < 3 THEN level = level + 1
            KMS = 0
            chronometre = chronometre + 30: score = score + 100
            IF ferrari$ = "non" THEN transitionvoiture$ = "oui": reftemps = temps
            GOTO transition
        END IF

        IF KMS > 4301 THEN GOTO transition

        IF KMS > 4300 THEN saut$ = "oui": GOTO transition

        IF KMS > 4200 THEN SegY = SegY + 1: transition$ = "oui": GOTO transition

        IF KMS > 4000 THEN DDX = -0.4: SegY = SegY - 1: GOTO transition

        IF KMS > 3901 THEN GOTO transition

        IF KMS > 3900 THEN saut$ = "oui": GOTO transition

        IF KMS > 3850 THEN bosses$ = "non": GOTO transition

        IF KMS > 3800 THEN SegY = SegY + 1: GOTO transition

        IF KMS > 3600 THEN bosses$ = "oui": DDX = 0.4: SegY = SegY - 1: GOTO transition

        IF KMS > 3504 THEN GOTO transition

        IF KMS > 3503 THEN saut$ = "oui": GOTO transition

        IF KMS > 3500 THEN RoadLines = RoadLines + 1: decalage = decalage - 1

        IF KMS > 3400 THEN bosses$ = "non": SegY = SegY + 1: GOTO transition

        IF KMS > 3200 THEN DDX = -0.3: SegY = SegY - 1: GOTO transition

        IF KMS > 3001 THEN GOTO transition

        IF KMS > 3000 THEN
            stage = stage + 1: chronometre = chronometre + 25
            score = score + 100: transition$ = "non"
            GOTO transition
        END IF

        IF KMS > 2800 THEN transition$ = "oui": GOTO transition

        IF KMS > 2704 THEN GOTO transition

        IF KMS > 2703 THEN lambo$ = "oui": GOTO transition

        IF KMS > 2700 THEN RoadLines = RoadLines - 1: decalage = decalage + 1

        IF KMS > 2600 THEN SegY = SegY + 1: GOTO transition

        IF KMS > 2400 THEN bosses$ = "non": DDX = 0.2: SegY = SegY - 1: GOTO transition

        IF KMS > 2300 THEN bosses$ = "oui": GOTO transition

        IF KMS > 2200 THEN SegY = SegY + 1: GOTO transition

        IF KMS > 2106 THEN GOTO transition

        IF KMS > 2105 THEN lambo$ = "oui": GOTO transition

        IF KMS > 2100 THEN Ycar = Ycar - 1: GOTO transition

        IF KMS > 2000 THEN bosses$ = "non": DDX = -0.2: SegY = SegY - 1: GOTO transition

        IF KMS > 1900 THEN bosses$ = "oui": GOTO transition

        IF KMS > 1800 THEN SegY = SegY + 1: GOTO transition

        IF KMS > 1704 THEN GOTO transition

        IF KMS > 1703 THEN lambo$ = "oui": GOTO transition

        IF KMS > 1700 THEN RoadLines = RoadLines + 1: decalage = decalage - 1

        IF KMS > 1600 THEN DDX = -0.2: SegY = SegY - 1: GOTO transition

        IF KMS > 1501 THEN GOTO transition

        IF KMS > 1500 THEN
            stage = stage + 1: chronometre = chronometre + 25
            score = score + 100: transition$ = "non"
            GOTO transition
        END IF

        IF KMS > 1301 THEN transition$ = "oui": GOTO transition

        IF KMS > 1300 THEN lambo$ = "oui": GOTO transition

        IF KMS > 1258 THEN GOTO transition

        IF KMS > 1253 THEN Ycar = Ycar + 1: GOTO transition

        IF KMS > 1200 THEN SegY = SegY + 1: GOTO transition

        IF KMS > 1000 THEN bosses$ = "non": DDX = 0.2: SegY = SegY - 1: GOTO transition

        IF KMS > 903 THEN GOTO transition

        IF KMS > 900 THEN RoadLines = RoadLines - 1: decalage = decalage + 1: bosses$ = "oui":

        IF KMS > 800 THEN SegY = SegY + 1: GOTO transition

        IF KMS > 703 THEN GOTO transition

        IF KMS > 700 THEN RoadLines = RoadLines + 1: decalage = decalage - 1

        IF KMS > 600 THEN bosses$ = "non": DDX = -0.1: SegY = SegY - 1: GOTO transition

        IF KMS > 502 THEN GOTO transition

        IF KMS > 500 THEN RoadLines = RoadLines + 1: decalage = decalage - 1: bosses$ = "oui":

        IF KMS > 400 THEN SegY = SegY + 1: GOTO transition

        IF KMS > 350 THEN
            transitionvoiture$ = "non"
            IF level = 3 THEN ferrari$ = "oui"
            GOTO transition
        END IF
        IF KMS > 308 THEN GOTO transition

        IF KMS > 303 THEN Ycar = Ycar - 1: hauteurdebut$ = "non": GOTO transition

        IF KMS > 300 THEN RoadLines = RoadLines - 1: decalage = decalage + 1: Ycar = Ycar - 1

        IF KMS > 200 THEN DDX = 0.1: SegY = SegY - 1: GOTO transition
        ScreenLine = 169: decalage = 0
    END IF




    ' ***************************************************************************
    ' **********************       TRANSITIONS ENTRE LES STAGES  ****************
    ' ***************************************************************************

    transition:


    IF level > 3 THEN level = 3
    IF level < 3 THEN IF stage > 3 THEN stage = 3


    ' transitions entre les autos

    IF transitionvoiture$ = "oui" THEN

        IF level = 2 THEN
            IF temps > reftemps + 20 THEN reftemps = temps: GOTO affichage
            IF temps > reftemps + 15 THEN voiture = _LOADIMAGE("data/sprites/mercedes.gif"): GOTO affichage
            IF temps > reftemps + 10 THEN voiture = _LOADIMAGE("data/sprites/porsche.gif"): GOTO affichage
            IF temps > reftemps + 5 THEN voiture = _LOADIMAGE("data/sprites/mercedes.gif"): GOTO affichage
        END IF

        IF level = 3 THEN
            IF temps > reftemps + 20 THEN reftemps = temps: GOTO affichage
            IF temps > reftemps + 15 THEN voiture = _LOADIMAGE("data/sprites/porsche.gif"): GOTO affichage
            IF temps > reftemps + 10 THEN voiture = _LOADIMAGE("data/sprites/ferrari.gif"): GOTO affichage
            IF temps > reftemps + 5 THEN voiture = _LOADIMAGE("data/sprites/porsche.gif"): GOTO affichage
        END IF

    END IF





    ' ***************************************************************************
    ' **********************       AFFICHAGE            *************************
    ' ***************************************************************************

    affichage:

    ' affichage des lignes de route

    X = 160 ' recentre la route

    DX = 0


    ScreenLine = 169 - decalage

    FOR A = 1 TO RoadLines

        LINE (X - HalfWidth, ScreenLine)-(X + HalfWidth, ScreenLine), 8

        IF saut$ = "oui" THEN
            IF ScreenLine = Ysaut THEN
                LINE (X - (HalfWidth + (HalfWidth \ 2.5)), ScreenLine)-(X + (HalfWidth + (HalfWidth \ 2.5)), ScreenLine + 15), 8, BF
            END IF
        END IF


        IF bosses$ = "oui" THEN
            IF ScreenLine = (Ybande1 + 5) THEN LINE (X - HalfWidth - (HalfWidth \ 18), ScreenLine)-(X + HalfWidth + (HalfWidth \ 18), ScreenLine), 8
            IF ScreenLine = (Ybande1 + 4) THEN LINE (X - HalfWidth - (HalfWidth \ 16), ScreenLine)-(X + HalfWidth + (HalfWidth \ 16), ScreenLine), 8
            IF ScreenLine = (Ybande1 + 3) THEN LINE (X - HalfWidth - (HalfWidth \ 14), ScreenLine)-(X + HalfWidth + (HalfWidth \ 14), ScreenLine), 8
            IF ScreenLine = (Ybande1 + 2) THEN LINE (X - HalfWidth - (HalfWidth \ 12), ScreenLine)-(X + HalfWidth + (HalfWidth \ 12), ScreenLine), 8
            IF ScreenLine = (Ybande1 + 1) THEN LINE (X - HalfWidth - (HalfWidth \ 10), ScreenLine)-(X + HalfWidth + (HalfWidth \ 10), ScreenLine), 8
            IF ScreenLine = Ybande1 THEN LINE (X - HalfWidth - (HalfWidth \ 8), ScreenLine)-(X + HalfWidth + (HalfWidth \ 8), ScreenLine), 8

            IF ScreenLine = (Ybande2 + 5) THEN LINE (X - HalfWidth - (HalfWidth \ 18), ScreenLine)-(X + HalfWidth + (HalfWidth \ 18), ScreenLine), 8
            IF ScreenLine = (Ybande2 + 4) THEN LINE (X - HalfWidth - (HalfWidth \ 16), ScreenLine)-(X + HalfWidth + (HalfWidth \ 16), ScreenLine), 8
            IF ScreenLine = (Ybande2 + 3) THEN LINE (X - HalfWidth - (HalfWidth \ 14), ScreenLine)-(X + HalfWidth + (HalfWidth \ 14), ScreenLine), 8
            IF ScreenLine = (Ybande2 + 2) THEN LINE (X - HalfWidth - (HalfWidth \ 12), ScreenLine)-(X + HalfWidth + (HalfWidth \ 12), ScreenLine), 8
            IF ScreenLine = (Ybande2 + 1) THEN LINE (X - HalfWidth - (HalfWidth \ 10), ScreenLine)-(X + HalfWidth + (HalfWidth \ 10), ScreenLine), 8
            IF ScreenLine = Ybande2 THEN LINE (X - HalfWidth - (HalfWidth \ 8), ScreenLine)-(X + HalfWidth + (HalfWidth \ 8), ScreenLine), 8


            IF ScreenLine = (Ybande3 + 5) THEN LINE (X - HalfWidth - (HalfWidth \ 18), ScreenLine)-(X + HalfWidth + (HalfWidth \ 18), ScreenLine), 8
            IF ScreenLine = (Ybande3 + 4) THEN LINE (X - HalfWidth - (HalfWidth \ 16), ScreenLine)-(X + HalfWidth + (HalfWidth \ 16), ScreenLine), 8
            IF ScreenLine = (Ybande3 + 3) THEN LINE (X - HalfWidth - (HalfWidth \ 14), ScreenLine)-(X + HalfWidth + (HalfWidth \ 14), ScreenLine), 8
            IF ScreenLine = (Ybande3 + 2) THEN LINE (X - HalfWidth - (HalfWidth \ 12), ScreenLine)-(X + HalfWidth + (HalfWidth \ 12), ScreenLine), 8
            IF ScreenLine = (Ybande3 + 1) THEN LINE (X - HalfWidth - (HalfWidth \ 10), ScreenLine)-(X + HalfWidth + (HalfWidth \ 10), ScreenLine), 8
            IF ScreenLine = Ybande3 THEN LINE (X - HalfWidth - (HalfWidth \ 8), ScreenLine)-(X + HalfWidth + (HalfWidth \ 8), ScreenLine), 8


            IF ScreenLine = (Ybande4 + 5) THEN LINE (X - HalfWidth - (HalfWidth \ 18), ScreenLine)-(X + HalfWidth + (HalfWidth \ 18), ScreenLine), 8
            IF ScreenLine = (Ybande4 + 4) THEN LINE (X - HalfWidth - (HalfWidth \ 16), ScreenLine)-(X + HalfWidth + (HalfWidth \ 16), ScreenLine), 8
            IF ScreenLine = (Ybande4 + 3) THEN LINE (X - HalfWidth - (HalfWidth \ 14), ScreenLine)-(X + HalfWidth + (HalfWidth \ 14), ScreenLine), 8
            IF ScreenLine = (Ybande4 + 2) THEN LINE (X - HalfWidth - (HalfWidth \ 12), ScreenLine)-(X + HalfWidth + (HalfWidth \ 12), ScreenLine), 8
            IF ScreenLine = (Ybande4 + 1) THEN LINE (X - HalfWidth - (HalfWidth \ 10), ScreenLine)-(X + HalfWidth + (HalfWidth \ 10), ScreenLine), 8
            IF ScreenLine = Ybande4 THEN LINE (X - HalfWidth - (HalfWidth \ 8), ScreenLine)-(X + HalfWidth + (HalfWidth \ 8), ScreenLine), 8


        END IF


        '           *************info pour les plots*********
        IF ScreenLine = Yplots THEN inforoute = HalfWidth: infoX = X
        IF ScreenLine = YlamboH THEN infolambo = HalfWidth: Xlambo = X
        '           *****************************************


        HalfWidth = HalfWidth - WidthStep
        ScreenLine = ScreenLine - 1

        IF A > SegY THEN
            DX = DX + DDX
        END IF

        X = X + DX

    NEXT A



    '                                       affichage des plots

    IF Yplots > 131 AND Yplots < 169 THEN
        'LINE (0, Yplots)-(320, Yplots), 4
        _PUTIMAGE (infoX + inforoute, Yplots - 8), objet
        _PUTIMAGE (infoX - inforoute - 5, Yplots - 8), objet
    END IF




    '                                affichage de la lamborghini


    IF lambo$ = "oui" THEN

        YlamboB = YlamboH + (infolambo / 4)

        _CLEARCOLOR _RGB(99, 97, 99), lambo
        _PUTIMAGE (Xlambo - ((infolambo / 2.25) / 2), YlamboH)-(Xlambo + ((infolambo / 2.25) / 2), YlamboB), lambo
    END IF


    '                                        ciel bleu
    LINE (32, 0)-(288, 129), 11, BF
    'IF EtatProjectile=1 THEN LINE (32, 129)-(32+8, 95), 0, BF:BEEP'
    'LINE (32, 129)-(32+8, 95), 0, BF
    '                                       CE QUI CE PASSE DANS CE PUTIN DE CIEL
    IF vitessecompteur > 190 THEN
        IF YEAR = 2014 THEN
            IF EtatProjectile = 0 THEN
                IF chrono <> SAVETIMEProj THEN
                    SAVETIMEProjCnt = SAVETIMEProjCnt + 1
                    IF SAVETIMEProjCnt > 50 THEN
                        FOR T = 400 TO 0 STEP -150
                            SOUND 500 + T, .1
                        NEXT T
                        SAVETIMEProjCnt = 0: EtatProjectile = 1: ProjectileX = INT(RND * (288 - 32)): ProjectileY = 0
                    END IF
                END IF
            END IF
        END IF
    END IF
    
    IF EtatProjectile = 1 THEN
        ProjectileY = ProjectileY + 2.5
        IF ProjPHASE = 0 THEN IF 95 - ProjectileY < 2 THEN ProjPHASE = 1: ProjectileY = 0
        IF ProjPHASE = 1 THEN IF 129 - ProjectileY < 2 THEN ProjPHASE = 0: ProjectileY = 0: EtatProjectile = -1
        'IF ProjectileX > 287 THEN EtatProjectile=0:SAVETIMEProj=chrono
        'IF ProjectileY < 2 THEN EtatProjectile=0:SAVETIMEProj=chrono
        SELECT CASE ProjPHASE
            CASE IS = 0
                LINE (32 + ProjectileX, 129)-(32 + 4 + ProjectileX, 95 - ProjectileY), 0, BF
            CASE IS = 1
                LINE (32 + ProjectileX, 129 - ProjectileY)-(32 + 4 + ProjectileX, 0), 0, BF
        END SELECT
    END IF
    
    '                                          decor

    _PUTIMAGE (Xdecor1, 101), ville
    _PUTIMAGE (Xdecor2, 101), ville


    '                               affichage du score

    COLOR 0: _PRINTMODE _KEEPBACKGROUND
    LOCATE 1, 6: PRINT "SCORE": LOCATE 2, 6: PRINT score
    LOCATE 1, 15: PRINT "HI": LOCATE 2, 15: PRINT score(1)
    LOCATE 3, 6: PRINT "YEAR " + STR$(YEAR)

    '                               affichage de la vitesse

    LOCATE 1, 31: PRINT "SPEED":
    LOCATE 2, 31: PRINT vitessecompteur
    _PRINTMODE _FILLBACKGROUND
    COLOR 11: LOCATE 2, 37: PRINT STRING$(2, 219)
    IF vitessecompteur > 199 THEN LOCATE 2, 36: PRINT STRING$(2, 219)


    '                               affichage des stages
    COLOR 4: _PRINTMODE _KEEPBACKGROUND
    LOCATE 5, 18: PRINT "LEVEL": LOCATE 6, 19: PRINT level
    IF transition$ = "non" THEN LOCATE 8, 18: PRINT "STAGE": LOCATE 9, 19: PRINT stage
    _PRINTMODE _FILLBACKGROUND

    IF transition$ = "oui" THEN
        IF chronometre >= 10 THEN
            COLOR 4: _PRINTMODE _KEEPBACKGROUND

            IF temps > reftemps + 20 THEN
                COLOR 11: LOCATE 8, 13: PRINT STRING$(15, 219): reftemps = temps: GOTO temps
            END IF
            IF temps > reftemps + 15 THEN LOCATE 8, 13: PRINT "SOON TIME BONUS": GOTO temps
            IF temps > reftemps + 10 THEN COLOR 11: LOCATE 8, 13: PRINT STRING$(15, 219): GOTO temps
            IF temps > reftemps + 5 THEN LOCATE 8, 13: PRINT "SOON TIME BONUS": GOTO temps
            COLOR 11: LOCATE 8, 13: PRINT STRING$(15, 219)
        END IF

        IF chronometre < 10 THEN
            COLOR 4: _PRINTMODE _KEEPBACKGROUND

            IF temps > reftemps + 20 THEN
                COLOR 11: LOCATE 8, 16: PRINT STRING$(15, 219): reftemps = temps: GOTO temps
            END IF
            IF temps > reftemps + 15 THEN LOCATE 8, 16: PRINT "GAME OVER": GOTO temps
            IF temps > reftemps + 10 THEN COLOR 11: LOCATE 8, 16: PRINT STRING$(15, 219): GOTO temps
            IF temps > reftemps + 5 THEN LOCATE 8, 16: PRINT "GAME OVER": GOTO temps
            COLOR 11: LOCATE 8, 16: PRINT STRING$(15, 219)
        END IF

    END IF
    temps:

    '                               affichage du temps

    IF temps > chrono + 50 THEN
        chronometre = chronometre - 1
        chrono = temps
    END IF

    IF chronometre < 10 THEN transition$ = "oui"

    IF chronometre < 0 THEN chronometre = 0: gameover$ = "oui": _SNDPLAYFILE "nothing.ogg"

    COLOR 0: _PRINTMODE _KEEPBACKGROUND
    LOCATE 1, 25: PRINT "TIME": LOCATE 2, 27: PRINT chronometre
    _PRINTMODE _FILLBACKGROUND


    '                                   affichage de la voiture
    _CLEARCOLOR _RGB(99, 97, 99), voiture
    _PUTIMAGE (Xcar, Yombre), ombre
    _PUTIMAGE (Xcar, Ycar), voiture


    
    '                               Le tir d'octet du vide ... xP
    
    IF EtatProjectile = -1 THEN
        SELECT CASE ProjPHASE
            CASE IS = 0, 1
                ProjectileY = ProjectileY + 7.7
            CASE IS = 2
                ProjectileR = ProjectileR + 2
                IF (Xcar > (32 + ProjectileX) - ProjectileR) AND (Xcar < (32 + ProjectileX) + ProjectileR) OR (Xcar + 72 > (32 + ProjectileX) - ProjectileR) AND (Xcar + 72 < (32 + ProjectileX) + ProjectileR) OR (Xcar + INT(72 / 2) > (32 + ProjectileX) - ProjectileR) AND (Xcar + INT(72 / 2) < (32 + ProjectileX) + ProjectileR) THEN
                    accident$ = "oui": refsaut = temps
                    sonoccupe$ = "non":
                    IF soncrash$ = "non" THEN _SNDPLAYFILE "data/sons/crash.ogg": soncrash$ = "oui"
                END IF
        END SELECT
        
        IF ProjPHASE = 0 THEN IF ProjectileY > 195 THEN ProjPHASE = 1: ProjectileY = 0
        IF ProjPHASE = 1 THEN IF 0 + ProjectileY >= 195 THEN ProjPHASE = 2: ProjectileY = 0: ProjectileR = 0
        IF ProjPHASE = 2 THEN IF ProjectileR > 40 THEN ProjPHASE = 0: ProjectileR = 0: EtatProjectile = 0
        'IF ProjectileX > 287 THEN EtatProjectile=0:SAVETIMEProj=chrono
        'IF ProjectileY < 2 THEN EtatProjectile=0:SAVETIMEProj=chrono
        SELECT CASE ProjPHASE
            CASE IS = 0
                LINE (32 + ProjectileX - 8, 0)-(32 + 16 + ProjectileX, 0 + ProjectileY), 0, BF
            CASE IS = 1
                LINE (32 + ProjectileX - 8, 0 + ProjectileY)-(32 + 16 + ProjectileX, 195), 0, BF
            CASE IS = 2
                FOR T = 0 TO ProjectileR STEP 1
                    CIRCLE (32 + ProjectileX, 185), ProjectileR - T, INT(0 + T / 2)
                NEXT T
                SOUND 440, .2
        END SELECT
    END IF
    
    ' bords noirs
    LINE (0, 0)-(31, 200), 0, BF
    LINE (289, 0)-(320, 200), 0, BF

    '                                   sons du moteur

    IF soncrash$ = "non" THEN
        IF sonoccupe$ = "oui" THEN
            IF temps > refson + 100 THEN sonoccupe$ = "non": vmax$ = "non"
        END IF

        IF sonoccupe$ = "non" THEN
            IF vitesse = 0 THEN _SNDPLAYFILE "data/sons/ralenti.ogg": sonoccupe$ = "oui": refson = temps: GOTO zapralenti
            IF vitesse < 30 AND descente$ = "oui" THEN _SNDPLAYFILE "data/sons/ralenti.ogg": sonoccupe$ = "oui": refson = temps

            zapralenti:
            IF vitesse = 100 AND vmax$ = "non" THEN
                _SNDPLAYFILE "data/sons/afond.ogg":
                montee$ = "non": sonoccupe$ = "oui": vmax$ = "oui": refson = temps
            END IF

        END IF
    END IF



    _DISPLAY

    _LIMIT 50


    IF _KEYDOWN(27) THEN
        _SNDPLAYFILE "data/sons/nothing.ogg": GOTO restart
    END IF


    IF gameover$ = "oui" THEN
        _PRINTMODE _FILLBACKGROUND
        COLOR 11: LOCATE 8, 16: PRINT STRING$(15, 219)
        _PRINTMODE _KEEPBACKGROUND
        COLOR 4: LOCATE 8, 16: PRINT "GAME OVER"
        _DISPLAY
        SLEEP 4:
        GOTO restart
    END IF

LOOP
GOTO noexist

TO2014:

FOR T = 0 TO INT(RND * 5)
    SOUND 220 + 10 * T, .1
    LINE (31, 200)-(289, 0), 15, BF
    _DISPLAY
    _DELAY 0.150
    SOUND 440 + 10 * T, .1
    LINE (31, 200)-(289, 0), 7, BF
    _DISPLAY
    _DELAY 0.075
NEXT T
YEAR = 2014
ville = _LOADIMAGE("data/sprites/decor-futur.gif")

RETURN

noexist:


