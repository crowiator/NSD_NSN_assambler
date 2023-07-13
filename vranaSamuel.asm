byte 0x03 ;znak '0'
byte 0x9F ;znak '1'
byte 0x25 ;znak '2'
byte 0x0d ;znak '3'
byte 0x99 ;znak '4'
byte 0x49 ;znak '5'
byte 0x41 ;znak '6'
byte 0x1f ;znak '7'
byte 0x01 ;znak '8'
byte 0x09 ;znak '9'
mvi A,0xFF
	out 0000b,A

Start:
	;1.riadok
	inn A,1110b 	;indikuje, ze to je 1.riadok
	ani A,00001111b
	cmi A,0111b
	je Nula       	;sluzi na stlacenie klavesy '0'
	cmi A,1011b
	je Jeden	;sluzi na stlacenie klavesy '1'
	cmi A,1101b
	je Dva		;sluzi na stlacenie klavesy '2'
	cmi A,1110b
	je Tri		;sluzi na stlacenie klavesy '3'
	;2.riadok
	inn A,1101b	;indikuje, ze to je 2.riadok
	ani A,00001111b
	cmi A,0111b
	je Styri	;sluzi na stlacenie klavesy '4'
	cmi A,1011b
	je Pat		;sluzi na stlacenie klavesy '5'
	cmi A,1101b
	je Sest		;sluzi na stlacenie klavesy '6'
	cmi A,1110b
	je Sedem	;sluzi na stlacenie klavesy '7'
	;3.riadok
	inn A,1011b	;indikuje, ze to je 3.riadok
	ani A,00001111b
	cmi A,0111b
	je Osem		;sluzi na stlacenie klavesy '8'
	cmi A,1011b
	je Devat	;sluzi na stlacenie klavesy '9'
	cmi A,1101b
	je A		;sluzi na stlacenie klavesy 'A'
	cmi A,1110b
	je B		;sluzi na stlacenie klavesy 'B'
	;4 riadok
	inn A,0111b	;indikuje, ze to je 4.riadok
	ani A,00001111b
	cmi A,0111b
	je C		;sluzi na stlacenie klavesy 'C'
	cmi A,1011b
	je D		;sluzi na stlacenie klavesy 'D'
	jmp Start
	
Nula:
	cal cakaj ;skoc na navestie cakaj, pouziva sa pri dvoj kliku
	mvi B,0		; do B si ulozim cislo, ktore je reprezentovane klavesou
	inc D		; sluzi kvoli zisteni, na akom mieste sa nachadza dana cislica
	jmp NacitajCislo
	jmp Start
Jeden:
	cal cakaj
	mvi B,1		; do B si ulozim cislo, ktore je reprezentovane klavesou
	inc D
	jmp NacitajCislo
	jmp Start
Dva:
	cal cakaj
	mvi B,2		
	inc D
	jmp NacitajCislo
	jmp Start
Tri:	
	cal cakaj
	mvi B,3
	inc D
	jmp NacitajCislo
	jmp Start
Styri:
	cal cakaj
	mvi B,4
	inc D
	jmp NacitajCislo
	jmp Start
Pat:	
	cal cakaj
	mvi B,5
	inc D
	jmp NacitajCislo
	jmp Start
Sest:	
	cal cakaj
	mvi B,6
	inc D
	jmp NacitajCislo
	jmp Start
Sedem:	
	cal cakaj
	mvi B,7
	inc D
	jmp NacitajCislo
	jmp Start
Osem:	
	cal cakaj
	mvi B,8
	inc D
	jmp NacitajCislo
	jmp Start
Devat:
	cal cakaj
	mvi B,9
	inc D
	jmp NacitajCislo
	jmp Start
A:
;ked stlacim A tak  sa vypocita najvacsi spolocny delitel	
mvi A,0xFF
out 0000b,A ;vycisti vsetke displeje
	cal cakaj
	jmp GCD 
B:
 ; ked stlacim B tak  sa vypocita najmensi spolocny nasobok
mvi A,0xFF
out 0000b,A ;sluzi na 'vycistenie displeja'
mvi A,0
	pop D
	pop C
	pop B
	cal cakaj
	jmp LCD  
C:
	cal cakaj
	jmp Koniec ; ked stlacim C tak  ukoncim program
D:
	cal cakaj
	mvi A,0xFF
	out 0000b,A
	mvi A,0
	mvi B,0
	mvi C,0
	mvi D,0
	jmp Start ;ked stlacim D tak  restartujem program
NacitajCislo:
	cmi D,1 	; 1- znamena, ze to je na pozicii stoviek
	je Sto
	cmi D,2 	; 2- znamena, ze to je na pozicii desiatok
	je Desat
	cmi D,3          ; 3 - znamena na pozicii jednotiek
	je Jedna
	
Sto:
	mmr A,B ;sluzi na vypis na displej
	out 1101b,A ; vypise sa to 2.displej zlava
	mvi A,100 ;davam 100 do A, lebo to budem nasobit
	jmp Nasobenie100;
Desat:
	mmr A,B ;sluzi na vypis na displej
	out 1011b,A ; vypise sa to 3.displej zlava
	mvi A,10	;davam 10 do A, lebo to budem nasobit
	jmp Nasobenie10
Jedna:
	mmr A,B
	out 0111b,A ;sluzi na vypis na displeji posledny
	mvi A,0
	add C,B ;pripocitam posledne cislo do C
	jmp Cislo
Nasobenie100:
	cmi A,0  ;ak bude A=0, tak ukonci nasobenie a skoc na start kvoli dalsej cislici
	je Start
	add C,B ;budem pripocitavat do C, to konkretne cislo
	dec A	;cyklus, kedze na zaciatko v A=100 a budem postupne dekrementovat
	jmp Nasobenie100
