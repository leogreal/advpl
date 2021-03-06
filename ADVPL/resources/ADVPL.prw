#include 'protheus.ch'
#include 'parmtype.ch'


User Function xArray1()

	Local aVar := {}
	Local bBloco := { | X,Y | (X + 10) * Y }
	Local nPOs := 0
	
	MsgInfo( eVal(bBloco,1,10) )
	
	aVar :={{"Maria", 50, "F" },;
			{"Adriana",20,"F" },;
			{"Jose",32,"M"    },;
			{"Andre",19,"M"   },;
			{"Marcio",40,"M"  }}
			
	//aVar := aSort(aVar,,, { | D, F | D(1) < F(1).AND. D(2) < F(2) } )
	
	nPOs := aScan(aVar, {| x | x[1] == "Jose"} )

	MsgInfo("Idade: " + aVar[nPos,2] )
	
	For x := 1 to Len(aVar)
		MsgInfo("Nome: " + aVar[x,1] + Chr(13) + ;
				"Idade: " + aVar[x,2] + Chr(13) + ;
				"Sexo: " + IIf( aVar[x,3] == "M", "Masculino", "Feminino") );
				
	Next x
	
	
Return ( NIL )


// **************************************************************************

User Function xArray()

	Local aVar 	:={}
	Local aVar2 	:= Array(6)
	Local x		:= 0

	aVar2[1]	:= "Domingo"
	aVar2[2]	:= "Segunda-Feira"
	aVar2[3]	:= "Ter�a-Feira"
	aVar2[4]	:= "Quarta-Feira"
	aVar2[5]	:= "Quinta-Feira"
	aVar2[6]	:= "Sexta-Feira"
	Aadd(aVar2,"S�bado") // Append proximo elemento de uma array
	
	For x := 1 To Len(aVar2)
		MsgInfo(aVar2[x])
	Next x
	

MSgInfo("oops!")



Return( NIL )


// **************************************************************************



User Function xCondicao()

	Local dMes := Month( Date() )
	
/*	
	if dMes <= 3
		MsgInfo("1� Trimestre", "IF")
		ElseIf dMes <= 6
			MsgInfo("2� Trimestre", "IF")
		ElseIf dMes <= 9
			MsgInfo("3� Trimestre", "IF")
		Else 
			MsgInfo("4� Trimestre", "IF")
	EndIf
*/


/*
	if dMes <= 3
		MsgInfo("1� Trimestre", "IF")
	ElseIf dMes <= 6 .AND. dMes >= 3
		MsgInfo("2� Trimestre", "IF")
	ElseIf dMes <= 9 .AND. dMes >=6
		MsgInfo("3� Trimestre", "IF")
	Else 
		MsgInfo("4� Trimestre", "IF")
	EndIf
*/

Do Case

	Case dMes <= 3
		MsgInfo("1� Trimestre", "Case")
	Case dMes <= 6
		MsgInfo("2� Trimestre", "Case")
	Case dMes <= 9
		MsgInfo("3� Trimestre", "Case")
	OTHERWISE
		MsgInfo("4� Trimestre", "Case")

EndCase




Return( NIL )


// **************************************************************************


User Function xRepeteDB()
	
	Local nContador := 0
	Local lWhile := .T.

/*

// Para incluir registros na tabela de clientes do modulo de compras

While nContador <= 10

	RecLock("SA1" , .T.) // T - Inclus�o || F - Aletra��o
		// Para add valores aos campos
		SA1->A1_FILIAL	:=	xFilial("SA1")	
		SA1->A1_COD		:= 	GETSXENUM("SA1","A1_COD")
		SA1->A1_LOJA		:= 	"01"
		SA1->A1_NOME		:= 	"NOME DO REGISTRO" + cValToChar(nContador)
		SA1->A1_NREDUZ	:=	"NOME"
		SA1->A1_END		:= "RUA SEI LA O QUE"
		
	MsUnlock() // Destrava o registro
	
	ConfirmSX8() // Confirma o numero do SXE / SXF
	
	nContador++

EndDo


MsgInfo("Registros Incluidos com sucesspo!!!")
	
*/
	
// -------------------------------------------------------------------
	
	dbSelectArea("SA1") // Abre a area da tabela SA1
	dbSelectArea("SB1") // Abre a area da tabela SB1
	
	SA1->( dbSetOrder(1) ) // Ordena o registro por A1_COD + A1_LOJA
	
	SA1->( dbGotop() ) // Vai para o inicio da tabela
	
	While ! SA1->(EOF())
		
		MsgInfo(SA1->A1_COD + " " + SA1->A1_LOJA + " " + SA1->A1_NOME)
		SA1->( dbSkip() )
	
	EndDo

Return ( NIL )
	

// --------------------------------------------------------------------
User Function xRepeticao()
/*
	While lWhile
	
		For x:= 1 To 10 Step 2
			MsgInfo( "Contador : " + cValToChar(x) )
		Next x
		
		If MsgYesNo("Deseja sair do While ?")
			If MsgNoYes("Deseja sair do While ?")
				lWhile := .F. // Pode forcar saida com exit
			EndIf
		EndIf
		
		nCount++
	
	EndDo
*/

// --------------------------------------------------------------------

/*
	While nCount <= 10
		
		MsgInfo( "Valor atual: " + cValToChar(nContador) )
		nCount++
		
	EndDo
*/
	

	
// ----------------------------------------------------------	
	
	For nContador := 1 To 10 Step 1
			
		if( nContador = 5 )
			//Loop // Pula o ciclo atual e inicia o proximo dentro do loop
			Exit // Termina o laco
		EndIf
	
		MsgInfo( "Valor atual: " + cValToChar(nContador) )
	
	Next nContador





