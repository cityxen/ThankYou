/////////////////////////////////////////////////////
// CityXen 256 Subscribers Special Video by Deadline
// Title: ZENZIZENZIZENZIC
// Thank You!

.segment Code []
.file [name="prg_files/ZENZIZENZIZENZIC.prg",segments="Code"]
.disk [filename="prg_files/ZENZIZENZIZENZIC.d64", name="256 SUBSCRIBERS!", id="CXN20" ] {
    [name="ZENZIZENZIZENZIC", type="prg",  segments="Code"]
}

*=$2ff0 "constants"
#import "../Commodore64_Programming/include/Constants.asm"
#import "../Commodore64_Programming/include/Macros.asm"
#import "../Commodore64_Programming/include/DrawPetMateScreen.asm"

*=$2000 "Sprites"
#import "256-sprites.asm"

*=$3000 "Character Data"
#import "characters-charset.asm"

*=$4000 "Screen Data"
#import "screen.asm"

.var music = LoadSid("Easyriff.sid");

*=music.location "Music"
.fill music.size, music.getData(i)

.print ""
.print "SID Data"
.print "--------"
.print "location=$"+toHexString(music.location)
.print "init=$"+toHexString(music.init)
.print "play=$"+toHexString(music.play)
.print "songs="+music.songs
.print "startSong="+music.startSong
.print "size=$"+toHexString(music.size)
.print "name="+music.name
.print "author="+music.author
.print "copyright="+music.copyright
.print ""
.print "Additional tech data"
.print "--------------------"
.print "header="+music.header
.print "header version="+music.version
.print "flags="+toBinaryString(music.flags)
.print "speed="+toBinaryString(music.speed)
.print "startpage="+music.startpage
.print "pagelength="+music.pagelength

.const SCREEN_BOTTOM_LEFT  = $7C0
.const SCREEN_BOTTOM_RIGHT = $7E7
.const COLORS_BOTTOM_LEFT  = $DBC0

//////////////////////////////////////////////////////////
// START OF PROGRAM
*=$0801 "BASIC"
    BasicUpstart2($0810)
*=$0810 "Program"

start:

    lda #$00
    sta $d020
    sta $d021
    ldx #0
    ldy #0
    lda #00
    jsr music.init
    sei
    lda #<irq1
    sta $0314
    lda #>irq1
    sta $0315
    asl $d019
    lda #$7b
    sta $dc0d
    lda #$81
    sta $d01a
    lda #$1b
    sta $d011
    lda #$80
    sta $d012
    cli
    
    lda VIC_MEM_POINTERS // point to the new characters
    ora #$0c
    sta VIC_MEM_POINTERS

    DrawPetMateScreen(screen_001)
    lda #$00
    sta COLORS_BOTTOM_LEFT-1

    ldx #$00
color_cycle_fill_loop:
    lda color_table,x
    sta COLORS_BOTTOM_LEFT,x
    sta COLORS_BOTTOM_LEFT+8,x
    sta COLORS_BOTTOM_LEFT+16,x
    sta COLORS_BOTTOM_LEFT+24,x
    sta COLORS_BOTTOM_LEFT+32,x
    inx
    cpx #$08
    bne color_cycle_fill_loop

    lda #$ff
    sta SPRITE_ENABLE

    lda yin_yang_anim
    sta SPRITE_0_POINTER // SPRITE 0: YIN YANG 1
    sta SPRITE_1_POINTER // SPRITE 1: YIN YANG 2

    lda eagle_anim       // SPRITE 2: EAGLE
    sta SPRITE_2_POINTER

    lda nauga_anim
    sta SPRITE_3_POINTER // SPRITE 3: NAUGA

    lda helm_anim
    sta SPRITE_4_POINTER // SPRITE 4: HELM

    lda #$98
    sta SPRITE_5_POINTER // SPRITE 5: YOUTUBE TRIANGLE
    sta SPRITE_7_POINTER // SPRITE 7: YOUTUBE TRIANGLE SHADOW

    lda clicky_anim
    sta SPRITE_6_POINTER // SPRITE 6: CLICKY
    
    ldx #$00 // LOCATIONS
    ldy #$00
sprite_locations_loop:
    lda sprite_loc_table,x // msb
    cmp #$ff
    beq sprite_locations_exit
    ora SPRITE_LOCATIONS_MSB
    sta SPRITE_LOCATIONS_MSB
    inx
    lda sprite_loc_table,x // sprite x loc
    sta SPRITE_LOCATIONS,y
    inx
    iny
    lda sprite_loc_table,x // sprite y loc
    sta SPRITE_LOCATIONS,y
    iny
    inx
    jmp sprite_locations_loop
