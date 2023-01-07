/*  programme.S

    MI01 - TP Assembleur 1

    Affiche un caractère à l'écran                                            */
.file "programme.S"
.intel_syntax noprefix

/* Section de données */
.data

cara:       .byte   'A


/* Section de code */
.text

/*  Le symbole _start est le point d'entrée du programme, il repère l'adresse de
    la toute première instruction exécutée. Il est défini comme global sans quoi
    l'éditeur de liens ne pourra pas le trouver.                              */
.global _start
_start:
        /*  L'interface générale des appels systèmes linux est la suivante:
              * rax : numéro d'appel système
              * rdi : 1er paramètre
              * rsi : 2ème paramètre
              * rdx : 3ème paramètre
              * r10 : 4ème paramètre
              * r8 : 5ème paramètre
              * r9 : 6ème paramètre
            Si l'appel produit une valeur de retour, elle est dans rax.       */

        /*  Affichager un caractère.
            On utilise l'appel système write(fd, buffer, len) pour afficher le
            caractère. Cet appel est le numéro 1.                             */
        mov     rax, 1              /* Appel no 1 (write)                     */
        mov     rdi, 1              /* fd = 1 (stdout)                        */
        lea     rsi, cara[rip]      /* Adresse du caractère                   */
        mov     rdx, 1              /* 1 seul caractère                       */
        syscall                     /* Appel système                          */

        /*  Terminer le processus.
            On utilise l'appel système exit(retval) pour mettre fin à un
            processus. Cet appel est le numéro 60.                            */
        mov     rax, 60             /* Appel 60 (exit)                        */
        mov     rdi, 0              /* Valeur de retour (ici 0)               */
        syscall
