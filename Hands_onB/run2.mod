;; 1. Based on: run1
;; 2. Description: +peripheral compartment

;; x1. Author: user
;; 3. Label:

$PROBLEM PK

$INPUT ID TIME DV AMT CMT MDV EVID WT CRCL AGE SEX CENT

$DATA pktab1 IGNORE=@;

$SUBROUTINES ADVAN3 TRANS4

$PK
TVCL = THETA(1)
CL = TVCL * EXP(ETA(1))
TVV1 = THETA(2)
V1 = TVV1 * EXP(ETA(2))
Q  = THETA(3)
V2 = THETA(4)
S1 = V1/1000

$ERROR
IPRED = F
Y = IPRED + EPS(1)
ADD = SIGMA(1,1)
W = SQRT(ADD)
IRES = DV-IPRED
IWRES = IRES/W

$THETA
(0,  10) ; CL
(0, 100) ; V
(0, 10, 100); Q
(0, 100, 500); V2

$OMEGA BLOCK(2)
0.2 ; IIV CL
0.1 0.2 ; IIV V2

$SIGMA
1  ; Additive error PK

$EST METHOD=1 INTER MAXEVAL=2000 NOABORT SIG=3 PRINT=1 POSTHOC
; Xpose
$TABLE ID TIME DV MDV EVID IPRED IWRES CWRES ONEHEADER NOPRINT FILE=sdtab2
$TABLE CL V1 ONEHEADER NOPRINT FILE=patab2

