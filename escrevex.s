/*
* \author: Éder Augusto Penharbel
* \date: February, 2022
* \version: February, 2022
*/

# generate 16-bit code
.code16 			   
# executable code location
.text 				   

.globl _start

# entry point
_start:				    

    # character to print
    movb $'x' , %al		
    # bios service code to print
    movb $0x0e, %ah	
    # bios service (interrupt) 
    int  $0x10		  
    
    # mov to 510th byte from 0 pos
    . = _start + 510	    
    
    # MBR boot signature 
    .byte 0x55		        
    # MBR boot signature 
    .byte 0xaa		        
