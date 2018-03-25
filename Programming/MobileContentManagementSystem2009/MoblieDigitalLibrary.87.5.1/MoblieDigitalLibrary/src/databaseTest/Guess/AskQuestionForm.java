package databaseTest.Guess;

import javax.microedition.lcdui.*;

public class AskQuestionForm extends Form implements CommandListener { 
    Answer callback;   // Answer dar asle hamani ast ke Dialog piade mikonad
    
    AskQuestionForm(Guess midlet, String question, Answer callback) { 
        super("Question");
        this.callback = callback;// dar farakhani gerefte mishavad
        append(new StringItem(null, question + '?'));
        addCommand(Guess.YES_CMD); // ezafe kardane command be yek safhe
        addCommand(Guess.NO_CMD);
        setCommandListener(this);
        Display.getDisplay(midlet).setCurrent(this);
    }
 
    public void commandAction(Command c, Displayable d) 
    {
        callback.answer(c == Guess.YES_CMD);   //farakhani answer   ba in soal ke aya yes zade shode ya kheir
    }
}
    