Nasobenie10:
	cmi A,0	;ak bude A=0, tak ukonci nasobenie a skoc na start kvoli dalsej cislici
	je Start
	add C,B ;budem pripocitavat do C, to konkretne cislo
	dec A	;cyklus, kedze na zaciatko v A=10 a budem postupne dekrementovat
	jmp Nasobenie10
cakaj:
inn a,0 ; precitam stav celej klavesnice
;inn a,1011b ;stlacil som A?
ani a,00001111b
cmi a,1111b ;ci je stlacene akekolvek tlacidlo
;cmi a,1101b
jne cakaj
ret
Cislo:
	pus C ;vlozim C, to cislo, pre ktore chcem vykonat operacie
	mvi D,0 ;vynulujem, lebo s nim budem robit pri dalsom cisle
	mvi C,0 ;vynulujem, lebo s nim budem robit pri dalsom cisle
	jmp Start ;skocim na start, aby som zadal dalsie cislo, v pripade ak uz ma 2 cisla tak operaciu
GCD:
	pop C ;vyberiem si 1. cislo do registra C
	pop B	;vyberiem si 2. cislo do registra B
	pus C ;naspat ich dam zasobnika, lebo ich budem potrebovat pri najmensom spolocnom nasobku
	pus B ; naspat ich dam zasobnika, lebo ich budem potrebovat pri najmensom spolocnom nasobku
	mvi D,10 ; do D si dam preto 10, aby mi presiel nasledovny cyklus
Cyklus:
	cmi D,0
	je Vypis
	cmp C,B 	;porovnam cisla, aby som mohol nasledovne odcitavat, (robit delenie)
	jg NavestieC
	jl NavestieB
NavestieC:
	mvi D,0 ; sluzi na zvysok
	mvi A,0 ;A sluzi ako podiel 
Delenie:
	cmp C,B 
	jl Vyskoc
	sub C,B ;odcitavam napr. GCD(25,10) 25-10,15-10, 
	inc A ; tu sa mi uklada podiel,1,2
	mov D,C ;tu si ukladam zvysok,5
	jmp Delenie
Vyskoc:
	jmp Cyklus	
NavestieB:
	mvi D,0
	mvi A,0
DelenieB:
	cmp B,C
	jl Vyskoc
	sub B,C
	inc A
	mov D,B
	jmp DelenieB
Vypis:
	cmi C,0  
	jg ZvysokC ; v C je ulozeny GCD
	cmi B,0
	jg ZvysokB ;v B je ulozeny GCD
	jmp Display
ZvysokC:
	pus C ;do zasobnika si vlozim zvysko
	mvi A,0
	str A,C
	jmp Display
ZvysokB:
	mov C,B
	pus C
	mvi A,0
	str A,C
	jmp Display
Display:
	cmi C,10
	jl Vypis1D
	cmi C,100
	jge Delenie100
	jle Delenie10
	jmp Start
Vypis1D:
	mmr A,C
	out 0111b,A
	jmp Start
Delenie100:
	mvi D,0
Cyklus100:
	cmi C,100
	jl Vypis3D
	sbi C,100
	inc D
	jmp Cyklus100
Delenie10:
	mvi D,0
Cyklus10:
	cmi C,10
	jl Vypis2D
	sbi C,10
	inc D
	jmp Cyklus10	

Vypis3D:
	mmr A,D
	out 1101b,A
	mvi D,0  ;***********************************************
	mmr A,D
	out 1011b,A
	 ;***********************************************
	jmp Display
Vypis2D:
	mmr A,D
	out 1011b,A
	jmp Display
LCD:
	mvi D,0
	mov D,C
	mov C,B	
NasobenieCB:
	dec D
	cmi D,0
	je DELENIEGCD
	add B,C
	jcy Error
	jmp NasobenieCB
Error:
	mvi A,01100001b ; do A si ulozim ako keby E, ktore vypise chybu pri prekroceni velkosti registra
	out 1011b,A ;3 displej
	out 1101b,A ;2.dispelj
	out 0111b,A ;1.displej
	;nasledujuci kod, vypise na konzolu CHYBA MALY REGISTER
	mvi D, 'C'
	scall dsp
	mvi D, 'H'
	scall dsp
	mvi D, 'Y'
	scall dsp
	mvi D, 'B'
	scall dsp
	mvi D, 'A'
	scall dsp
	mvi D, ' '
	scall dsp
	mvi D, 'M'
	scall dsp
	mvi D, 'A'
	scall dsp
	mvi D, 'L'
	scall dsp
	mvi D, 'Y'
	scall dsp
	mvi D, ' '
	scall dsp
	mvi D, 'R'
	scall dsp
	mvi D, 'E'
	scall dsp
	mvi D, 'G'
	scall dsp
	mvi D, 'I'
	scall dsp
	mvi D, 'S'
	scall dsp
	mvi D, 'T'
	scall dsp
	mvi D, 'E'
	scall dsp
	mvi D, 'R'
	scall dsp
	mvi D, 13
	scall dsp
	jmp Start	
DELENIEGCD:
	mvi A,0 ; do A davam 0 preto, lebo register A sa menila pri vypise a teraz ju vyuzijem na ukladanie podielu
	ldr C,A	; davam GCD
CyklusDelenia:	
	cmp B,C ; v B mam nasobok m*n a teraz urobim delenie s GCD a dostanem LCM
	jl KoniecDelenia
	sub B,C
	inc A
	jmp CyklusDelenia
KoniecDelenia:
	mov C,A
	jmp Display
Koniec:
	mvi A,0xFF
	out 0000b,A
