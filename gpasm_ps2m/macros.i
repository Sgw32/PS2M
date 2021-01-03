mov	macro
	if	streq("\1","w")|streq("\1","W")
	movwf	\2
	else
	if	(chrval("\1",1)==0x27)|((chrval("\1",0)>0x2F)&(chrval("\1",0)<0x3A))
	movlw	\1
	else
	movf	\1,w
	endif
	if	~(streq("\2","w")|streq("\2","W"))
	movwf	\2
	endif
	endif
	endm

gid	macro
	bcf	INTCON,7
	endm

gie	macro
	bsf	INTCON,7
	endm

bsf1	macro
	data1
	bsf	\1,\2
	data0
	endm

bcf1	macro
	data1
	bcf	\1,\2
	data0
	endm

skipc	macro	; skip if carry
	btfss	STATUS,C
	endm

skipnc	macro	; skip if not carry
	btfsc	STATUS,C
	endm

skipz	macro	; skip if zero
	btfss	STATUS,Z
	endm

skipnz	macro	; skip if not zero
	btfsc	STATUS,Z
	endm

skpos	macro	; skip if reg >= 0 (reg)
	btfsc	\1,7
	endm

skneg	macro	; skip if reg < 0 (reg)
	btfss	\1,7
	endm

setc	macro	; set carry
	bsf	STATUS,C
	endm

clrc	macro	; clear carry
	bcf	STATUS,C
	endm

bc	macro	;branch if carry
	skipnc
	goto	\1
	endm

bnc	macro	;branch if no carry
	skipc
	goto	\1
	endm

bz	macro	;branch if zero
	skipnz
	goto	\1
	endm

bnz	macro	;branch if not zero
	skipz
	goto	\1
	endm

bwz	macro	;branch if w = 0
	addlw	0
	skipnz
	goto	\1
	endm

bwnz	macro	;branch if w <> 0
	addlw	0
	skipz
	goto	\1
	endm

retz	macro
	skipnz
	return
	endm

retnz	macro
	skipz
	return
	endm

retwz	macro
	addlw	0
	skipnz
	return
	endm

retwnz	macro
	addlw	0
	skipz
	return
	endm

bpos	macro	;branch if reg >= 0 (reg,dest_addr)
	btfss	\1,7
	goto	\2
	endm

bneg	macro	;branch if reg < 0 (reg,dest_addr)
	btfsc	\1,7
	goto	\2
	endm

brset	macro	;branch if bit set (reg,bit,dest_addr)
	btfsc	\1,\2
	goto	\3
	endm

brclr	macro	;branch if bit clear (reg,bit,dest_addr)
	btfss	\1,\2
	goto	\3
	endm

data0	macro
	bcf	STATUS,RP0
	endm

data1	macro
	bsf	STATUS,RP0
	endm

code0	macro
	bcf	PCLATH,3
	endm

code1	macro
	bsf	PCLATH,3
	endm

loop	macro
	decfsz	\2
	goto	\1
	endm

movlf	macro
	movlw	\1
	movwf	\2
	endm

movff	macro
	movf	\1,w
	movwf	\2
	endm

movfw	macro
	movf	\1,w
	endm

iorfw	macro
	iorwf	\1,w
	endm

xorfw	macro
	xorwf	\1,w
	endm

addfw	macro
	addwf	\1,w
	endm

comfw	macro
	comf	\1,w
	endm

swapfw	macro
	swapf	\1,w
	endm

rrfw	macro
	rrf	\1,w
	endm

rlfw	macro
	rlf	\1,w
	endm

andlf	macro
	movlw	\1
	andwf	\2
	endm

addlf	macro
	movlw	\1
	addwf	\2
	endm

sublf	macro
	movlw	\1
	subwf	\2
	endm

cmplf	macro
	movlw	\1
	subwf	\2,w
	endm

cmpff	macro
	movf	\1,w
	subwf	\2,w
	endm

addff	macro
	movf	\1,w
	addwf	\2
	endm

subff	macro
	movf	\1,w
	subwf	\2
	endm

callw	macro
	movlw	\2
	call	\1
	endm

callf	macro
	movf	\2,w
	call	\1
	endm

call0	macro
	bcf	PCLATH,3
	call	\1
	bsf	PCLATH,3
	endm

call1	macro
	bsf	PCLATH,3
	call	\1
	bcf	PCLATH,3
	endm

call1w	macro
	bsf	PCLATH,3
	movlw	\2
	call	\1
	bcf	PCLATH,3
	endm

call1f	macro
	bsf	PCLATH,3
	movf	\2,w
	call	\1
	bcf	PCLATH,3
	endm

goto0	macro
	bcf	PCLATH,3
	goto	\1
	endm

goto1	macro
	bsf	PCLATH,3
	goto	\1
	endm

tstf	macro
	movf	\1
	endm

tstw	macro
	addlw	0
	endm

clrd	macro
	clrf	\10
	clrf	\11
	endm

tstd	macro
	movf	\10
	skipnz
	movf	\11
	endm

incd	macro
	incf	\10
	skipnz
	incf	\11
	endm

movld	macro
	if	\1&255
	movlw	\1&255
	movwf	\20
	else
	clrf	\20
	endif
	if	(\1>>8)&255
	if	((\1>>8)&255)-(\1&255)
	movlw	(\1>>8)&255
	endif
	movwf	\21
	else
	clrf	\21
	endif
	endm

movcd	macro
	movld	(\1+256),\2
	endm

movwd	macro
	movwf	\10
	clrf	\11
	endm

loopd	macro
	loop	\1,\20
	loop	\1,\21
	endm

movdd	macro
	movf	\10,w
	movwf	\20
	movf	\11,w
	movwf	\21
	endm

movtt	macro
	movf	\10,w
	movwf	\20
	movf	\11,w
	movwf	\21
	movf	\12,w
	movwf	\22
	endm

adddd	macro
	movf	\10,w
	addwf	\20
	movf	\11,w
	btfsc	STATUS,C
	incfsz	\11,w
	addwf	\21
	endm

addfd	macro
	movf	\1,w
	addwf	\20
	skipnc
	incf	\21
	endm

addwd	macro
	addwf	\10
	skipnc
	incf	\11
	endm

addld	macro
	if	\1-1
	movlw	\1&255
	addwf	\20
	skipnc
	incf	\21
	if	(\1>>8)&255
	if	(((\1>>8)&255)-1)
	movlw	(\1>>8)&255
	addwf	\21
	else
	incf	\21
	endif
	endif
	else
	incf	\20
	skipnz
	incf	\21
	endif
	endm

subdd	macro
	movf	\10,w
	subwf	\20
	movf	\11,w
	btfss	STATUS,C
	incfsz	\11,w
	subwf	\21
	endm

subfd	macro
	movf	\1,w
	subwf	\20
	skipc
	decf	\21
	endm

subwd	macro
	subwf	\10
	skipc
	decf	\11
	endm

subld	macro
	movlw	\1&255
	subwf	\20
	skipc
	decf	\21
	if	(\1>>8)&255
	if	(((\1>>8)&255)-1)
	movlw	(\1>>8)&255
	subwf	\21
	else
	decf	\21
	endif
	endif
	endm

rld	macro
	rlf	\10
	rlf	\11
	endm

ald	macro
	clrc
	rlf	\10
	rlf	\11
	endm

rrd	macro
	rrf	\11
	rrf	\10
	endm

ard	macro
	clrc
	rrf	\11
	rrf	\10
	endm

