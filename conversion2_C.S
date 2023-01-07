/*  conversion2_C.S

    MI01 - TP Assembleur 1

*/
.file "conversion2_C.S"
.intel_syntax noprefix

/* Section de données */
.data

nombre:         .quad   0x1c615658fa0b1
chaine:         .fill   15 /*15 pour la base 10, 10 pour la base 30 (car connaissance du nombre) ou 64
							  pour conversion de n'importe quel chiffre dans n'importe quelle base.
							  Nous pouvons aussi utiliser 20 comme valeur de sûreté si en base 10*/
chiffres: .ascii "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
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

		xor r13,r13
		mov rax, nombre[rip]
		mov rbx, 10
		/*mov rbx, 30  SI CONVERSION EN BASE 30*/
		lea r12, chaine[rip]
		lea r11, chiffres[rip]

boucle:
		xor rdx, rdx
		div rbx
		mov dl, byte ptr [r11+rdx] /* on met dans dl la valeur ascii correspondant à la valeur de l'adresse du tableau plus le reste de la division */
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
