            org       $2000
            dsk       life.l

            mx        %00


; Macros
; ------------------------------------------------------------------------------

            use       Dos.16.Macs
            use       Locator.Macs
            use       Mem.Macs
            use       Misc.Macs
            use       Util.Macs

            use       utilities.macs


; Main
; ------------------------------------------------------------------------------

            phk
            plb

            jsr       Set16Bit

            _TLStartUp

            jsr       MemStartUp

            jsr       AllocateBoard
            PullLong  BoardCur
            PullLong  DPBoardCur

            jsr       AllocateBoard
            PullLong  BoardNext
            PullLong  DPBoardNext

            jsr       InitSeed

            jsr       LocatePEISlam

            SetColor  #$0000;#$0000
            SetColor  #$0001;#$0FFF
            SetColor  #$0002;#$0AAF
            SetColor  #$0003;#$0AFA
            SetColor  #$0004;#$0FFF

            lda       #$0000
            jsr       ClearToColor

; Comment out this line to debug with the monitor
            jsr       GraphicsOn

            jsr       InitBoard

Waiting
            jsr       UpdateBoard
            jsr       BoardToScreen

            jsr       CheckKey
            cmp       #$0001
            bne       Waiting

CleanUp
            jsr       GraphicsOff

            _MTShutDown

            jsr       MemShutdown

            _TLShutDown
            jsr       Quit


; Includes Begin
; ------------------------------------------------------------------------------

            use       board
            use       cells
            use       equates
            use       graphics
            use       memory
            use       random
            use       utilities

; Includes End
; ------------------------------------------------------------------------------
