// #########################################################################################
// Projeto:
// Modulo :
// Fonte  : CADSA1
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 14/03/15 | NILSON A. SERRA   | FUN��ES RELACIONADAS AO NOVO MENU TI.XNU CRIADO 
// ---------+-------------------+-----------------------------------------------------------
// |||||||| |                   | ...PARA PONTO DE ENTRADA ESPNOME EM SIGA_ENV
// ---------+-------------------+-----------------------------------------------------------
//

#include "rwmake.ch"

user function CADSA1()

	local cAlias := "SA1"
	local cVldAlt := ".T." // Operacao: ALTERACAO
	local cVldExc := ".T." // Operacao: EXCLUSAO
 	private cCadastro := "Cadastro de Clientes" // Titulo
	
	chkFile(cAlias)

	//  MONTA 'arotina' proprio (ROTINA PADR�O DO SISTEMA QUE N�O PODE TER O NOME ALTERADO) 
	
	aRotina := {;
		{ "Pesquisar"		, "AxPesqui"	, 0, 1},;
		{ "Visualizar"	, "AxVisual"	, 0, 2},;
		{ "INC PROTHEUS"	, "U_xINCSA1"	, 0, 3},;
		{ "Alterar"		, "AxAltera"	, 0, 4},;
		{ "Exlcuir"		, "U_xDELSA1"	, 0, 5},;
		{ "Parametro"		, "U_xTela"	, 0, 6},;
		{ "Incluir"		, "U_fTelaCli", 0, 7};
	}
	
	// O aROTINA / mBrowse  cria automaticamente os parametros  cTABELA=nome da tabela utilziada, 
	// NRECNO=numero do registro selecionado, NBOTAO=Numero do boltao clica\do na montagem do aRotina
	
	
	dbSelectArea(cAlias) // Abre a area da tabela
	
	(cAlias)->( dbSetOrder(1) ) /// INdices

	mBrowse( 6, 1, 22, 75, cAlias)
	
return ( NIL )

// --------------------------------------------------------------------------------

User Function xINCSA1(cTABELA, NRECNO, NBOTAO)


	//MsgInfo( cTABELA + "   " + cValToChar(NRECNO) + "   " cValToChar(NBOTAO) )

	// Vamos trabalhar com a funcao "AxIncluir()" do framework
	
	If MsgYESNO("Gostaria de Incluir um novo registro")
	
		//AxInclui( <cAlias>, <nReg>, <nOpc>, <aAcho>, <cFunc>, <aCpos>, <cTudoOk>, <lF3>, <cTransact>, <aButtons>, <aParam>, <aAuto>, <lVirtual>, <lMaximized>)
		AxInclui( cTABELA, nRECNO, NBOTAO )
		
	EndIf
	
Return( NIL )


User Function xDELSA1(cTABELA, NRECNO, NBOTAO)

	//chkFile("SE1")
	dbSelectArea("SE1") // Abre a area da tabela
	SE1->(dbSetOrder(2))
	
	// SE1          ( E1_FILIAL     + E1_CLIENTE  + E1_LOJA) )
	If SE1->( dbSeek(xFilial("SE1") + SA1->A1_COD + SA1->A1_LOJA) )
		
		MsgInfo("Existem Registros vinculados ao cliente" + SA1->A1_NREDUZ )
	Else
		If MsgYESNO("Deseja visualizar os dados do cliente" + SA1->A1_NREDUZ)
			If ( (AxDeleta(cTABELA, NRECNO, NBOTAO)) == 2 )
				MsgInfo("Cliente Excluido")
			EndIf
		Else
			RecLock("SA1",.F.) //Incluir
			SA1->(dbDelete())
			SA1->( MsUnlock() )
		EndIf
	EndIf

Return( NIL )

	
	