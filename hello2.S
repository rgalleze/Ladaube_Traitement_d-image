/*  hello1.S

    MI01 - TP Assembleur 1

    Affiche une chaîne de caractères à l'écran                                */
.file "hello2.S"
.intel_syntax noprefix

/* Section de données */
.data

/*******************************************************************************
 Ajouter les variables msg et longueur ici
 ******************************************************************************/
msg :		.asciz "Bonjour tout le monde !"
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

        cmp     byte ptr [rsi], 0  /* Toute la longueur ?                    */
        jne      suivant             /* Si non, passer au suivant              */

        /* Terminer le processus.
           On utilise l'appel système exit(retval) pour mettre fin à un
           processus. Cet appel est le nunméro 60.                            */
        mov     rdi, 0              /* Valeur de retour (ici 0)               */
        mov     rax, 60             /* Appel  60 (exit)                       */
        syscall

/* Equivalent C :

	char *msg = "Bonjour tout le monde !";
	char *s;    //

	do{
		s = msg[i];
		printf('%c',s)
	}while(s);

