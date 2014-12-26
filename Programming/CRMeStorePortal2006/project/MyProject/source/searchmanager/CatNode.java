package searchmanager;

public class CatNode {
	private String name;
	private int index;
	private int parIndex;
	public CatNode(String name, int parIndex, int index){
		this.name=name;
		this.index=index;
		this.parIndex=parIndex;
	}
	public int getParentIndex(){
		return parIndex;
	}
	public int getIndex(){
		return index;
	}
	public String getName(){
		return name;
	}
	public String toString(){
		return getName();
	}
}
