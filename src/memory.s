; ------------------------------------------------------------------------------
; memory.s
; ------------------------------------------------------------------------------
              mx        %00


; NewAlloc
; Stack = block size
; Return Stack = block handle, block pointer
; ------------------------------------------------------------------------------
NewAlloc
              plx                            ; rts address
              PullLong  MemBlockSize
              phx                            ; rts address

; Allocate the memory block
              PushLong  #$0000
              PushLong  MemBlockSize
              PushWord  MyId
              PushWord  #%11000000_00011100
              PushLong  #$0000
              _NewHandle
              PullLong  DPMem1

; Store a pointer to the memory in DPMem2 using DPMem0 for direct page access
              lda       DPMem1
              sta       DPMem0
              lda       DPMem1+2
              sta       DPMem0+2
              lda       [DPMem0]
              sta       DPMem2
              ldy       #$2
              lda       [DPMem0],y
              sta       DPMem2+2

; DPMem1 is the block handle, DPMem2 is the block pointer

; Push the block pointer and block handle
              plx                            ; rts address
              PushLong  DPMem2
              PushLong  DPMem1
              phx                            ; rts address

              rts

MemBlockSize  ds        4


; MemStartUp
; Return: X = user memory id
; Return: Y = aux user memory id
; ------------------------------------------------------------------------------
MemStartUp    stz       MMAppId
              pha
              _MMStartUp
              pla
              bcc       :MMStarted

; _MMStartUp likely failed because we are not running from GS/OS
; Create a new id, allocate banks 0 and 1, and then try _MMStartUp again

              _MTStartUp

; Create a new id
              PushWord  #$0000
              PushWord  #$1000
              _GetNewID
              pla
              sta       MMAppId

; Allocate all of bank0
              PushLong  #$0000
              PushLong  #$b800
              PushWord  MMAppId
              PushWord  #$c002
              PushLong  #$00000800
              _NewHandle
              bcs       :VeryBad
              PullLong  MMBank0

; Allocate all of bank1
              PushLong  #$0000
              PushLong  #$b800
              PushWord  MMAppId
              PushWord  #$c002
              PushLong  #$00010800
              _NewHandle
              bcs       :VeryBad
              PullLong  MMBank1

; Try _MMStartUp again
              pha
              _MMStartUp
              pla
              bcs       :VeryBad

:MMStarted    tax
              ora       #$0100
              tay

              rts

:VeryBad      brk

MMAppId       ds        2

MMBank0       ds        4
MMBank1       ds        4


; MemShutdown
; A = user memory id
; ------------------------------------------------------------------------------
MemShutdown   pha
              lda       MMAppId
              beq       :MMShutdown

              PushLong  MMBank1
              _DisposeHandle
              PushLong  MMBank0
              _DisposeHandle
              PushWord  MMAppId
              _DeleteID
              _MTShutDown

:MMShutdown   _MMShutDown
              rts
