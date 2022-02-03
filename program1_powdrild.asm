TITLE Elementary Arithmetic (Prog01)     (program1_powdrild.asm)

; Author: David Powdrill
; Last Modified: 4/11/2020
; OSU email address: powdrild@oregonstate.edu
; Course number/section: CS271-400
; Project Number: 01                 Due Date: 4/12/2020
; Description: A MASM program that prompts the user to enter 3 numbers in descening order and the program will run various calculations (A+B, A-B, A+C, A-C, B+C, B-C, A+B+C, B-A, C-A, C-B, C-B-A) and displays them to the user.

INCLUDE Irvine32.inc


.data
varA			DWORD	?															;first number entered by user
varB			DWORD	?															;second number entered by user
varC			DWORD	?															;third number entered by user
plus			BYTE	" + ", 0
minus			BYTE	" - ", 0
equal			BYTE	" = ", 0
negative		BYTE	"-", 0
intro_1			BYTE	"		Elementary Arithmetic	by David Powdrill ", 0 
instruct_1		BYTE	"Enter 3 numbers A > B > C, and I'll show you the sums and differences. ", 0
prompt_1		BYTE	"First number: ", 0
prompt_2		BYTE	"Second number: ", 0
prompt_3		BYTE	"Third number: ", 0
ec_1			BYTE	"**EC: Repeat until the user chooses to quit. ", 0
ec_2			BYTE	"**EC: Checks if numbers are in non-descending order. ", 0
ec_3			BYTE	"**EC: Handles negative results and computes B-A, C-A, C-B, C-B-A. ", 0
error			BYTE	"ERROR: The numbers are not in descending order! ", 0
sumAB			DWORD	?
diffAB			DWORD	?
sumAC			DWORD	?
diffAC			DWORD	?
sumBC			DWORD	?
diffBC			DWORD	?
sumABC			DWORD	?
diffBA			DWORD	?
diffCA			DWORD	?
diffCB			DWORD	?
diffCBA			DWORD	?
goodBye			BYTE	"Impressed? Bye! ", 0

.code
main PROC

again:

;------------------------------
;Introduces title of program and author
; and displays the extra credit that was done.
;------------------------------
	;print title and author
	mov		edx, OFFSET	intro_1		
	call	WriteString				
	call	CrLf		

	;print ec statement #1
	mov		edx, OFFSET ec_1		
	call	WriteString				
	call	CrLf		

	;print ec statement #2
	mov		edx, OFFSET ec_2		
	call	WriteString				
	call	CrLf

	;print ec statement #3
	mov		edx, OFFSET ec_3		
	call	WriteString				
	call	CrLf					
	call	CrLf		
	
;------------------------------
;Instructs user to input 3 numbers in descending
; order and stores intgers as varA, varB, & varC respectively. 
; If the numbers are not in descending order, an error 
; message is recieved and the user must re-input their numbers.
;------------------------------
	;print intructions
	mov		edx, OFFSET	instruct_1	
	call	WriteString				
	call	CrLf					
	call	CrLf

	;get data from user
prompts:
	;get first number
	mov		edx, OFFSET prompt_1	
	call	WriteString				
	call	ReadInt					
	mov		varA, eax				;stores integer as varA

	;get second number
	mov		edx, OFFSET prompt_2	
	call	WriteString				
	call	ReadInt					
	cmp		eax, varA				;compares varA to integer entered
	jge		errorr					;jumps to errorr if varB is greater than varA
	mov		varB, eax				;stores integer as varB

	;get third number
	mov		edx, OFFSET prompt_3	
	call	WriteString				
	call	ReadInt					
	cmp		eax, varB				;compares varB to integer entered
	jge		errorr					;jumps to errorr if varC is greater than varB
	mov		varC, eax				;stores integer as varC
	call	CrLf					
	jmp		quitt			
	
errorr:		
	mov		edx, OFFSET error	
	call	WriteString				
	call	CrLf					
	call	CrLf					
	jmp		prompts					

quitt:

