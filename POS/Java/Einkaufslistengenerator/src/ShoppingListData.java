import jakarta.xml.bind.annotation.*;

import java.util.Map;
import java.util.HashMap;

@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class ShoppingListData {
    private HashMap<String, Integer> shoppingListData = new HashMap<>();

    public ShoppingListData() {
        // Default constructor
    }

    public HashMap<String, Integer> getShoppingListData() {
        return shoppingListData;
    }

    public void clearShoppingListData() {
        shoppingListData.clear();
    }
}
