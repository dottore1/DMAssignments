package dk.sdu.mmmi.dm.healthos.domain;

/**
 *
 * @author Oliver Nordestgaard | olnor18
 */
public class Bed {
    private int id;
    private String bed_number;

    public Bed(int id, String bed_number){
        this.id = id;
        this.bed_number = bed_number;
    }


    public Bed(String bed_number){
        this.bed_number = bed_number;
    }


    public int getId() {
        return id;
    }

    public String getBed_number() {
        return bed_number;
    }


    @Override
    public String toString() {
        return "Bed {" + "id=" + getId() + " Bed number=" + getBed_number();
    }
}
