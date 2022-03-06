.global main                                    

formatstr: .asciz "%ld"                         
mynumberoutput: .asciz "The result is: %ld \n"  
inputprompt1: .asciz "Please enter an integer base: " 
inputprompt2: .asciz "Please enter an integer exponent: "


.global main
main: 
    pushq   %rbp                        # beggining 
    movq    %rsp, %rbp                  # beggining

    subq    $16, %rsp                   # make space

    movq    $inputprompt1, %r15         # move inputprompt1 into r15
    call    input                       # call the method input for the imput prompt
    movq    %rdx, %r12                  # put the result into r12

    movq    $inputprompt2, %r15         # move inputprompt2 in r15
    call    input                       # call the method input for the imput prompt 
    movq    %rdx, %r13                  # put the result into r13

    call   pow                          # callmultiply

input: 
    pushq   %rbp                        # beggining 
    movq    %rsp, %rbp                  # beggining

    movq    $1, %r14                    # move 1 into r14
         
    movq    %r15, %rdi                  # prepare for print statement, printing the string, located at r15 (in this case our inputprompt)
    call    printf                      # call for print

    subq    $16, %rsp                   # make space   
    
    leaq    -8(%rbp), %rsi              # prepare for scanf, puts rsi into the space above pbp (next by convention)
    movq    $formatstr, %rdi            # move formatstr into rdi such that it can be stored by user (next by convention)
    call    scanf                       # ask for input 

    movq    -8(%rbp), %rdx              # ask madi, core dump if removed 

    movq    %rbp, %rsp                  # end       
    popq    %rbp                        # end
    ret                                 # return

pow:
    pushq   %rbp                        # beginning                    
    movq    %rsp, %rbp                  # beginning 

    cmpq    $0, %r13                    # compare 0 to r13, the exponent
    jle     powend                      # jump to powend if less or equal (thus printing r14, currently the value 1)
    imulq   %r12, %r14                  # multiply integer (r12) with 1 (r14) and put it at location r14
    decq    %r13                        # decrease the exponent by 1 
    jmp pow                             # jump to pow, the begining 
    
    call    powend                      # call the subroutine powend

powend:
   # movq    $0, %rax                   # not needed 
    movq    $mynumberoutput, %rdi       # prepare for print, printing the string
    movq    %r14, %rsi                  # print the value located at r14
    call    printf                      # call for print
    call    end                         # call the end of the program

end:
    mov     $0,  %rdi                   # first argument of exit, sets the exit code to 0
    call    exit                        # calls exit