sprite_locations_exit:

    lda #$05
    sta SPRITE_MULTICOLOR_0
    lda #$07 
    sta SPRITE_MULTICOLOR_1

    ldx #$00 // COLORS
sprite_colors_loop:
    lda sprite_color_table,x
    sta SPRITE_COLORS,x
    inx
    cpx #$08
    bne sprite_colors_loop


    lda #64+16+8+4 // 00111100
    sta SPRITE_MULTICOLOR

    lda #ORANGE
    sta SPRITE_MULTICOLOR_0
    lda #BLACK
    sta SPRITE_MULTICOLOR_1

    lda #$08
    sta SPRITE_EXPAND_Y
    sta SPRITE_EXPAND_X

loop256:
    
loop1b:

    inc vars+11
    lda vars+11
    cmp #$9b
    bne loop1c
    lda #$00
    sta vars+11
    inc vars+10
    ldx vars+10
    lda sinetable,x
    adc #$1a
    sta SPRITE_0_X
    inc vars+12
    ldx vars+12
    lda sinetable,x
    adc #$1a
    sta SPRITE_1_X

loop1c:
       
loop1d:
    lda #$f2         // Wait for raster line $f2
    cmp VIC_RASTER_COUNTER
    bne loop256      // if not at $f2, goto loop1
    
varlabel:
    lda #$00 // go into 38 column mode and set scroll bits
    and #$07 // varlabel+1 will be changed with self modifying code
    sta VIC_CONTROL_REG_2

loop2:
    lda #$ff // wait for raster line $ff
    cmp VIC_RASTER_COUNTER
    bne loop2

    lda #$c8 // reset the borders to 40 column mode
    sta VIC_CONTROL_REG_2

    dec varlabel+1
    lda varlabel+1
    and #$07
    cmp #$07
    bne skipmove

    // Move scroller characters
    ldx #$00
mvlp1:
    lda SCREEN_BOTTOM_LEFT+1,x
    sta SCREEN_BOTTOM_LEFT,x
    inx
    cpx #39
    bne mvlp1

mvlp2: // put character from scroller message onto bottom right
    ldx #$00
    lda hello_message,x
    sta SCREEN_BOTTOM_RIGHT
    inx
    lda hello_message,x
    cmp #$ff
    bne mvover1
    ldx #$00
mvover1:
    stx mvlp2+1

skipmove:
    // color cycling

    inc vars
    lda vars
    cmp #$05
    beq more_color
    jmp animate_sprites

more_color:
    lda #$00  // reset color timer
    sta vars

    // move colors
    ldx #39
cycle_colors:
    lda COLORS_BOTTOM_LEFT-1,x
    sta COLORS_BOTTOM_LEFT,x
    dex
    cpx #$ff
    bne cycle_colors

    inc vars+1
    ldx vars+1
    lda color_table,x
    cmp #$ff
    beq reset_colors
    sta COLORS_BOTTOM_LEFT
    jmp loop256

reset_colors:
    lda #$ff
    sta vars+1

animate_sprites:

animate_yin_yang:
    // animate yin_yang
    inc vars+2
    lda vars+2
    cmp #$03
    beq more_yin_yang
    jmp animate_sprites_2
more_yin_yang:
    lda #$00  // reset timer
    sta vars+2
    clc
    inc sprite_anim_index_table
    ldx sprite_anim_index_table
    lda yin_yang_anim,x
    bne yy1
    ldx #$00
yy1:
    stx sprite_anim_index_table    
    lda yin_yang_anim,x
    sta SPRITE_0_POINTER
    sta SPRITE_1_POINTER
    
animate_sprites_2:

animate_eagle:
    // animate eagle
    inc vars+3
    lda vars+3
    cmp #$25
    beq more_eagle
    jmp animate_sprites_3
more_eagle:
    lda #$00  // reset timer
    sta vars+3
    clc
    inc sprite_anim_index_table+2
    ldx sprite_anim_index_table+2
    lda eagle_anim,x
    bne eag1
    ldx #$00
eag1:
    stx sprite_anim_index_table+2
    lda eagle_anim,x
    sta SPRITE_2_POINTER

animate_sprites_3:

animate_nauga:
    // animate nauga
    inc vars+4
    lda vars+4
    cmp #$45
    beq more_nauga
    jmp animate_sprites_4
more_nauga:
    lda #$00  // reset timer
    sta vars+4
    clc
    inc sprite_anim_index_table+3
    ldx sprite_anim_index_table+3
    lda eagle_anim,x
    bne naug1
    ldx #$00
naug1:
    stx sprite_anim_index_table+3
    lda nauga_anim,x
    sta SPRITE_3_POINTER

animate_sprites_4:

animate_clicky:
    // animate clicky
    inc vars+5
    lda vars+5
    cmp #$02
    beq more_clicky
    jmp animate_sprites_5
more_clicky:
    lda #$00  // reset timer
    sta vars+5
    clc
    inc sprite_anim_index_table+4
    ldx sprite_anim_index_table+4
    lda clicky_anim,x
    bne click1
    ldx #$00
click1:
    stx sprite_anim_index_table+4
    lda clicky_anim,x
    sta SPRITE_6_POINTER

animate_sprites_5:

animate_helm:
    // animate helm
    inc vars+6
    lda vars+6
    cmp #$12
    beq more_helm
    jmp animate_sprites_6
more_helm:
    lda #$00  // reset timer
    sta vars+6
    clc
    inc sprite_anim_index_table+5
    ldx sprite_anim_index_table+5
    lda helm_anim,x
    bne helm1
    ldx #$00
helm1:
    stx sprite_anim_index_table+5
    lda helm_anim,x
    sta SPRITE_4_POINTER

animate_sprites_6:

binary_counter:
 // update binary counter
    inc vars+7
    lda vars+7
    cmp #$25
    
    beq more_binary_counter
    jmp exit_binary_counter
more_binary_counter:
    lda #$00  // reset timer
    sta vars+7
    lda vars+9 // msb (ie 256)
    beq more_binary_counter_2
    DrawBinaryChar(binary_1_char,12,22)
    jmp exit_binary_counter
more_binary_counter_2:
    lda vars+8
    cmp #$ff
    bne mbc22
    inc vars+9
    DrawBinaryChar(binary_1_char,12,22)
mbc22:
    inc vars+8 // count
    lda vars+8
    clc
    ror
    bcc db1_1
    DrawBinaryChar(binary_1_char,28,22)
    jmp db1_2
db1_1:
    DrawBinaryChar(binary_0_char,28,22)
db1_2:

    lda vars+8
    clc
    .for(var i=0;i<2;i++) ror
    bcc db2_1
    DrawBinaryChar(binary_1_char,26,22)
    jmp db2_2
db2_1:
    DrawBinaryChar(binary_0_char,26,22)
db2_2:

    lda vars+8
    clc
    .for(var i=0;i<3;i++) ror
    bcc db3_1
    DrawBinaryChar(binary_1_char,24,22)
    jmp db3_2
db3_1:
    DrawBinaryChar(binary_0_char,24,22)
db3_2:

    lda vars+8
    clc
    .for(var i=0;i<4;i++) ror
    bcc db4_1
    DrawBinaryChar(binary_1_char,22,22)
    jmp db4_2
db4_1:
    DrawBinaryChar(binary_0_char,22,22)
db4_2:

    lda vars+8
    clc
    .for(var i=0;i<5;i++) ror
    bcc db5_1
    DrawBinaryChar(binary_1_char,20,22)
    jmp db5_2
db5_1:
    DrawBinaryChar(binary_0_char,20,22)
db5_2:
 
    lda vars+8
    clc
    .for(var i=0;i<6;i++) ror
    bcc db6_1
    DrawBinaryChar(binary_1_char,18,22)
    jmp db6_2
db6_1:
    DrawBinaryChar(binary_0_char,18,22)
db6_2:

    lda vars+8
    clc
    .for(var i=0;i<7;i++) ror
    bcc db7_1
    DrawBinaryChar(binary_1_char,16,22)
    jmp db7_2
db7_1:
    DrawBinaryChar(binary_0_char,16,22)
db7_2:

    lda vars+8
    clc
    .for(var i=0;i<8;i++) ror
    bcc db8_1
    DrawBinaryChar(binary_1_char,14,22)
    jmp db8_2
db8_1:
    DrawBinaryChar(binary_0_char,14,22)
db8_2:

exit_binary_counter:
    jmp loop256

