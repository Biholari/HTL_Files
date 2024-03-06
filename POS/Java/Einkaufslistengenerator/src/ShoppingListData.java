import jakarta.xml.bind.annotation.*;
import jakarta.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import java.io.Serializable;
import java.util.TreeMap;

@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class ShoppingListData implements Serializable {
    private final TreeMap<String, Integer> shoppingListData = new TreeMap<>();

    public ShoppingListData() {
        // Default constructor
    }

    public TreeMap<String, Integer> getShoppingListData() {
        return shoppingListData;
    }

    public void clearShoppingListData() {
        shoppingListData.clear();
    }
}
