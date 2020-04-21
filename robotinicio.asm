
    
#start=robot.exe#


name "robot"     


r_port equ 9


; multi-segment executable file template.


data segment
ends


stack segment
    dw   128  dup(0)
ends


code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax


    
leitura:    
    
    
    call wait_robot
    mov dx,9
    mov al,00000100b 
    out dx, al
    
    call wait_exam
    mov dx,10
    in  al,dx  
    
    cmp al, 0      ; nada
    jz frente
    
    cmp al, 11111111b    ; parede
    jz cont  
    
    cmp al, 00001000b       ; luz acesa? apaga e terminou
    jz switch_on_lamp 
    
    
    

   
        
    cont:      
    call random_turn
    
    frente:
    call wait_robot
    mov dx, 9
    mov al, 00000001b
    out dx, al  
    
    call wait_robot      
    mov dx,9
    mov al,00000100b 
    out dx, al
    
    call wait_exam
    mov dx,10
    in  al,dx  
    
    cmp al, 0     
    jz frente
    
    
     
    

    
    jmp leitura
      
            
    mov ax, 4c00h ; exit to operating system.
    int 21h
    
;==================================

    wait_robot proc
    busy: 
          in al, r_port+2
          test al, 00000010b      
          jnz busy ; busy, so wait.
          ret    
    wait_robot endp 

    wait_exam proc
        busy2: in al, r_port+2
        test al, 00000001b
        jz busy2 ; no new data, so wait.
        ret    
    wait_exam endp  


    switch_on_lamp: 
        mov al, 5
        out r_port, al
        fim: jmp fim
                       
                       
    switch_off_lamp proc
    mov al, 6
    out r_port, al
    ret
    switch_off_lamp endp


    random_turn proc
        mov ah, 0
        int 1ah
        xor dh, dl
        xor ch, cl
        xor ch, dh 
        
        
        and ch,00000001b         
        
        
        cmp ch, 00000001b    ; se nao for 1, vai p direita
        jnz move_direita
        
  

        mov dx,9
        mov al,00000010b
        out dx,al        ; se retornar 1 vai pra esquerda
        ret             
                      
    move_direita: 
        call wait_robot
        mov dx,9
        mov al,00000011b
        out dx,al 
        ret
        
        
    ;move_esquerda:
        ;call wait_robot
        ;mov dx,9
        ;mov al,00000010b
        ;out dx,al 
 
    random_turn endp    
ends


end start ; set entry point and stop the assembler.
 