.macro DrawBinaryChar(which,column,row) {
    ldx #$00
    lda which,x
    sta 1024+column+row*40
    inx
    lda which,x
    sta 1024+column+row*40+1
    inx
    lda which,x
    sta 1024+column+row*40+40
    inx
    lda which,x
    sta 1024+column+row*40+40+1
}

hello_message:
.encoding "screencode_upper"
.text "  256 YOUTUBE SUBSCRIBERS! THANK YOU FOR TAKING THIS JOURNEY WITH US. ZENZIZENZIZENZIC DEMO TO SHOW "
.text "OUR APPRECIATION AND WE'VE PUT THIS CODE ON OUR GITHUB SO YOU CAN DOWNLOAD IT AND HOPEFULLY LEARN SOMETHING. "
.text "MUSIC BY SPIDER JERUSALEM       "
.byte $ff

color_table:
.byte DARK_GRAY, GRAY, LIGHT_GRAY, WHITE, LIGHT_GRAY, GRAY, DARK_GRAY
.byte $ff

sprite_color_table:
.byte WHITE,WHITE,WHITE,YELLOW,DARK_GRAY,WHITE,GREEN,BLACK

sprite_multicolor_table:
.byte 0,0,0
.byte 0,0,0
.byte 1,9,0
.byte 1,9,0
.byte 1,12,0
.byte 1,6,0
.byte 0,0,0
.byte 0,0,0

sprite_loc_table:
.byte $00,$13,$e0 // yinyang left
.byte $02,$43,$e0 // yinyang right
.byte $00,$1c,$ac // eagle
.byte $00,$90,$32 // nauga
.byte $10,$1a,$a0 // helm
.byte $00,$b7,$b8 // youtube triangle
.byte $40,$30,$42 // clicky
.byte $00,$b9,$ba // youtube triangle shadow
.byte $ff

sprite_anim_index_table:
.byte 0,0,0,0,0,0,0,0

nauga_anim: 
.byte $8a,$8b,$00

yin_yang_anim:
.byte $8c,$8d,$8e,$8f,$90,$91,$92,$93,$00

helm_anim:
.byte $94,$95,$00

eagle_anim:
.byte $96,$97,$00

clicky_anim:
.byte $99,$9a,$9b,$9c,$00

binary_0_char:
.byte 85,73
.byte 74,75

binary_1_char:
.byte 77,78
.byte 109,110

tmps:
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0

vars:
.byte 0 // color timer
.byte 0 // color cycle index
.byte 0 // yinyang sprite anim timer
.byte 0 // eagle sprite anim timer
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0   // sinetable yinyang sprite 1 offset
.byte 128 // sinetable yinyang sprite 2 offset
.byte 0   // color cycle on words timer
.byte 0   // scroll speed

irq1:
    asl $d019
    jsr music.play
    pla
    tay
    pla
    tax
    pla
    rti

sinetable:
.byte $11,$11,$11,$12,$12,$12,$13,$13,$14,$14,$14,$15,$15,$16,$16,$16
.byte $17,$17,$17,$18,$18,$18,$19,$19,$19,$1a,$1a,$1a,$1b,$1b,$1b,$1c
.byte $1c,$1c,$1c,$1d,$1d,$1d,$1d,$1e,$1e,$1e,$1e,$1e,$1f,$1f,$1f,$1f
.byte $1f,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$1f
.byte $1f,$1f,$1f,$1f,$1f,$1e,$1e,$1e,$1e,$1e,$1d,$1d,$1d,$1d,$1c,$1c
.byte $1c,$1b,$1b,$1b,$1b,$1a,$1a,$1a,$19,$19,$19,$18,$18,$18,$17,$17
.byte $16,$16,$16,$15,$15,$15,$14,$14,$13,$13,$13,$12,$12,$11,$11,$11
.byte $10,$10,$10,$0f,$0f,$0e,$0e,$0e,$0d,$0d,$0c,$0c,$0c,$0b,$0b,$0b
.byte $0a,$0a,$09,$09,$09,$08,$08,$08,$07,$07,$07,$06,$06,$06,$06,$05
.byte $05,$05,$04,$04,$04,$04,$03,$03,$03,$03,$03,$02,$02,$02,$02,$02
.byte $02,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02
.byte $02,$02,$02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04,$05,$05,$05
.byte $05,$06,$06,$06,$07,$07,$07,$08,$08,$08,$09,$09,$09,$0a,$0a,$0a
.byte $0b,$0b,$0b,$0c,$0c,$0d,$0d,$0d,$0e,$0e,$0f,$0f,$0f,$10,$10,$10
