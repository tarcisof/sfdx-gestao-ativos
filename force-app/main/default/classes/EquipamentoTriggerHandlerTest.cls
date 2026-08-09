@isTest
public class EquipamentoTriggerHandlerTest {
    
    @isTest
    static void testCriacaoChamadoEquipamentoComDefeito() {
        // Criamos um equipamento falso na memória de teste
        Equipamento__c equipMock = new Equipamento__c(
            Modelo__c = 'Nitro 5',
            Status__c = 'Operacional'
        );
        insert equipMock; 
        
        // Mudamos o status para disparar a sua Trigger
        Test.startTest(); 
        
        equipMock.Status__c = 'Com Defeito';
        update equipMock; 
        
        Test.stopTest(); 
        
        // Vamos ao banco verificar se o código fez o trabalho dele
        List<Case> chamadosCriados = [
            SELECT Id, Status, Priority, Equipamento__c 
            FROM Case 
            WHERE Equipamento__c = :equipMock.Id
        ];
         
        // Se a trigger falhar, o teste quebra e o Salesforce não deixa subir o código.
        System.assertEquals(1, chamadosCriados.size(), 'A automação deveria ter criado exatamente 1 chamado.');
        System.assertEquals('High', chamadosCriados[0].Priority, 'A prioridade do chamado deveria ser Alta.');
    }
    
}