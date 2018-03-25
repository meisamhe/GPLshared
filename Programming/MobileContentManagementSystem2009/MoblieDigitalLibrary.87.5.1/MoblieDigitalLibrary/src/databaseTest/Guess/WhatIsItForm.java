package databaseTest.Guess;

import javax.microedition.lcdui.*;

public class WhatIsItForm extends Form implements CommandListener { 
    Guess     midlet;
    TextField animal;
    TextField difference;
    TreeNode  parent;    //parent is the reference to previous node
    NewNodeCallback action;    // in ham baraye anjame amale call back dar piade sazi haye mokhtalef estefade mishe
    
    static final int YES = 0;
    static final int NO = 1;

    WhatIsItForm(Guess midlet, TreeNode parent, NewNodeCallback action) { 
        super("New animal");
        this.midlet = midlet;
        this.action = action;
        this.parent = parent;
        animal = new TextField("What is it", "", 32, TextField.ANY);
        difference = new TextField("What is a difference from others", "", 32, TextField.ANY);
        append(animal);
        append(difference);
        addCommand(Guess.QUIT_CMD);
        addCommand(Guess.DONE_CMD);
        setCommandListener(this);
        Display.getDisplay(midlet).setCurrent(this);
    }
 
    public void commandAction(Command c, Displayable d) 
    {
        if (c == Guess.QUIT_CMD) { 
            midlet.quit();
        } else if (c == Guess.DONE_CMD) {
            action.callback(new TreeNode(parent, difference.getString(), new TreeNode(null, animal.getString(), null)));
            Display.getDisplay(midlet).setCurrent(midlet.areYouReady);
        }
    }
}                    // dar dafeye aval root ra set mikonad, dafehaye digar samte chapash ezafe mikonad
                    // samte chap ke samte No hast mitavanest hich chizi nabashad    