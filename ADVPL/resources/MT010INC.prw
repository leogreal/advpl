#Include 'Protheus.ch'

User Function MT010INC()

	// Atrav�s do Get Area
	Local aAreaSB1 := SB1->( GetArea() )
	
	MsgInfo("PONTO DE ENTRADA MT010INC")
	
	MsgInfo(SB1->B1_COD + chr(13) + SB1->B1_DESC)
	
	dbSelectArea("SB5")
	SB5->(dbSetOrder( 1 )) // B5_FILIAL + B5_COD
	
	If SB5->( MsSeek(xFilial("SB5") + SB1->B1_COD ) )
		MsgInfo("Nada feito, ja tem essa baga�a cadastrada!")
		RecLock("S-B5",.F.) //Incluir
	Else
		RecLock("SB5",.T.) //Incluir
	EndIf
		
	sb5->B5_FILIAL	:= xFilial("SB5")
	SB5->B5_COD		:= SB1->B1_COD
	SB5->B5_CEME		:= "SEM NOME CIENTIFICO CADASTRADO"
	
	SB5->( MsUnlock() )
	
	mail := U_xEmailProduto( SB1->B1_COD, SB1->B1_DESC )
	
	RestArea(aAreaSB1)


Return()

