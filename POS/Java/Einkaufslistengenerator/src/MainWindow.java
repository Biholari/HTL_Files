import jakarta.xml.bind.*;

import javax.swing.*;
import java.util.*;
import java.io.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.table.DefaultTableModel;

public class MainWindow extends JFrame {
    private JPanel mainPanel;
    private JComboBox keySelector;
    private JComboBox itemSelector;
    private JTextField customItem;
    private JSlider amountSlider;
    private JButton addButton;
    private JButton deleteButton;
    private JTable shoppingList;
    private JButton sortButton;
    private JButton printButton;
    private HashMap<String, LinkedList<String>> data = new HashMap<>();
    private ShoppingListData shoppingListData = new ShoppingListData();
    private int amount = amountSlider.getValue();

    public MainWindow() {
        setTitle("Hello World");
        setSize(300, 200);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setContentPane(mainPanel);
        pack();

        DefaultTableModel model = (DefaultTableModel) shoppingList.getModel();

        JMenuBar mb = new JMenuBar();
        JMenuItem newItem = new JMenuItem("Neu");
        JMenuItem saveItem = new JMenuItem("Speichern");
        JMenuItem loadItem = new JMenuItem("Laden");

        newItem.addActionListener(e -> {
            shoppingListData.clearShoppingListData();
            model.setRowCount(0);
        });

        saveItem.addActionListener(e -> {
            // Open file dialog
            JFileChooser fileChooser = new JFileChooser();
            fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);

            if (fileChooser.showSaveDialog(this) == JFileChooser.APPROVE_OPTION) {
                File directory = fileChooser.getCurrentDirectory();
                File xmlFile = new File(directory, "shoppingList.xml");

                try {
                    JAXBContext cx = JAXBContext.newInstance(ShoppingListData.class);
                    Marshaller marshaller = cx.createMarshaller();
                    marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
                    marshaller.marshal(shoppingListData, xmlFile);
                } catch (JAXBException ex) {
                    throw new RuntimeException(ex);
                }
            }
        });

        loadItem.addActionListener(e -> {
            // Open file dialog
            JFileChooser fileChooser = new JFileChooser();
            fileChooser.setFileFilter(new FileNameExtensionFilter("XML files", "xml"));
            shoppingListData.clearShoppingListData();

            if (fileChooser.showSaveDialog(this) == JFileChooser.APPROVE_OPTION) {
                File xmlFile = fileChooser.getSelectedFile();

                try {
                    JAXBContext cx = JAXBContext.newInstance(ShoppingListData.class);
                    Unmarshaller unmarshaller = cx.createUnmarshaller();
                    shoppingListData = (ShoppingListData) unmarshaller.unmarshal(xmlFile);
                    model.setRowCount(0);
                    for (String i : shoppingListData.getShoppingListData().keySet()) {
                        model.addRow(new Object[]{i, shoppingListData.getShoppingListData().get(i)});
                    }

                    model.fireTableDataChanged();
                } catch (JAXBException ex) {
                    throw new RuntimeException(ex);
                }
            }
        });

        keySelector.addActionListener(e -> {
            itemSelector.removeAllItems();
            for (String item : data.get(keySelector.getSelectedItem())) {
                itemSelector.addItem(item);
            }
            pack();
        });

        mb.add(newItem);
        mb.add(saveItem);
        mb.add(loadItem);

        setJMenuBar(mb);

        amountSlider.addChangeListener(e -> {
            amount = amountSlider.getValue();
            pack();
        });

        addButton.addActionListener(e -> {
            String item = (String) itemSelector.getSelectedItem();
            if (!customItem.getText().isEmpty()) {
                item = customItem.getText();
            }

            if (shoppingListData.getShoppingListData().containsKey(item)) {
                shoppingListData.getShoppingListData().put(item, shoppingListData.getShoppingListData().get(item) + amount);
            } else {
                shoppingListData.getShoppingListData().put(item, amount);
            }

            model.setRowCount(0);
            for (String i : shoppingListData.getShoppingListData().keySet()) {
                model.addRow(new Object[]{i, shoppingListData.getShoppingListData().get(i)});
            }

            pack();
        });

        shoppingList.getSelectionModel().addListSelectionListener(e -> deleteButton.setEnabled(shoppingList.getSelectedRows().length > 0));

        // If >1 items, remove selected items
        deleteButton.addActionListener(e -> {
            var shoppingListData = this.shoppingListData.getShoppingListData();
            int[] selectedRows = shoppingList.getSelectedRows();
            for (int i = selectedRows.length - 1; i >= 0; i--) {
                shoppingListData.remove(model.getValueAt(selectedRows[i], 0));
                model.removeRow(selectedRows[i]);
            }
            pack();
        });

        sortButton.addActionListener(e -> {
            // Sort Descending
            model.setRowCount(0);
            shoppingListData.getShoppingListData().entrySet().stream()
                    .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                    .forEach(ee -> model.addRow(new Object[]{ee.getKey(), ee.getValue()}));
            pack();
        });

        printButton.addActionListener(e -> {
            try {
                shoppingList.print(JTable.PrintMode.NORMAL, null, null, true, null, true);
            } catch (Exception ex) {
                throw new RuntimeException(ex);
            }
        });

        // Add headers to the table
        model.addColumn("Produkt");
        model.addColumn("Menge");
    }

    private void fillComboBox() {
        for (String key : data.keySet()) {
            keySelector.addItem(key);
        }
        for (String item : data.get(keySelector.getSelectedItem())) {
            itemSelector.addItem(item);
        }
    }

    public void setData(HashMap<String, LinkedList<String>> mappedFile) {
        this.data = mappedFile;
        fillComboBox();
    }
}
