import java.awt.*;

public class CaixaAWT extends Frame {

  public CaixaAWT() {
    // Cria o objeto - Obs. Terceiro argumento pode ser LOAD ou SAVE
    FileDialog d = new FileDialog(this, "Salva Arquivo de Nota", FileDialog.SAVE);
    // Define o diretório inicial
    d.setDirectory("");
    // Se tiver um nome de arquivo Default
    d.setFile("teste.not");
    // Exibe a caixa
    d.show();
    // Método getFile pega o arquivo selecionado
    if (d.getFile() != null) {
      System.out.println("O arquivo é " + d.getDirectory() + d.getFile());
    }
    System.exit(0);
  }

  public static void main(String args[]) {
    CaixaAWT janela = new CaixaAWT();
  }
}