Return( NIL )

//********************************************************************

User Function xConverte()

	Local dData := Date() 
	Local nValor := 10 + 30
		
	Set Date To British  // Formato dd/mm/aaaa
	
	MsgInfo( "Soma dos Valores: " + Str(nValor) )
	MsgInfo( "Soma dos Valores: " + cValToChar(nValor) )
	MsgInfo( "Soma dos Valores: " + Transform(nValor,"@E 999.99") )
	MsgInfo( "Hoje �: " + Dtoc(dData) )
	MsgInfo( "HOje �: " + Dtos(dData) )  
	
	MsgInfo( "Soma dos Valores: " + StrZero(nValor,6) ) //String com zeros a esquerda
	MsgInfo( Val("40") + 30 )


Return( NIL )



//********************************************************************

User Function OpString2()

	Local cTexto1 := "123456789ABCDEF"
	Local cTexto2 := "Texto 02"
	Local cDiv		:= "|"
	Local nRet 	:= 0
	Local cVar 	:= "A" 
	
	MsgInfo( Replicate("*",20) ) // Repetindo caracteres
	
	MsgInfo( Left(cTexto1,3) , "Left" ) // Pega 3 char a esquerda
	
	MsgInfo( Right(cTexto1 , 6) , "Right" ) // Pega 6 chars a direita
	
	MsgInfo( SubStr(cTexto1,7,5) , "Substring" ) // Pega 5 chars a partir da Posi��o 7
	
	MsgInfo( Capital("maria fernanda") , "Capitaliza��o" ) // Capitalizar caracteres
	


Return ( NIL )

//********************************************************************

User Function OpString1()

	Local cTexto1 := "Maria Silva                           "
	Local cTexto2 := "Texto 02"
	Local cDiv		:= "|"
	Local nRet 	:= 0
	Local cVar 	:= "A" 
	
	MsgInfo( cTexto1 + cDiv + cTexto2, "Exemplo" )
	
	MsgInfo( Trim(cTexto1) + cDiv + cTexto2 , "TRIM" ) // Remove Espa�os a diretira
	
	MsgInfo( RTrim(cTexto1) + cDiv + cTexto2 , "RTRIM" ) // Remove Espa�os a direita
	
	cTexto2 := Space(10) + cTexto2 // Add espa�os
	
	MsgInfo( cTexto1 + cDiv + cTexto2, "Espa�os" )
	
	MsgInfo( cTexto1 + cDiv + LTrim(ctexto2) , "LTRIM" ) // Remove Espa�os a esquerda
	
	MsgInfo( AllTrim(ctexto1) + cDiv + AllTrim(cTexto2) , "ALLTRIM" ) // Remove de ambos os lados


Return ( NIL )

//********************************************************************

User Function OpString()

	Local cTexto1 := "Marina Silva"
	Local cTexto2 := "Texto 02"
    Local cVar := "r" 
	//MsgInfo(cTexto1 - cTexto2)
	//MsgInfo(cTexto1 + cTexto2)


	If cVar $ cTexto1 // Contido
		//nRet := At("r",cTexto1) // Retorna
		MsgInfo( "Verdadeiro" + Chr(13) + "Posi��o: " + cValToChar(nRet) )
	Else 
		MsgInfo("Falso")
	EndIf


		Return( NIL )

//********************************************************************


	User Function xEscopo()
//
		Static 	cStatic 	:= "Pode ser vista em outras funtions mas n�o pode alterar valores. Utilizada para objetos"
//
		Local 		cLocal 	:= "S� pode ser vista na propria functions"
//
		Private 	cPrivate 	:= "Pode ser vista e editada em outras functions"
// Variaveis que n�o devem ser utilziadas com frequencia e pode ser substituida pela Private que tb funciona como uma Global
		Public   	_cPublica 	:= "Pode ser vista em qualquer parte do projeto"

		xSTEscopo()

		Return( NIL )

//********************************************************************
	Static Function xSTEscopo()

		MsgInfo(cStatic,"Static")
//MsgAlert(cLocal,"Local")
		MsgAlert("cPrivate")
		MsgStop(_cPublica,"Publica")
		Alert("ajdskljdkljsd")

		Return( NIL )

	User function ADVPL()
// Comentario de Linha 

/* 
 * Comentario
 * de 
 * Bloco
 */

		nValor  := 0 // Numerico
		cVar    := "" // ' ' // Caracter
		lVar    := .T. // Logico
		dVar    := Data()  // Data
		bVar    := { || }  // Bloco
		aVar    := {}     // Array Vetor
		oVar    := Nil    // objeto
      
		Return( NIL )


//----------------------------------------------------


	User Function xVar()

		Local xVar

		xVar := "Agora a variavel � caracter..."

		MsgInfo(xVar)

		xVar := 22 + 10  // Agora � numerico

		MsgInfo(xVar)

		xVar := .T. // Agora � Logico
 
		If xVar    // N�o � necessario colocar operador ex : If xVar == .T.
			MsgInfo("Verdadeiro")
		Else
			MsgInfo("Falso")
		EndIf

		xVar := Date() + 2 // Agora � Data

		MsgInfo("Hoje � :" + Dtoc(xVar))

		xVar := Nil

		MsgInfo("Valor nulo" + CValTochar(xVar) + "..." )

		Return( NIL )
//----------------------------------------------------


