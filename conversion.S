/*  conversion.S

    MI01 - TP Assembleur 1

    Convertir un nombre exprimé en base 16 vers un nombre affichable en base 10. */
.file "conversion.S"
.intel_syntax noprefix

/* Section de données */
.data

nombre:         .quad   0x1c615658fa0b1
chaine:         .fill   15/* Réserve 15 octets, initialisés à 0.*/

/* Section de code */
.text

/*  Le symbole _start est le point d'entrée du programme, il repère l'adresse de
    la toute première instruction exécutée. Il est défini comme global sans quoi
    l'éditeur de liens ne pourra pas le trouver. */
.global _start
_start:
        /**********************************************************************
         Début de votre code
         **********************************************************************/

		xor r13,r13            /* remise à 0 de r13 */
		mov rax, nombre[rip]
		mov rbx, 10
		lea r12, chaine[rip]

boucle:
		xor rdx, rdx
		div rbx
		add dl, 0x30				/* pour convertir en caractère ASCII, on ajoute + 0x30 */
		mov [r12 + r13], dl
		add r13, 1
		cmp rax, 0
		jne boucle
		/* préparation du syscall */
		mov rdi,1
		mov rdx,1
		mov rax,1			/* Appel no 1 (write)*/
		/**************************/

lecture:

		sub r13,1
		lea rsi, [r12+r13]	/*préparation du buffer (adresse de l'élément à afficher*/
		syscall				/* appel système */
		cmp r13, 0
		jne lecture


fin:
		/**********************************************************************
         Fin de votre code
         **********************************************************************/

        /* Terminer le processus.
           On utilise l'appel système exit(retval) pour mettre fin à un
           processus. Cet appel est le numéro 60.                             */
        mov     rax, 60             /* Appel 60 (exit)                        */
        mov     rdi, 0              /* Valeur de retour (ici 0)               */
        syscall
