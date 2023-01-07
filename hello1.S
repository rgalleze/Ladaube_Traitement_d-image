/*  hello1.S

    MI01 - TP Assembleur 1

    Affiche une chaîne de caractères à l'écran                                */
.file "hello1.S"
.intel_syntax noprefix

/* Section de données */
.data

/*******************************************************************************
 Ajouter les variables msg et longueur ici
 ******************************************************************************/
msg :		.ascii "Bonjour tout le monde !"
longueur :  .quad 23 /*il faudra 6 bits pour coder 23.
						Cependant, puisqu'il sera comparé au registre r13, il devra être codé sur 64 bits*/
/* Section de code */
.text

/*  Le symbole _start est le point d'entrée du programme, il repère l'adresse de
    la toute première instruction exécutée. Il est défini comme global sans quoi
    l'éditeur de liens ne pourra pas le trouver.                              */
.global _start
_start:
        lea     r12, msg[rip]
        mov     r13, 0

        mov     rdi, 1              /* fd = 1 (stdout)                        */
        mov     rdx, 1              /* 1 seul caractère                       */
suivant:
        lea     rsi, [r12+r13]      /* Adresse du caractère                   */
        mov     rax, 1              /* Appel no 1 (write)                     */
        syscall                     /* Appel système                          */

        add     r13, 1              /* Passer au caractère suivant            */
        cmp     r13, longueur[rip]  /* Toute la longueur ?                    */
        jb      suivant             /* Si non, passer au suivant              */

        /* Terminer le processus.
           On utilise l'appel système exit(retval) pour mettre fin à un
           processus. Cet appel est le nunméro 60.                            */
        mov     rdi, 0              /* Valeur de retour (ici 0)               */
        mov     rax, 60             /* Appel  60 (exit)                       */
        syscall

/* Equivalent C :

	char *msg = "Bonjour tout le monde !";
	int longueur = 23;
	int i = 0;	// i <=> r13, r13 représente un compteur/index
	char s;    //

	do{
		s = msg[i];
		printf('%c',s)
		i = i + 1;
	}while(i < longueur);

