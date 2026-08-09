# 💻 Salesforce Asset Management & Support Automation

Este projeto é uma solução construída nativamente na plataforma Salesforce (Apex) para gerenciar o ciclo de vida de ativos de hardware e automatizar o fluxo de abertura de chamados de suporte técnico. 

A arquitetura foi desenhada utilizando o **Trigger Handler Pattern**, garantindo separação de responsabilidades, código limpo e escalabilidade.

## ⚙️ Arquitetura e Padrões Aplicados

*   **Trigger Handler Pattern:** O gatilho (`Trigger`) atua apenas como um roteador de execução, delegando a regra de negócio para a classe `EquipamentoTriggerHandler`. Isso mantém a Trigger limpa ("logic-less") e facilita a manutenção.
*   **Bulkification (Processamento em Lote):** O código foi construído para suportar a manipulação de milhares de registros simultaneamente, alocando instâncias em memória e executando chamadas DML (`insert`) apenas uma vez ao final da transação, respeitando os *Governor Limits* do Salesforce.
*   **Test-Driven:** Cobertura de código comprovada com a classe de teste unitário `@isTest`, validando a inserção correta dos dados com `System.assertEquals` e simulando ambientes com `Test.startTest()` e `Test.stopTest()`.

## 🚀 Funcionalidade Principal

**Automação de Chamados (Cases):** 
Sempre que um equipamento físico (Custom Object: `Equipamento__c`) sofre uma alteração de status para `"Com Defeito"`, o sistema detecta a transição e gera automaticamente um Ticket de Suporte (`Case`) com prioridade `High`. 

O sistema também cria um **Relacionamento de Pesquisa (Lookup)**, vinculando o ID do Case gerado diretamente à máquina física defeituosa, garantindo a rastreabilidade no banco de dados.

## 🛠️ Tecnologias Utilizadas
*   **Salesforce Apex** (Backend)
*   **SOQL** (Consultas no Banco de Dados)
*   **Salesforce CLI / SFDX**
*   **Modelagem Relacional (Custom Objects & Lookup Relationships)**