;------------------------------
;Calculations for all equations. All 
; answers are stored as their respected
; variable. For all negative answers negation
; is used.
;------------------------------
	;calculates sumAB
	mov		eax, varA				
	add		eax, varB				;add varB to varA
	mov		sumAB, eax			
	
	;calculates diffAB
	mov		eax, varA				
	sub		eax, varB				;subtracts varB from varA
	mov		diffAB, eax		
	
	;calculates sumAC	
	mov		eax, varA				
	add		eax, varC				;adds varC to varA
	mov		sumAC, eax		
	
	;calculates diffAC
	mov		eax, varA				
	sub		eax, varC				;subtracts varC from varA
	mov		diffAC, eax	
	
	;calculates sumBC	
	mov		eax, varB				
	add		eax, varC				;adds varC to varB
	mov		sumBC, eax	
	
	;calculates diffBC
	mov		eax, varB				
	sub		eax, varC				;subtracts varC from varB
	mov		diffBC, eax	
	
	;calculates sumABC	
	mov		eax, varA				
	add		eax, varB				;adds varB to varA
	add		eax, varC				;adds varC to sum of varA and varB
	mov		sumABC, eax	
	
	;calculates diffBA	
	mov		eax, varB				
	sub		eax, varA				;subtracts varA from varB
	neg		eax						
	mov		diffBA, eax	
	
	;calculates diffCA	
	mov		eax, varC				
	sub		eax, varA				;subtracts varA from varA
	neg		eax						
	mov		diffCA, eax	
	
	;calculates diffCB	
	mov		eax, varC				
	sub		eax, varB				;subtract varB from varC
	neg		eax						
	mov		diffCB, eax	
	
	;calculates diffCBA
	mov		eax, varC				
	sub		eax, varB				;subtracts varB from varC
	sub		eax, varA				;subtracts varA from answer of varC-varB
	neg		eax						
	mov		diffCBA, eax			

;------------------------------
;Displays all 11 equations line by line with 
; the answer in the same row as the equation.
;------------------------------
	;displays sumAB
	mov		eax, varA				
	call	WriteDec				
	mov		edx, OFFSET plus		
	call	WriteString				
	mov		eax, varB				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		eax, sumAB			
	call	WriteDec				
	call	CrLf	
	
	;displays diffAB
	mov		eax, varA				
	call	WriteDec				
	mov		edx, OFFSET minus		
	call	WriteString				
	mov		eax, varB				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		eax, diffAB			
	call	WriteDec				
	call	CrLf	
	
	;displays sumAC
	mov		eax, varA				
	call	WriteDec				
	mov		edx, OFFSET plus		
	call	WriteString				
	mov		eax, varC				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		eax, sumAC		
	call	WriteDec				
	call	CrLf	
	
	;displays diffAC
	mov		eax, varA				
	call	WriteDec				
	mov		edx, OFFSET minus		
	call	WriteString				
	mov		eax, varC				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		eax, diffAC			
	call	WriteDec				
	call	CrLf	
	
	;displays sumBC
	mov		eax, varB				
	call	WriteDec				
	mov		edx, OFFSET plus		
	call	WriteString				
	mov		eax, varC				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		eax, sumBC			
	call	WriteDec				
	call	CrLf		
	
	;displays diffBC
	mov		eax, varB				
	call	WriteDec				
	mov		edx, OFFSET minus		
	call	WriteString				
	mov		eax, varC				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		eax, diffBC			
	call	WriteDec				
	call	CrLf		
	
	;displays sumABC
	mov		eax, varA				
	call	WriteDec				
	mov		edx, OFFSET plus		
	call	WriteString				
	mov		eax, varB				
	call	WriteDec				
	mov		edx, OFFSET plus		
	call	WriteString			
	mov		eax, varC				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		eax, sumABC		
	call	WriteDec				
	call	CrLf		
	
	;displays diffBA
	mov		eax, varB				
	call	WriteDec				
	mov		edx, OFFSET minus		
	call	WriteString				
	mov		eax, varA				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		edx, OFFSET negative	
	call	WriteString				
	mov		eax, diffBA		
	call	WriteDec				
	call	CrLf		
	
	;displays diffCA
	mov		eax, varC				
	call	WriteDec				
	mov		edx, OFFSET minus		
	call	WriteString				
	mov		eax, varA				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		edx, OFFSET negative	
	call	WriteString				
	mov		eax, diffCA			
	call	WriteDec				
	call	CrLf		
	
	;displays diffCB
	mov		eax, varC				
	call	WriteDec				
	mov		edx, OFFSET minus		
	call	WriteString				
	mov		eax, varB				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		edx, OFFSET negative	
	call	WriteString				
	mov		eax, diffCB			
	call	WriteDec				
	call	CrLf		
	
	;displays diffCBA
	mov		eax, varC				
	call	WriteDec				
	mov		edx, OFFSET minus		
	call	WriteString				
	mov		eax, varB				
	call	WriteDec				
	mov		edx, OFFSET minus		
	call	WriteString				
	mov		eax, varA				
	call	WriteDec				
	mov		edx, OFFSET equal		
	call	WriteString				
	mov		edx, OFFSET negative	
	call	WriteString				
	mov		eax, diffCBA			
	call	WriteDec				
	call	CrLf	
	call	CrLf

;------------------------------
;Says Goodbye to user and repeats the program
;------------------------------
	;prints goodBye message
	mov		edx, OFFSET goodBye		
	call	WriteString				
	call	CrLf		
	call	CrLf
	jmp		again					;repeats program

	exit	; exit to operating system
main ENDP



END main





	;checks to see if number is 5 or 7
	mov		eax, value
	cmp		eax, 5
	je		notcomposite
	cmp		eax, 7
	je		notcomposite