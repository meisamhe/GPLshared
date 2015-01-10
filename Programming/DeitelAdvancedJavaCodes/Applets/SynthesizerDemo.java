/**
 * @(#)SynthesizerDemo.java
 * Um exemplo de como criar sons utilizando midi
 */

import javax.sound.midi.ShortMessage; 
import javax.sound.midi.Synthesizer; 
import javax.sound.midi.Receiver; 
import javax.sound.midi.MidiSystem; 
import javax.sound.midi.MidiUnavailableException; 
import javax.sound.midi.InvalidMidiDataException; 
import javax.sound.midi.Instrument;


public class SynthesizerDemo { 
    private ShortMessage message = new ShortMessage(); 
    private Synthesizer synth; 
    private Receiver receiver; 

    
    /** Construtor */
    public SynthesizerDemo() { 
        try { 
            synth = MidiSystem.getSynthesizer(); 
            synth.open(); 
            receiver = synth.getReceiver(); 
        } catch (MidiUnavailableException e) { 
            e.printStackTrace(); 
        } //catch
    } //Construtor


    /**
     * Toca uma nota 
     * @param note      nota a ser tocada
     * @param duration  tempo de duração da nota
     */
    public void playNote(int note, int duration) { 
        setShortMessage(ShortMessage.NOTE_ON, note); 
        receiver.send(message, -1); 
        try { 
            Thread.sleep(duration); 
        } catch (InterruptedException e) { 
            e.printStackTrace(); 
        }  //catch
        setShortMessage(ShortMessage.NOTE_OFF, note); 
        receiver.send(message, -1); 
    }  //playNote

    
    /**
     * Modifica o instrumento
     * @param instrument  identificação do instrumento
     */
    public void setInstrument(int instrument) { 
        synth.getChannels()[0].programChange(instrument); 
    } //setInstrument
     
    
    private void setShortMessage(int onOrOff, int note) { 
       try { 
           message.setMessage(onOrOff, 0, note, 70); 
       } catch (InvalidMidiDataException e) { 
           e.printStackTrace(); 
       } //catch
    } //setShortMessage
     
    
    public void playOctave(int baseNote) { 
        for (int i = 0; i < 13; i++) { 
            playNote(baseNote + i, 200); 
        } //for
    } //playOctave
    
    
    /** Imprime a lista de instrumentos disponíveis */
    public int printInstrumentsList() {
         Instrument[] instrument = synth.getAvailableInstruments();
         for (int i=0; i<instrument.length; i++) 
             System.out.println(i + "   " + instrument[i].getName());
         
         return instrument.length;
    } //printInstrumentsList    


    /** Retorna a lista de instrumentos disponíveis*/
    public Instrument[] getInstrumentsList() {
         Instrument[] instrument = synth.getAvailableInstruments();
         
         return instrument;
    } //printInstrumentsList    
    
    
    /** Programa principal */
    public static void main(String[] args) { 
         SynthesizerDemo synth = new SynthesizerDemo(); 
         
         /** imprime uma lista dos instrumentos disponíveis */
         int numberInstruments = synth.printInstrumentsList();
         
         /** testa os instrumentos (410 no meu teste) */ 
         for (int i=0; i<numberInstruments; i++) { 
              synth.setInstrument(i);  /* modifica o instrumento */
              synth.playOctave(60);  
         } //for    
         
         System.exit(0);
    } //main

} //class SynthesizerDemo