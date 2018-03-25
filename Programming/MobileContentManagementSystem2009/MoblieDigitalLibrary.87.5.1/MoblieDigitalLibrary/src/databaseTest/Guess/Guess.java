package databaseTest.Guess;

import javax.microedition.lcdui.*;
import javax.microedition.midlet.*;

import org.garret.perst.*;


public class Guess extends MIDlet      //in midlet yek Kelase dakheili Dialog darad
{ 
    static Command QUIT_CMD = new Command("Quit", Command.BACK, 1); // commande daster chap: Command.BACK
    static Command DONE_CMD = new Command("Done", Command.SCREEN, 1);
    static Command YES_CMD = new Command("Yes", Command.SCREEN, 1);          // commande daste rast: Command.SCREEN
    static Command NO_CMD = new Command("No", Command.BACK, 1);
             
    public Guess() { 
              createStorage();
    }

    protected void destroyApp(boolean unconditional) {
        closeDB();
    }
    protected void createStorage(){
         storage = StorageFactory.getInstance().createStorage();
    }
    protected void closeDB(){
          storage.close();
    }

    protected  void pauseApp() {
    }

    class Dialogue implements Answer { 
        TreeNode        node;
        NewNodeCallback action;

        Dialogue(TreeNode node, NewNodeCallback action) {    //har Dialog be onvane voroodi yek node migirad va yek action ke null mitavanad bashad
            this.node = node;
            this.action = action;
        }

        static final int TIMEOUT = 3*1000;

        public void answer(boolean yes) {   
            if (yes) { // dar soorati ke pasokh sahih bood
                if (node.yes == null) {  // dar soorati ke pasokh nadasht
                    Alert alert = new Alert("Ah!", 
                                            "It was very simple question for me...", 
                                            null, AlertType.INFO);                       
                    alert.setTimeout(TIMEOUT);
                    Display.getDisplay(Guess.this).setCurrent(alert, areYouReady);
                } else {   //dar soorati ke pasokh dasht
                    new AskQuestionForm(Guess.this, "May be " + node.yes.question, 
                                        new Dialogue(node.yes, 
                                                     new NewNodeCallback() { 
                                                         public void callback(TreeNode newNode) { 
                                                             node.yes = newNode;
                                                             node.modify();
                                                         }
                                                     } 
                                            )
                        );
                }
            } else {  //dar hali ke samte rast khali whatIsItForm miayad
                if (node.no == null) { 
                    if (node.yes == null) { 
                        new WhatIsItForm(Guess.this, node, 
                                         new NewNodeCallback() { 
                                             public void callback(TreeNode newNode) { 
                                                 if (action != null) { 
                                                     action.callback(newNode); 
                                                 }
                                             }
                                         }
                            );                         
                    } else { 
                        new WhatIsItForm(Guess.this, null, 
                                         new NewNodeCallback() { 
                                             public void callback(TreeNode newNode) { 
                                                 node.no = newNode;
                                                 node.modify();
                                             }
                                         }
                            );            
                    }                      // inja inghadr miravim ke be chap beresim
                } else {                // ezafe kardan samte chap ra dar NewnodeCallback darim
                    new AskQuestionForm(Guess.this, "May be " + node.no.question, 
                                        new Dialogue(node.no, 
                                                     new NewNodeCallback() { 
                                                         public void callback(TreeNode newNode) { 
                                                             node.no = newNode;
                                                             node.modify(); //node.modify khodash sare vaght derakht ra update mikonad
                                                         }
                                                     } 
                                            )
                        );
                }
            }
        }
    }

    protected void openDB(){
         try {
            storage.open("guess.dbs");
        } catch (StorageError x) {
            Alert alert = new Alert("Error",
                                    "Failed to open database",
                                    null, AlertType.ERROR);
            alert.setTimeout(Alert.FOREVER);
            Display.getDisplay(this).setCurrent(alert);
            return;
        }
        root = (TreeNode)storage.getRoot();   // be in tartib ma aslan root ra ham Tree node gereftim va cast minamayeem
    }
                    
    protected void startApp() 
    {
        openDB();
        areYouReady 
                = new AskQuestionForm(this, 
                                      "Are you ready", 
                                      new Answer() { 
                                          public void answer(boolean yes) { 
                                              if (yes) { 
                                                  if (root != null) { 
                                                      new AskQuestionForm(Guess.this, "May be " + root.question, 
                                                                          new Dialogue(root, null));
                                                  } else { // in ghesmat faghat vaghti ejra mishavad ke root nadashte bashim , set root mishavat
                                                      //baghi ezafe kardan ha aslan root ra tagheer nemidahad
                                                      new WhatIsItForm(Guess.this, null,
                                                                       new NewNodeCallback() { 
                                                                           public void callback(TreeNode newNode) { 
                                                                               root = newNode;
                                                                               storage.setRoot(newNode);
                                                                           }
                                                                       }
                                                          );
                                                  }                                                  
                                              } else { 
                                                  quit();
                                              }
                                          }
                                      }
                    );
    }

    void quit() { 
        destroyApp(true);
        notifyDestroyed();
    }

    Storage         storage;
    AskQuestionForm areYouReady;
    TreeNode        root; 
}
