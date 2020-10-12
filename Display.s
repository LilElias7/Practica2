PROCESSOR 16F887
#include <xc.inc>
;Configuracion word1  (configuramos los fuses)
CONFIG FOSC = INTRC_NOCLKOUT
CONFIG WDTE = OFF
CONFIG PWRTE = ON
CONFIG MCLRE = OFF
CONFIG CP = OFF
CONFIG CPD = OFF
CONFIG BOREN = OFF
CONFIG IESO = OFF
CONFIG FCMEN = ON
CONFIG DEBUG = ON

    ;Configuracion word2
CONFIG BOR4V=BOR40V
CONFIG WRT = OFF
PSECT udata
pause1:     ;Definimos las pausas o cambios que seran de 500ms aprox.
    DS 1
pause2:
    DS 1
pause3:
    DS 1
PSECT resetVec,class=CODE,delta=2
resetVec:
PAGESEL main
goto main
                      ;Mostramos los numeros en pantalla del 0 al 9
PSECT code
numero0:
BANKSEL PORTB
movlw 0b00111111
movwf PORTB
PAGESEL main
return

PSECT code
numero1:
BANKSEL PORTB
movlw 0b00000110
movwf PORTB
PAGESEL main
return

PSECT code
numero2:
BANKSEL PORTB
movlw 0b01011011
movwf PORTB
PAGESEL main
return
    
PSECT code
numero3:
BANKSEL PORTB
movlw 0b01001111
movwf PORTB
PAGESEL main
return    

PSECT code
numero4:
BANKSEL PORTB
movlw 0b01100110
movwf PORTB
PAGESEL main
return

PSECT code
numero5:
BANKSEL PORTB
movlw 0b01101101
movwf PORTB
PAGESEL main
return
   
PSECT code
numero6:
BANKSEL PORTB
movlw 0b01111101
movwf PORTB
PAGESEL main
return

PSECT code
numero7:
BANKSEL PORTB
movlw 0b00000111
movwf PORTB
PAGESEL main
return

PSECT code
numero8:
BANKSEL PORTB
movlw 0b01111111
movwf PORTB
PAGESEL main
return

PSECT code
numero9:
BANKSEL PORTB
movlw 0b01101111
movwf PORTB
PAGESEL main
return
                       ;Configuramos las pausas o cambios que seran de 500ms aprox.
PSECT code
delay_255us:
movlw   0xff
movwf   pause3
decfsz pause3
goto $-1
return

PSECT code
delay_65ms:
movlw   0xff
movwf   pause2
call delay_255us
decfsz pause2
goto $-2
return
 
PSECT code
delay_500ms:
movlw   0x08
movwf pause1
call delay_65ms
decfsz  pause1
goto $-2
return
   
PSECT code
main:
bcf STATUS,0
bcf STATUS,5
bcf STATUS,6
BANKSEL ANSELH
clrf ANSELH
BANKSEL TRISB
movlw 0b00000000
movwf TRISB
BANKSEL PORTB
clrf PORTB
BANKSEL OSCCON
movlw  0b01110000
movwf  OSCCON
                                ;Hacemos los llamados finales
    START:
call numero0
call delay_500ms
call numero1
call delay_500ms
call numero2
call delay_500ms   
call numero3
call delay_500ms
call numero4
call delay_500ms
call numero5
call delay_500ms
call numero6
call delay_500ms
call numero7
call delay_500ms
call numero8
call delay_500ms
call numero9
call delay_500ms
GOTO START       ;Nos hace un bucle y nos regresa al inicio o start.
END


