# Assembly Robot

A assembly program, the robot needs to turn on the light.

![photo](https://user-images.githubusercontent.com/32064166/79925422-b76df000-8410-11ea-98da-e2f1f233da9b.PNG)

## Getting Started

To run and test the aplication, you basically need to install the EMU8086 and have their own license.

### Prerequisites

Import the library robot, use the flowwing code:

```
#start=robot.exe#
name "robot"     

```

### How works?

Out robot just go ahead, so, we need to verify if, in front of he there is some objet like wall, if doesn't have, go ahed, and before return to the loop, we verify again if in front of he there is no more blocks, this give us more speed to the robot. This loop is called 'frente'. Follow the code below: 

```
call wait_robot
    mov dx, 9
    mov al, 00000001b
    out dx, al  
        
    cmp al, 0     
    jz frente
```

We verify if thereis nobody in front the robot using:

```
   call wait_robot      
    mov dx,9
    mov al,00000100b 
    out dx, al
    
    call wait_exam
    mov dx,10
    in  al,dx  
```

In case there is a wall, our system generate a random, 0 or 1, that's will detarminate if we go to the right or left.


```
   call random_turn
   
   
    random_turn proc
        mov ah, 0
        int 1ah
        xor dh, dl
        xor ch, cl
        xor ch, dh 
        
        
        and ch,00000001b         
        
        
        cmp ch, 00000001b    ; if it isn't 1 go right
        jnz move_direita
        
  

        mov dx,9
        mov al,00000010b
        out dx,al        ; if  1, go left
        ret             
                      
    move_direita: 
        call wait_robot
        mov dx,9
        mov al,00000011b
        out dx,al 
        ret
    random_turn endp  
   
```
For each loop we need to verify if the robot find the light, to find we use:


```
    call wait_robot
    mov dx,9
    mov al,00000100b 
    out dx, al
    
    call wait_exam
    mov dx,10
    in  al,dx 
    
    cmp al, 00001000b     
    jz switch_on_lamp
```

In case of found we jump to 'switch_on_lamp' and finish the program

```
    switch_on_lamp: 
        mov al, 5
        out r_port, al
        fim: jmp fim
```

## Built With

* Assembly


This project looks great, - it's time to merge! :shipit:

