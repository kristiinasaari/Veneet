package model;

public class Vene {
	private int tunnus, hinta;
	private String nimi, merkkimalli, pituus, leveys;
	public Vene() {
		super();
	}
	
	public Vene(int tunnus, int hinta, String nimi, String merkkimalli, String pituus, String leveys) {
		super();
		this.tunnus = tunnus;
		this.nimi = nimi;
		this.merkkimalli = merkkimalli;
		this.pituus = pituus;
		this.leveys = leveys;
		this.hinta = hinta;
	}
	
	public int getTunnus() {
		return tunnus;
	}
	public void setTunnus(int tunnus) {
		this.tunnus = tunnus;
	}
	
	
	public String getNimi() {
		return nimi;
	}
	public void setNimi(String nimi) {
		this.nimi = nimi;
	}
	
	public String getMerkkimalli() {
		return merkkimalli;
	}
	public void setMerkkimalli(String merkkimalli) {
		this.merkkimalli = merkkimalli;
	}
	
	public String getPituus() {
		return pituus;
	}
	public void setPituus(String pituus) {
		this.pituus = pituus;
	}
	
	public String getLeveys() {
		return leveys;
	}
	public void setLeveys(String leveys) {
		this.leveys = leveys;
	}
	public int getHinta() {
		return hinta;
	}
	public void setHinta(int hinta) {
		this.hinta = hinta;
	}
	
	@Override
	public String toString() {
		return "Vene [tunnus=" + tunnus + ", hinta=" + hinta + ", nimi=" + nimi + ", merkkimalli=" + merkkimalli
				+ ", pituus=" + pituus + ", leveys=" + leveys + "]";
	}
	
}
