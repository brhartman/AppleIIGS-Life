; ------------------------------------------------------------------------------
; memory.s
; ------------------------------------------------------------------------------
              mx        %00


UserId        ds        2
MemId         ds        2

MemAttrDP     equ       %11000000_00000101
MemAttrAlgn   equ       %11000000_00011100
MemAttrUI     equ       %00000000_00000000


; MemStartUp
; ------------------------------------------------------------------------------
MemStartUp    stz       MMAppId
              pha
              _MMStartUp
              pla
              bcc       :MMStarted

; _MMStartUp likely failed because we are not running from GS/OS
; Create a new id, allocate banks 0 and 1, and then try _MMStartUp again

; Create a new id
              PushWord  #$0000
              PushWord  #$1000
              _GetNewID
              jsr       CheckError
              pla
              sta       MMAppId

; Allocate all of bank0
              PushLong  #$0000
              PushLong  #$b800
              PushWord  MMAppId
              PushWord  #$c002
              PushLong  #$00000800
              _NewHandle
              jsr       CheckError
              PullLong  MMBank0

; Allocate all of bank1
              PushLong  #$0000
              PushLong  #$b800
              PushWord  MMAppId
              PushWord  #$c002
              PushLong  #$00010800
              _NewHandle
              jsr       CheckError
              PullLong  MMBank1

; Try _MMStartUp again
              pha
              _MMStartUp
              jsr       CheckError
              pla

:MMStarted    sta       UserId
              ora       #$0100
              sta       MemId

              rts

MMAppId       ds        2

MMBank0       ds        4
MMBank1       ds        4


; MemShutdown
; ------------------------------------------------------------------------------
MemShutdown   lda       MMAppId
              beq       :MMShutdown

              PushLong  MMBank1
              _DisposeHandle
              PushLong  MMBank0
              _DisposeHandle
              PushWord  MMAppId
              _DeleteID

:MMShutdown
              PushWord  MemId
              _DisposeAll

              PushWord  UserId
              _MMShutDown
              rts


; NewAlloc
; Stack = block size (long), attribute flags (word)
; Return Stack = block handle
; ------------------------------------------------------------------------------
NewAlloc
              plx                           ; rts address
              PullWord  MemBlockAttr
              PullLong  MemBlockSize
              phx                           ; rts address

; Allocate the memory block
              PushLong  #$0000
              PushLong  MemBlockSize
              PushWord  MemId
              PushWord  MemBlockAttr
              PushLong  #$0000
              _NewHandle
              jsr       CheckError
              PullLong  DPMem1

; Push the block handle
              plx                           ; rts address
              PushLong  DPMem1
              phx                           ; rts address

              rts

MemBlockSize  ds        4
MemBlockAttr  ds        2


; DerefHandle
; Stack = block handle
; Return a,x = block pointer
; ------------------------------------------------------------------------------
DerefHandle
              plx                           ; rts address
              PullLong  0
              phx                           ; rts address

; Dereference the block handle to a,x
              ldy       #$2
              lda       [0],y
              tax
              lda       [0]

              rts


; ; NewAlloc
; ; Stack = block size
; ; Return Stack = block handle, block pointer
; ; ------------------------------------------------------------------------------
; NewAlloc
;               plx                            ; rts address
;               PullLong  MemBlockSize
;               phx                            ; rts address

; ; Allocate the memory block
;               PushLong  #$0000
;               PushLong  MemBlockSize
;               PushWord  MemId
;               PushWord  #%11000000_00011100
;               PushLong  #$0000
;               _NewHandle
;               jsr       CheckError
;               PullLong  DPMem1

; ; Store a pointer to the memory in DPMem2 using DPMem0 for direct page access
;               lda       DPMem1
;               sta       DPMem0
;               lda       DPMem1+2
;               sta       DPMem0+2
;               lda       [DPMem0]
;               sta       DPMem2
;               ldy       #$2
;               lda       [DPMem0],y
;               sta       DPMem2+2

; ; DPMem1 is the block handle, DPMem2 is the block pointer

; ; Push the block pointer and block handle
;               plx                            ; rts address
;               PushLong  DPMem2
;               PushLong  DPMem1
;               phx                            ; rts address

;               rts

; MemBlockSize  ds        4
