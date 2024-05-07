import jakarta.xml.bind.annotation.XmlRootElement;

import java.util.LinkedList;
import java.util.List;

@XmlRootElement
public class GeburtstagSaver {
    private List<Geburtstag> geburtstage = new LinkedList<>();

    public GeburtstagSaver() {
    }

    public List<Geburtstag> getGeburtstage() {
        return geburtstage;
    }

    public void setGeburtstage(List<Geburtstag> geburtstage) {
        this.geburtstage = geburtstage;
    }
}
