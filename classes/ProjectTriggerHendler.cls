public with sharing class ProjectTriggerHandler extends TriggerHandler {

    public void setProjectName(){
        List<Project__c> projects= Trigger.New;

        Set<Id> accountIds = new Set<Id>();
        Set<Id> userIds = new Set<Id>();

        for(Project__c project: projects){
            accountIds.add(project.Account__c);
            userIds.add(project.User__c);
        }

        Map<Id, Account> accountByIds = new Map<Id, Account>([SELECT Id, Name
																		FROM Account
                                                                        WHERE Id IN: accountIds]);
                                                                        
        Map<Id, User> userByIds = new Map<Id, User>([SELECT Id, Name
																		FROM User
                                                                        WHERE Id IN: userIds]);                                                               
                                                                        
        

        
  
        for(Project__c project : projects){
            project.name = accountByIds.get(project.Account__c).name +' - '+ 
                                                userByIds.get(project.User__c).name;
            if(project.name.length()>40)
                    project.name = (project.name.abbreviate(37)  + "...");

        }
    }

   
   
    public override void beforeInsert(){
       setProjectName();
    }
        
   


    public override void beforeUpdate(){
        setProjectName();

    }



    }